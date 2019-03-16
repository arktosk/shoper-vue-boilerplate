import gulp from 'gulp';

import transformStream from '../utilities/transformStream';

import '../../config/env.config';

const smartyGlob = [
    `src/scripts/${process.env.PROJECT_NAME}/**/*.tpl`
];
const transformSmartyTemplate = (path) => {
    return gulp.src(path)
        // .pipe(resolveSnippets())
        .pipe(transformStream('./build/scripts'));
}

const transformSmartyTemplates = (done) => {
    return transformSmartyTemplate(smartyGlob);
}
transformSmartyTemplates.displayName = `transform:tpl`;
transformSmartyTemplates.description = `Transform smarty templates and resolve HTML snippets.`;