import tap from 'gulp-tap';

import cache from './cache';

/**
 * Change virtual files base path to build directory and save them in cached memory.
 * Helps uploading files by WebDAV protocol.
 * 
 * @param {Boolean} memorize - Should this file be memorized?
 */
// TODO: Rename function to be more understandable (e.g. moveToBuildDirectory).
const transformStream = (memorize = true) => {
    return tap((file) => {
        // TODO: Find way to do this more programmatically
        file.dirname = `${file.cwd}/build/styles`;
        file.base = `${file.cwd}/build`;
        file.stem = `${process.env.PROJECT_NAME}-${file.stem}`;

        if (memorize) cache.add(file);
    })
}

export default transformStream
