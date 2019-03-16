import cache from './utilities/cache';

import { devServer } from './tasks/runDevServer';

const deployFiles = function (done) {
    return cache.getFilesStream()
        .pipe(plumber())
        // .pipe(webdav(webDavConfig()))
        .pipe(devServer.stream())
        .on('end', done);
}
deployFiles.displayName = `deploy:cache`;
deployFiles.description = `Deploy all cached files.`;

export {
    deployFiles as default,
}
