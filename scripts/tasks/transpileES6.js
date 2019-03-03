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
 * Basing on webpack node API documentation and solution foud at webpack-to-memory package.
 * @see https://webpack.js.org/api/node/#custom-file-systems
 * @see https://github.com/knpwrs/webpack-to-memory
 */
const transpileES6 = (done) => {
    compiler.run((error, stats) => {
        if (error) return done ? done(error) : console.log(error)

        const files = Object.keys(stats.compilation.assets);
        const outputPath = compiler.outputPath;

        files.map(fileName => {
            if (!stats.compilation.assets[fileName].emitted) return;
            let filePath = fs.join(outputPath, fileName);
            if (filePath.indexOf('?') !== -1) {
                filePath = filePath.split('?')[0];
            }
            const src = fs.readFileSync(filePath);
            
            // Add file to cache.
            cache.add(new Vinyl({
                // cwd: '/',
                base: outputPath,
                path: path.join(outputPath, fileName),
                contents: src
            }));
        })
        
        done();
    });
}

export default transpileES6;
