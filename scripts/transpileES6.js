export const transpileES6 = done => {
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