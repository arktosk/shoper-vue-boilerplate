import fs from 'fs';
import { argv } from 'yargs';
import dotenv from 'dotenv';
import paths from './paths.config';

/**
 * Check is .enf file exists.
 * @todo - If there is no file logic should block some tasks, like deploy, watch, etc.
 */
if (!fs.existsSync(paths.dotenv)) {
    let missingEnvError = new Error( `Missing .env file. See details in README file.` )
    missingEnvError.showStack = false;
    throw missingEnvError
}

/**
 * Parse .env file and assign all properties to process.env.
 */
const envConfig = dotenv.config({path: paths.dotenv});

/**
 * Check is WebDav credentials are specified, otherwise block deploy tasks.
 */
if ( !process.env.WEBDAV_HOSTNAME || !process.env.WEBDAV_USER || !process.env.WEBDAV_PASSWORD ) {
    let missingEnvConfigError = new Error( `Missing config in .env file. See details in README file.` )
    missingEnvConfigError.showStack = false;
    throw missingEnvConfigError
}

/**
 * Set default project variables.
 */
process.env = process.env || {};
if (argv.development || (argv.mode && argv.mode === 'development')) process.env.NODE_ENV = 'development';
else process.env.NODE_ENV = 'prodution';

if (!process.env.PROJECT_NAME) process.env.PROJECT_NAME = 'template-bootstrap-by-cube-11';

const config = { env: {} };
for (let configLabel in process.env) {
    if (!envConfig.parsed.hasOwnProperty(configLabel)) continue;
    const newLabel = configLabel.toLowerCase().replace(/_([a-z])/g, g => g[1].toUpperCase())
    config.env[newLabel] = envConfig.parsed[configLabel]
}

export default config.parsed