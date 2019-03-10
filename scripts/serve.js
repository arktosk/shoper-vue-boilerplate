import gulp from 'gulp';
import { initialBuild } from './build';
import watch from './watch';
import runDevServer, { devServer } from './tasks/runDevServer';

/**
 * Start development environment with local server and run watchers.
 * @param {Function} done - Finishing callback function.
 */
const serve = (done) => {
    /** Setup environment for local development server. */
    process.env.VIRTUAL_OUTPUT = true;

    return gulp.series(
        initialBuild,
        runDevServer,
        watch
    )(done)
}
serve.displayName = `serve`;
serve.description = `Start development environment with local server and run watchers.`;
serve.flags = {
    ' ': `on default deployed will be only smarty template files, which as the only ones, can not be injected to local dev-server.`,
    '--safe': 'run watchers without any deploy of the results (suitable to production changes)',
    '--full-sync': 'run watchers and deploy every changed file',
};

export default serve