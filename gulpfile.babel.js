/**
 * Gulpfile for building Shoper front end applications
 * Added support for WebDAV connection with Shoper virtual templates folder.
 * 
 * @name      ShoperVueBoilerplate
 * @author    Arkadiusz Krauzowicz | cube11
 * 
 * @license   MIT
 * @copyright Arkadiusz Krauzowicz
 */

import fs            from 'fs'
import dotenv        from 'dotenv'
import glob          from 'glob'
import gulp          from 'gulp'
import gutil         from 'gulp-util'
import using         from 'gulp-using'
import tap           from 'gulp-tap'
import flatmap       from 'gulp-flatmap'
import rename        from 'gulp-rename'
import replace       from 'gulp-string-replace'
import webdav        from 'gulp-webdav-sync'
import plumber       from 'gulp-plumber'

import webpack       from 'webpack-stream'
import webpackConfig, { entryFiles as webpackEntry } from './webpack.config.js'
import sourcemaps    from 'gulp-sourcemaps'

import less          from 'gulp-less'
import autoprefixer  from 'gulp-autoprefixer'
import combineMQ     from 'gulp-combine-mq'

import imagemin      from 'gulp-imagemin'

import BrowserSync   from 'browser-sync'
const browserSync = BrowserSync.create()
dotenv.config()
const config = {
    projectName: process.env.PROJECT_NAME || 'template',

    buildType: process.env.BUILD_MODE || 'production', // "production" | "development"
    cleanFlag: false,

    WebDAV: false,
    uploadSource: false, // Uploads every file

    webpack: webpackConfig,
}

/**
 * If .env file contains credentials allow estabilish WebDAV connection.
 */
if ( process.env.WEBDAV_TEMPLATE_NAME && process.env.WEBDAV_USER && process.env.WEBDAV_PASSWORD && process.env.WEBDAV_HOSTNAME ) {
    const WebDAV = {
        protocol: 'https:',
        auth: {
            user: process.env.WEBDAV_USER,
            pass: process.env.WEBDAV_PASSWORD,
        },
        hostname: process.env.WEBDAV_HOSTNAME,
        port: process.env.WEBDAV_PORT || 443,
        pathname: `/webapi/webdav/${ process.env.WEBDAV_TEMPLATE_NAME }/`,
        log: 'log',            // Show status codes. error | warn | info | log
        logAuth: false,         // Show credentials in urls, works only when is turn off!
        uselastmodified: false, // Workaround to force file upload. When turn off, only create new file without rewrite old ones.
        base: `${process.cwd()}/src`
    };
    config.WebDAV = WebDAV;
}

/************************************************************/

const transpileES6 = done => {
    webpack( config.webpack, ( error, stats ) => {
        let pluginError
        if ( error ) {
            pluginError = new gutil.PluginError( 'webpack', error )

            if ( done ) done( pluginError )
            else gutil.log( '[webpack]', pluginError )
            
            return
        }
        if ( done ) done()
    } );
}

/**
 * Deploy transpiled JS on server.
 * @param {Stream} callback 
 */
const deployJS = callback => {
    if ( ! config.WebDAV ) {
        return callback()
    }

    return gulp.src( `./src/js/**/*.webpack.js` )
        .pipe( plumber( {
            errorHandler: errorHandler
        } ) )
        .pipe( webdav( config.WebDAV ) )
}

/**
 * Transpile ES6 by Webpack.
 */
const makeJS = gulp.series(
    transpileES6,
    deployJS,
)
makeJS.description = `Transpile ES6 by Webpack` + ( config.WebDAV ? ` and upload final files using WebDAV.` : '.' )

const watchJS = () => {
    /**
     * Deploy all JS files.
     * @fires WebDAVDeployFile
     * @todo Enable watch and deploy JS files.
     */
    if ( config.WebDAV ) {
        let jsFileGlob = [
            `./src/js/**/*.js`,
            `!./src/js/**/*.webpack.js`,
        ];
        
        /**
         * Do not upload source files if flag is false.
         */
        if ( ! config.uploadSource ) jsFileGlob.push( `!./src/js/${config.projectName}/**/*.js` )

        gulp.watch( jsFileGlob ).on( 'change', WebDAVDeployFile )
    }

    /**
     * Transpile ES6 and upload when any js file changes.
     * @fires webdav.deploy
     */
    gulp.watch( [
        `!./src/js/${config.projectName}/*.webpack.js`,
        `./src/js/${config.projectName}/**/*.js`,
    ], makeJS )
}

/**
 * Watch all files.
 */
const defaultTask = done => {
    browserSync.init({
        proxy: "http://devshop-829714.shoparena.pl/",
        rewriteRules: [
            {
                match: /Twój sklep internetowy/g,
                fn: function (req, res, match) {
                    return 'Vuetified';
                }
            }
        ]
    });

    webpack(config.webpack, require('webpack'), (err, stats) => {
        // console.log(stats)
    })
    // gulp.src('*')
    //     .pipe(webpack(config.webpack))
        .pipe(webdav(config.WebDAV))
        // .pipe(flatmap((stream, file) => {
        //     return stream
        //         .pipe(webdav(config.WebDAV))
        // }))
        // .pipe(webdav(config.WebDAV))
    done()
}


/************************************************************/

export {
    defaultTask as default,
    makeJS      as js,
}

/************************************************************/

/**
 * Handle error by logging them in the terminal.
 * 
 * @param {Error} error Error.
 */
function errorHandler( error ) {
    gutil.log( gutil.colors.red( error.toString() ) );
    // gutil.log( '\r\n' + error.codeFrame );
    // this.emit( 'end' );
}

/**
 * Upload file by its path using WebDAV protocol.
 * 
 * @param {String} path Path to file.
 * @returns {Stream} Gulp stream.
 */
function WebDAVDeployFile( path ) {
    gutil.log( path )
    let headerReplacer = false
    if (path.indexOf('header.tpl') !== -1) headerReplacer = true
    const src = gulp.src( [ `./${path}` ] )
        .pipe( plumber( {
            errorHandler: errorHandler
        } ) )
    if (headerReplacer) {
        src.pipe( replace( '<!-- template-scripts-needle -->', () => {
            let html = ''
            
            for (const outputFile of glob.sync(`./js/${config.projectName}-*.webpack.js`)) {
                html += `    <script type="text/javascript" src="{$path}${outputFile.replace(/^\./, '')}"></script>\n`
            }
            return html
        }) )
    }
    return src
        .pipe( webdav( config.WebDAV ) )
        .pipe( using( { prefix:'WebDAV', color:'green' } ) )
}

/**
 * Upload image by its path using WebDAV protocol.
 * 
 * @param {String} path Path to file.
 * @returns {Stream} Gulp stream.
 */
function WebDAVDeployImage( path ) {
    return gulp.src( [ `./${path}` ] )
        .pipe( plumber( {
            errorHandler: errorHandler
        } ) )
        .pipe( imagemin() )
        .pipe( using( { prefix:'minified', color:'yellow' } ) )
        .pipe( webdav( config.WebDAV ) )
        .pipe( using( { prefix:'WebDAV', color:'green' } ) )
}