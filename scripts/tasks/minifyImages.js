import gulp from 'gulp';
import imagemin from 'gulp-imagemin';

import transformStream from '../utilities/transformStream';

const minifyImage = (path) => {
    return gulp.src([`./${path}`])
        .pipe(imagemin())
        .pipe(transformStream('./build/images'));
};

const minifyImages = (done) => {
    return minifyImage(`src/images/**/*.{gif,jpg,png}`)
};
minifyImages.displayName = `minify:img:all`;
minifyImages.description = `Optimize and minify all images.`;

export {
    minifyImages as default,
    minifyImage,
    minifyImages,
};
