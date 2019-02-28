/**
 * WebDAV helper function creates the config Object.
 */
const webDavConfig = ( logLevel = 'info' ) => {
    if ( !process.env.WEBDAV_USER || !process.env.WEBDAV_PASS || !process.env.WEBDAV_HOST ) {
        let missingEnvError = new Error( `Missing .env file or config failure. See details in README.` )
        missingEnvError.showStack = false;
        throw missingEnvError
    }
    const webDavConfig = {
        protocol: 'https:',
        auth: {
            user: process.env.WEBDAV_USER,
            pass: process.env.WEBDAV_PASS,
        },
        hostname: process.env.WEBDAV_HOST,
        port: process.env.WEBDAV_PORT || 443,
        pathname: `/webapi/webdav/${ templateConfig.name }/`,
        log: logLevel,          // Log levels: error | warn | info | log
        logAuth: false,         // Show credentials in urls, works only when is turn false! When is true WebDAV throw parser error.
        uselastmodified: false, // Workaround to force file upload. When turn off, only create new file without rewrite old ones.
    }
    return webDavConfig
}