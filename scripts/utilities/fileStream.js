import through from 'through2';

/**
 * Create stream from Vinyl files array.
 * 
 * @param {Array} files - Array of Vinyl virtual files.
 */
const fileStream = function (files) {
    const stream = through.obj(
        (chunk, enc, done) => done(null, chunk),
        function end(done) {
            for (let fileName in files) {
                if (!files.hasOwnProperty(fileName)) continue;
                const file = files[fileName];
                this.push(file);
                this.emit('data', file);
            }

            this.emit('end');
            done();
        }
    )
    stream.end();
    return stream;
}

export default fileStream