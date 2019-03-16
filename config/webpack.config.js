import dotenv from 'dotenv';
import webpack from 'webpack';
import path from 'path';
import glob from 'glob';

import UglifyJsPlugin from 'uglifyjs-webpack-plugin';
import { VueLoaderPlugin } from 'vue-loader';

import './env.config';
import paths from './paths.config';

dotenv.config();
const projectName = process.env.PROJECT_NAME || 'template';

const entryFiles = {}
for (const entryFilePath of glob.sync(`./src/js/${projectName}/*.js`)) {
    entryFiles[path.basename(entryFilePath, '.js')] = entryFilePath
}

const internalCache = {}

let config = {
    entry: entryFiles,
    mode: process.env.NODE_ENV,
    devtool: "eval",
    cache: internalCache,
    output: {
        path: paths.templateBuild,
        publicPath: 'skins/user/rwd_shoper_1/',
        filename: `js/${projectName}-[name].webpack.js`,
    },
    resolve: {
        extensions: ['.js', '.json', '.vue'],
    },
    module: {
        rules: [{
                test: /\.vue$/,
                loader: 'vue-loader',
                exclude: /node_modules/,
            },
            {
                test: /\.js$/,
                loader: 'babel-loader',
                exclude: /node_modules/,
            },
            {
                test: /\.less$/,
                use: [
                    'vue-style-loader',
                    'css-loader',
                    'less-loader'
                ]
            }
        ]
    },
    optimization: {
        minimize: (process.env.NODE_ENV === 'production') ? true : false,
        minimizer: [
            new UglifyJsPlugin({
                include: /\.js$/
            }),
        ]
    },
    plugins: [
        new webpack.DefinePlugin({
            // __MODE__: JSON.stringify(mode),
        }),
        new VueLoaderPlugin()
    ],
};

export {
    config as default,
    entryFiles,
}