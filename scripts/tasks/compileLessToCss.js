import gulp from 'gulp';
import tap from 'gulp-tap';
import less from 'gulp-less';
import sourcemaps from 'gulp-sourcemaps'
import autoprefixer from 'gulp-autoprefixer'
import combineMQ from 'gulp-combine-mq'
import cleanCSS from 'gulp-clean-css'

import cache from '../utilities/cache'

/**
 * Process Less files, autoprefix them and clean final CSS.
 * Then store it in cache for further use.
 * 
 * @param {Function} done - Callback function, which determine end of the task.
 * 
 * @see https://fettblog.eu/gulp-4-sourcemaps/
 */
const compileLessToCss = (done) => {
    const stylesGlob = [
        `./src/styles/${process.env.PROJECT_NAME}/*.less`
    ];

    return gulp
        /** Add source maps only in development mode. */
        .src(stylesGlob)
        .pipe(sourcemaps.init())
        .pipe(less())
        .pipe(autoprefixer())
        .pipe(combineMQ())
        .pipe(cleanCSS())
        .pipe(sourcemaps.write())
        .pipe(tap((file) => {
            file.dirname = `${file.cwd}/build/styles`;
            file.base = `${file.cwd}/build`;
            file.stem = `${process.env.PROJECT_NAME}-${file.stem}`;
            cache.add(file);
        }));
}
compileLessToCss.displayName = `build:css`;
compileLessToCss.description = `Process Less files, autoprefix them and clean final CSS.`;

export default compileLessToCss;
