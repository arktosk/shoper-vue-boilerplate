import path from 'path';
import Vinyl from 'vinyl';
import webpack from 'webpack';
import MemoryFileSystem from 'memory-fs';

import cache from '../utilities/cache';

import paths from '../../config/paths.config';
import webpackConfig from '../../config/webpack.config';

/**
 * Use MemoryFileSystem for storing compiled files in cache
 * and do not saving it on drive.
 */
const fs = new MemoryFileSystem();
const compiler = webpack(webpackConfig);
compiler.outputFileSystem = fs;

/**
 * Transpile Java Script files by webpack.
 * Then store it in cache for further use.
 * 
 * @param {Function} done - Callback function, which determine end of the task.
 * 
 * Based on webpack node API documentation and solution found at webpack-to-memory package.
 * @see https://webpack.js.org/api/node/#custom-file-systems
 * @see https://github.com/knpwrs/webpack-to-memory
 */
const transpileES6 = (done) => {
    compiler.run((error, stats) => {
        if (error) return done ? done(error) : console.log(error)

        const assets = stats.compilation.assets
        const files = Object.keys(assets);

        files.map(fileName => {
            if (!assets[fileName]._value) return

            /**
             * Get Raw Source of compiled files instead of using MemoryFileSystem.
             */
            const fileRawSource = assets[fileName]._value
            
            const vinylFile = new Vinyl({
                base: paths.templateBuild,
                path: path.join(paths.templateBuild, fileName),
                contents: Buffer.from(fileRawSource)
            })

            cache.add(vinylFile);
        })
        done();
    });
}
transpileES6.displayName = `build:js`;
transpileES6.description = `Transpile Java Script files by webpack.`;

export default transpileES6;
