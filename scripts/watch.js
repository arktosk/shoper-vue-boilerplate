import gulp from 'gulp';
import plumber from 'gulp-plumber';
import webdav from 'gulp-webdav-sync';
import { argv } from 'yargs';

import cache from './utilities/cache';

import { devServer } from './tasks/runDevServer';
import compileLessToCss from './tasks/compileLessToCss';
import transpileES6 from './tasks/transpileES6';
import { minifyImage } from './tasks/minifyImages';

import webDavConfig from '../config/webdav.config';

const deployFiles = function (done) {
    return cache.getFilesStream()
        .pipe(plumber())
        // .pipe(webdav(webDavConfig()))
        .pipe(devServer.stream())
        .on('end', done);
}
deployFiles.displayName = `deploy:cache`;
deployFiles.description = `Deploy all cached files.`;

/**
 * Transpile ES6 when any js file changes.
 */
const watchJS = () => {
    return gulp.watch( [
        `!./src/js/${process.env.PROJECT_NAME}/*.webpack.js`,
        `./src/js/${process.env.PROJECT_NAME}/**/*.{js,vue}`,
    ], gulp.series(transpileES6, deployFiles));
}
watchJS.displayName = `watch:js`;
watchJS.description = `On every JS files change transpile new webpack bundle.`;

/**
 * Process css when any less file changes.
 */
const watchLESS = () => {
    return gulp
        .watch([`./src/styles/${process.env.PROJECT_NAME}/**/*.less`], gulp.series(compileLessToCss, deployFiles));
}
watchLESS.displayName = `watch:less`;
watchLESS.description = `On every LESS files change build new bundled CSS file.`;

const watchImages = () => {
    const watchCallback = (path) => {
        return minifyImage(path)
            .pipe(webdav(webDavConfig()))
    };
    return gulp
        .watch([`./src/images/**/*.{gif,jpg,png}`])
        // TODO: Find why after creating a new file "gulp-webdav-sync" throws Error [ERR_MULTIPLE_CALLBACK]: Callback called multiple times?
        .on('change', watchCallback);
}
watchImages.displayName = `watch:img`;
watchImages.description = `On every image change minify them.`;

const watchSmarty = () => {
    const watchCallback = (path) => {
        return transformSmartyTemplate(path)
            .pipe(webdav(webDavConfig()))
    };
    return gulp
        .watch([`./src/images/**/*.{gif,jpg,png}`])
        // TODO: Find why after creating a new file "gulp-webdav-sync" throws Error [ERR_MULTIPLE_CALLBACK]: Callback called multiple times?
        .on('change', watchCallback);
}
watchSmarty.displayName = `watch:tpl`;
watchSmarty.description = `Watch changes on smarty template files.`;

const watchAll = gulp.parallel(
    watchJS,
    watchLESS,
    watchImages
);
watchAll.displayName = `watch`;
watchAll.description = `Start watching template files for any changes.`;

export {
    watchAll as default,
    watchJS
}