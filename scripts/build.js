import gulp from 'gulp';
import tap from 'gulp-tap';
import compileLessToCss from './tasks/compileLessToCss';
import transpileES6 from './tasks/transpileES6';
import minifyImages from './tasks/minifyImages';

import cache from './utilities/cache';

const deployFiles = function (done) {
    return cache.getFilesStream()
        // .pipe(gulp.dest('./build'))
        .on('end', done);
}

/**
 * Compile and transpile source files to usable form.
 */
const initialBuild = gulp.series(
    transpileES6,
    compileLessToCss,
    minifyImages
)
initialBuild.displayName = `build:initial`;
initialBuild.description = `Compile and transpile source files to usable form.`;

/**
 * Compile source to build package.
 * @param {Function} done - Finishing callback function.
 */
const build = (done) => {
    const buildTasks = [
        initialBuild
    ]
    
    /**
     * Make sure that there is no VIRTUAL_OUTPUT flag.
     */
    if (!process.env.VIRTUAL_OUTPUT) buildTasks.push(deployFiles)

    return gulp.series(...buildTasks)(done)
}
build.displayName = `build`;
build.description = `Compile source to build package.`;
build.flags = {
    ' ': `on default creates production build`,
    '--development': 'creates development unminified package',
    '--production': 'creates production package with minified files and disabled development tools',
};

export {
    build as default,
    build,
    initialBuild,
}