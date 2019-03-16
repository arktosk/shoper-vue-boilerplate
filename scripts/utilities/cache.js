import path from 'path';
import paths from '../../config/paths.config';
import fileStream from './fileStream';

/**
 * Simple cache for template virtual files.
 * 
 * @method add - Add next file to cache
 * @method getFilesStream - Get stream with cached files to use with e.g gulp.
 */
class Cache {
    constructor () {
        this._queue = [];
        this._memory = {};
    }
    /**
     * Add virtual file to cached memory.
     * @param {Vinyl} file - Vinyl file instance.
     */
    add(file) {
        const relativePath = path.relative(paths.templateBuild, file.path);
        if (this._queue.indexOf(relativePath) !== -1) this._queue.splice(this._queue.indexOf(relativePath), 1);
        this._queue.push(relativePath);
        this._memory[relativePath] = file;
    }
    /**
     * Clear queue of recently added files.
     */
    clearQueue() {
        this._queue = [];
    }
    /**
     * Create stream from cached files.
     * @returns {Stream} - Stream filled with cached files to use e.g. with gulp.
     */
    getFilesStream() {
        const files = {};
        for (let i = 0 ; i < this._queue.length; i++) {
            const fileName = this._queue[i];
            files[fileName] = this._memory[fileName];
        }
        this._queue = [];
        return fileStream(files);
    }
}

/**
 * Create new instance of cache to use around the application.
 */
const cache = new Cache();

export default cache;
