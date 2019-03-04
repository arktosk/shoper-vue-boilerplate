import gulp from 'gulp';
import webdav from 'gulp-webdav-sync';

import cache from './utilities/cache';

import runDevServer from './tasks/runDevServer';
import compileLessToCss from './tasks/compileLessToCss';
import transpileES6 from './tasks/transpileES6';

import webDavConfig from '../config/webdav.config';

const task2 = function (done) {
    return cache.getFilesStream()
        .pipe(webdav(webDavConfig()))
        .on('end', done);
}

/**
 * Transpile ES6 when any js file changes.
 */
const watchJS = () => {
    return gulp.watch( [
        `!./src/js/${process.env.PROJECT_NAME}/*.webpack.js`,
        `./src/js/${process.env.PROJECT_NAME}/**/*.js`,
    ], gulp.series(transpileES6, task2));
}
watchJS.displayName = `watch:js`;
watchJS.description = `On every JS files change transpile new webpack bundle.`;

/**
 * Process css when any less file changes.
 */
const watchLESS = () => {
    return gulp
        .watch([`./src/styles/${process.env.PROJECT_NAME}/**/*.less`], compileLessToCss);
}
watchLESS.displayName = `watch:less`;
watchLESS.description = `On every LESS files change build new bundled CSS file.`;

const watchAll = gulp.series(
        gulp.parallel(
            transpileES6,
            compileLessToCss
        ),
        runDevServer, 
        gulp.parallel(
            watchJS,
            watchLESS
        )
    )

export {
    watchAll as default,
    watchJS
}