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

import dotenv        from 'dotenv'
import gulp          from 'gulp'
import gutil         from 'gulp-util'
import using         from 'gulp-using'
import rename        from 'gulp-rename'
import webdav        from 'gulp-webdav-sync'
import plumber       from 'gulp-plumber'

import webpack       from 'webpack'
import webpackConfig from './webpack.config.js'
import sourcemaps    from 'gulp-sourcemaps'

import less          from 'gulp-less'
import autoprefixer  from 'gulp-autoprefixer'
import combineMQ     from 'gulp-combine-mq'

import imagemin      from 'gulp-imagemin'

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
        log: 'info',            // Show status codes. error | warn | info | log
        logAuth: false,         // Show credentials in urls, works only when is turn off!
        uselastmodified: false, // Workaround to force file upload. When turn off, only create new file without rewrite old ones.
    };
    config.WebDAV = WebDAV;
}

/************************************************************/

/**
 * Compile LESS to CSS.
 */
const processLessToCSS = () => {

    var src = gulp.src( [
            `./styles/${config.projectName}/*.less`
        ] )
        .pipe( sourcemaps.init() )
        .pipe( plumber( {
            errorHandler: errorHandler
        } ) )
        .pipe( less( {
            globalVars: {
                maincolor: '#61dafb',
                bgcolor:   '#ffffff',
                fontcolor: '#000000',
                acolor:    '#333333',

                fontsize:  '16px',
            },
        } ) )

    // Write sourceMaps only in development mode
    if ( config.buildType === 'development' )
        src.pipe( sourcemaps.write() )

    src.pipe( autoprefixer() )
        .pipe( combineMQ() )

    if ( config.buildType === 'production' )
        src.pipe( cleanCSS() )

    src.pipe( rename( ( path ) => {
            let baseName = path.basename
            path.basename = `${config.projectName}-${baseName}`

            if ( config.buildType === 'production' ) path.extname = '.min' + path.extname
        } ) )
        .pipe( gulp.dest( `./styles` ) )

    return src
}

/**
 * Upload final CSS files on server.
 */
const deployCSS = ( callback ) => {
    let src = gulp.src( `./styles/${config.projectName}-*.css` )

    if ( ! config.WebDAV ) {
        return callback()
    }
    return src.pipe( plumber( {
            errorHandler: errorHandler
        } ) )
        .pipe( webdav( config.WebDAV ) )
        .pipe( using( { prefix:'WebDAV', color:'green' } ) )
}
deployCSS.description = `Upload final CSS files on server` + ( config.WebDAV ? ` using WebDAV protocol.` : '.' )

/**
 * Process Less files, autoprefix them and clean final CSS.
 * When WebDAV is active, files will be deployed on server.
 */
const makeCSS = gulp.series(
    processLessToCSS,
    deployCSS,
)
makeCSS.description = `Process Less files, autoprefix them and clean final CSS` + ( config.WebDAV ? ` then deploy on server using WebDAV.` : '.' )

/**
 * Set watchers for LESS files.
 */
const watchLess = () => {
    /**
     * Upload Less files when watch detects change.
     * 
     * @see WebDAVDeployFile
     */
    if ( config.WebDAV ) {
        let lessFileGlob = [
            './styles/**/*.less'
        ];
        
        /**
         * Do not upload source files if flag is false.
         */
        if ( ! config.uploadSource ) lessFileGlob.push( `!./styles/${config.projectName}/**/*.less` )

        gulp.watch( lessFileGlob ).on( 'change', WebDAVDeployFile )
    }

    /**
     * Process css and upload when any less file changes.
     * @fires makeCSS
     */
    gulp.watch( `./styles/${config.projectName}/**/*.less`, makeCSS )
}
watchLess.description = `Compile LESS files on a fly`  + ( config.WebDAV ? ` and deploy them using WebDAV.` : '.' )

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

    return gulp.src( `./js/**/*.webpack.js` )
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
            `./js/**/*.js`,
            `!./js/**/*.webpack.js`,
        ];
        
        /**
         * Do not upload source files if flag is false.
         */
        if ( ! config.uploadSource ) jsFileGlob.push( `!./js/${config.projectName}/**/*.js` )

        gulp.watch( jsFileGlob ).on( 'change', WebDAVDeployFile )
    }

    /**
     * Transpile ES6 and upload when any js file changes.
     * @fires webdav.deploy
     */
    gulp.watch( [
        `!./js/${config.projectName}/*.webpack.js`,
        `./js/${config.projectName}/**/*.js`,
    ], makeJS )
}

/**
 * Minify then upload images when detects changes.
 */
const watchImages = () => {
    /**
     * Minify and upload images.
     * @see WebDAVDeployImage
     */
    if ( config.WebDAV ) {
        gulp.watch( [
            './preview.{jpg,png}',     // Preview theme images.
            './images/**/*.{jpg,png}', // All template images.
        ] ).on( 'add', WebDAVDeployImage ).on( 'change', WebDAVDeployImage )
    }
}
watchImages.description = ( config.WebDAV ? `Minify then upload images when detects changes.` : 'Do nothing. Needs WebDAV connection for deploying images.' )

/**
 * Deploy Smarty template files when detects changes.
 */
const watchSmarty = () => {
    /**
     * Deploy Smarty template files.
     * @see WebDAVDeployFile
     */
    if ( config.WebDAV ) {
        gulp.watch( [
            './scripts/**/*.tpl', // Template files.
            './boxes/**/*.tpl',   // Box template files.
        ] ).on( 'change', WebDAVDeployFile )
    }
}
watchSmarty.description = ( config.WebDAV ? `Deploy Smarty template files when detects changes.` : 'Do nothing. Needs WebDAV connection for deploying Smarty template files.' )

/**
 * Watch all files.
 */
const watchAll = gulp.parallel(
    watchLess,
    watchJS,
    watchImages,
    watchSmarty
)

/**
 * Compile all styles and scripts then run watchers for instant deploy.
 */
const defaultTask = gulp.series( gulp.parallel( makeCSS, makeJS ), watchAll )
defaultTask.description = `Compile all styles and scripts then run watchers for instant deploy.`


/************************************************************/

export {
    defaultTask as default,
    makeCSS     as css,
    makeJS      as js,
    watchAll    as watch,
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
    return gulp.src( [ `./${path}` ] )
        .pipe( plumber( {
            errorHandler: errorHandler
        } ) )
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