import gulp from 'gulp';
import webdav from 'gulp-webdav-sync';

import cache from './utilities/cache';
import transpileES6 from './tasks/transpileES6';
import webDavConfig from '../config/webdav.config';

const task2 = function (done) {
    return cache.getFilesStream()
        .pipe(webdav(webDavConfig()))
        .on('end', done);
}

const watchJS = () => {
    /**
     * Transpile ES6 and upload when any js file changes.
     * @fires webdav.deploy
     */
    return gulp.watch( [
        `!./src/js/${process.env.PROJECT_NAME}/*.webpack.js`,
        `./src/js/${process.env.PROJECT_NAME}/**/*.js`,
    ], gulp.series(transpileES6, task2));
}

const watchAll = gulp.series(transpileES6, task2)

export {
    watchAll as default,
    watchJS
}