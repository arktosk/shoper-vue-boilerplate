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
        const relativePath = file.path.replace(paths.templateSrc, '');
        if (this._queue.indexOf(relativePath) !== -1) this._queue.splice(this._queue.indexOf(relativePath), 1);
        this._queue.push(relativePath);
        this._memory[relativePath] = file;
    }
    /**
     * Create stream from cached files.
     * @returns {Stream} - Stream filled with cached files to use e.g. with gulp.
     */
    getFilesStream() {
        const files = {};
        for (let i = 0 ; i < this._queue.length; i++) {
            files[this._queue[i]] = this._memory[this._queue[i]];
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
