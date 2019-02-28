// import path from 'path';
const path = require('path');

const templateDirectory = process.cwd()
const resolvePath = relativePath => path.resolve(templateDirectory, relativePath);

// export const paths = {
//     dotenv: resolveApp('.env'),
//     template: templateDirectory,
//     templateSrc: resolvePath('src'),
//     templateBuild: resolvePath('build'),
// };
module.exports = {
    dotenv: resolvePath('.env'),
    template: templateDirectory,
    templateSrc: resolvePath('src'),
    templateBuild: resolvePath('build'),
};