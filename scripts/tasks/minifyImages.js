import gulp from 'gulp';
import imagemin from 'gulp-imagemin';

import transformStream from '../utilities/transformStream';

const minifyImage = (path) => {
    return gulp.src([`./${path}`])
        .pipe(imagemin())
        .pipe(transformStream('./build/images'));
};
minifyImage.displayName = `minify:img`;
minifyImage.description = `Optimize and minify image.`;

const minifyImages = (done) => {
    return gulp.src([`./src/images/**/*.{gif,jpg,png}`])
        .pipe(imagemin())
        .pipe(transformStream('./build/images'))
};
minifyImages.displayName = `minify:img:all`;
minifyImages.description = `Optimize and minify all images.`;

export {
    minifyImages as default,
    minifyImage,
    minifyImages,
};
