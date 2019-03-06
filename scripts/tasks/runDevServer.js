import { argv } from 'yargs';
import BrowserSync   from 'browser-sync';

import cache from '../utilities/cache'

import envConfig from '../../config/env.config';

const devServer = BrowserSync.create()

/**
 * Initialize instance of Browser Sync server in proxy mode to display shop page.
 * 
 * @param {Function} done - Emit end of a task.
 */
const runDevServer = (done) => {
    devServer.init({
        open: argv.open !== undefined ? 'local' : false,
        // Note that proxy uses non SSL protocol, because of missing cert for localhost.
        proxy: `http://${process.env.WEBDAV_HOSTNAME}/`,
        middleware: [
            replaceFileContentMiddleware(),
        ],
    });
    devServer.emitter.on("init", () => {
        cache.clearQueue();
        done();
    });
}
runDevServer.displayName = `server:run`
runDevServer.description = `Initialize instance of Browser Sync server in proxy mode to display shop page.`
runDevServer.flags = {
    '--open': 'open new window or tab in a browser.'
};

/**
 * Helper function for creating middleware that replace project styles and scripts.
 * 
 * @returns {Function} - Server middleware handler.
 */
const replaceFileContentMiddleware = () => {
    return  (req, res, next) => {
        /** Filter early files by template main directory. */
        if (req.originalUrl.indexOf('/skins/user/rwd_shoper_1/') === -1) return next();
        /** Sanitize request url to mach cache schema. */
        let relativePath = req.originalUrl.replace('/skins/user/rwd_shoper_1/', '').replace('/', '\\');

        if (typeof cache._memory[relativePath] === 'undefined')  return next();

        /** If that file is already cached replace response. */
        res.end(cache._memory[relativePath].contents);
    }
};

export {
    runDevServer as default,
    devServer,
}
