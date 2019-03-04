import gulp from 'gulp';
import imagemin from 'gulp-imagemin';
import tap from 'gulp-tap';

import transformStream from '../utilities/transformStream';

const minifyImages = (path) => {
    return gulp.src( [ `./${path}` ] )
        .pipe(imagemin())
        .pipe(transformStream());
};
minifyImages.displayName = `minify:img`;
minifyImages.description = `Optimize and minify images.`;

export default minifyImages;
