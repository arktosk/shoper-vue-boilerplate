import paths from './paths.config';
import envConfig from './env.config';

/**
 * WebDAV helper function creates the config Object.
 * 
 * @param   {Object} customConfig - Custom config object overwriting default settings.
 * @returns {Object}              - Final WebDav config object
 */
const webDavConfig = (customConfig = {}) => {
    const _defaultConfig = {
        protocol: 'https:',
        auth: {
            user: process.env.WEBDAV_USER,
            pass: process.env.WEBDAV_PASSWORD,
        },
        hostname: process.env.WEBDAV_HOSTNAME,
        port: process.env.WEBDAV_PORT || 443,
        pathname: `/webapi/webdav/${process.env.WEBDAV_TEMPLATE_NAME}/`,
        base: paths.templateBuild,
        log: 'log',             // Log levels: error | warn | info | log
        logAuth: false,         // Show credentials in urls, works only when is turn false! When is true WebDAV throw parser error.
        uselastmodified: false, // Workaround to force file upload. When turn off, only create new file without rewrite old ones.
    };
    return (typeof customConfig === 'object') ? Object.assign(_defaultConfig, customConfig) : _defaultConfig;
}

export default webDavConfig;
