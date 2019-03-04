import BrowserSync   from 'browser-sync';
import envConfig from '../../config/env.config';

const devServer = BrowserSync.create()

/**
 * Initialize instance of Browser Sync server in proxy mode to display shop page.
 * 
 * @param {Function} done - Emmit end of a task.
 */
const runDevServer = (done) => {
    devServer.init({
        open: false, // false | 'local'
        // Note that proxy uses non SSL protocol, because of missing cert for localhost.
        proxy: `http://${process.env.WEBDAV_HOSTNAME}/`,
        middleware: [
            repleaceFileContentMiddleware(
                `/skins/user/rwd_shoper_1/js/vuetified-by-cube-11-test.webpack.js`,
                '"use strict";\nconsole.log("I am the new one!");\n'),
        ],
    });
    devServer.emitter.on("init", () => done());
}
runDevServer.displayName = `server:run`
runDevServer.description = `Initialize instance of Browser Sync server in proxy mode to display shop page.`
runDevServer.flags = {
    '-revoke': 'do not open new window or tab in a browser.'
};

/**
 * Helper function for creating middleware that replace project styles and scripts.
 * 
 * @param {*} fileName 
 * @param {*} newFileContent 
 * @returns {Function} - Middleware
 */
const repleaceFileContentMiddleware = (fileName, newFileContent) => {
    return  (req, res, next) => {
        if (req.originalUrl === fileName) res.end(newFileContent);
        else next();
    }
};

export {
    runDevServer as default,
    devServer,
}
