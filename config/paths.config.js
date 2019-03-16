import path from 'path';

const templateDirectory = process.cwd()
const resolvePath = relativePath => path.resolve(templateDirectory, relativePath);

export default {
    dotenv: resolvePath('.env'),
    template: templateDirectory,
    templateSrc: resolvePath('src'),
    templateBuild: resolvePath('build'),
};