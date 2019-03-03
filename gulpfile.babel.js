/**
 * Gulpfile for building Shoper front end applications
 * Added support for WebDAV connection with Shoper virtual templates folder.
 * 
 * @name      ShoperVueBoilerplate
 * @author    Arkadiusz Krauzowicz | cube11
 * 
 * @license   MIT
 * @copyright Arkadiusz Krauzowicz
 */
import runDevServer from './scripts/tasks/runDevServer';
import watch from './scripts/watch';

export {
    runDevServer as default,
    watch,
}