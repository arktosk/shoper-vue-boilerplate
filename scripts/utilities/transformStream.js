import path from 'path';
import tap from 'gulp-tap';

import cache from './cache';

import paths from '../../config/paths.config';

/**
 * Change virtual files base path to build directory and save them in cached memory.
 * Helps uploading files by WebDAV protocol.
 * 
 * @param {Boolean} memorize - Should this file be memorized?
 */
// TODO: Rename function to be more understandable (e.g. moveToBuildDirectory).
const transformStream = (buildPath = './build', memorize = true) => {
    return tap((file) => {
        // TODO: Find way to do this more programmatically
        // file.dirname = `${file.cwd}/build/styles`;

        if (['.css', '.js'].indexOf(file.extname) !== -1) {
            file.dirname = path.resolve(paths.template, buildPath);
        } else {
            const relativePath = path.relative(paths.templateSrc, file.dirname);
            buildPath = path.resolve(paths.templateBuild, relativePath);
            
            file.dirname = buildPath;
        }
        file.base = paths.templateBuild;

        /** Change names only for css and js files. */
        if (['.css', '.js'].indexOf(file.extname) !== -1)
            file.stem = `${process.env.PROJECT_NAME}-${file.stem}`;

        console.log(file.basename);
        if (memorize) cache.add(file);
    })
}

export default transformStream
