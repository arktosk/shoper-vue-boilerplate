import gulp from 'gulp';
import less from 'gulp-less';
import sourcemaps from 'gulp-sourcemaps'
import autoprefixer from 'gulp-autoprefixer'
import combineMQ from 'gulp-combine-mq'
import cleanCSS from 'gulp-clean-css'

import transformStream from '../utilities/transformStream';

import '../../config/env.config';

/**
 * Process Less files, autoprefix them and clean final CSS.
 * Then store it in cache for further use.
 * 
 * @param {Function} done - Callback function, which determine end of the task.
 * 
 * @see https://fettblog.eu/gulp-4-sourcemaps/
 */
const compileLessToCss = (done) => {
    const stylesGlobs = [
        `./src/styles/${process.env.PROJECT_NAME}/*.less`
    ];

    return gulp
        /** Add source maps only in development mode. */
        .src(stylesGlobs)
        .pipe(sourcemaps.init())
        .pipe(less())
        .pipe(gulp.src(`./src/styles/${process.env.PROJECT_NAME}/*.css`))
        .pipe(autoprefixer())
        .pipe(combineMQ())
        // .pipe(cleanCSS())
        .pipe(sourcemaps.write())
        .pipe(transformStream('./build/styles'));
}
compileLessToCss.displayName = `build:css`;
compileLessToCss.description = `Process Less files, autoprefix them and clean final CSS.`;

export default compileLessToCss;
