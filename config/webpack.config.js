import dotenv              from 'dotenv';
import webpack             from 'webpack';
import path                from 'path';
import glob                from 'glob';

import UglifyJsPlugin      from 'uglifyjs-webpack-plugin';
import { VueLoaderPlugin } from 'vue-loader';

import paths from './paths.config';

const env = process.env.NODE_ENV;

dotenv.config();
const mode = process.env.BUILD_MODE || 'production'; // "production" | "development"
const projectName = process.env.PROJECT_NAME || 'template';

const entryFiles = {}
for (const entryFilePath of glob.sync(`./src/js/${projectName}/*.js`)) {
  entryFiles[path.basename(entryFilePath, '.js')] = entryFilePath
}


let config = {
  entry: entryFiles,
  mode: mode,
  output: {
    path: paths.templateBuild,
    publicPath: 'skins/user/rwd_shoper_1/',
    filename: `js/${projectName}-[name].webpack.js`,
  },
  resolve: {
    extensions: ['.js', '.vue'],
  },
  module: {
    rules: [
    {
      test: /\.vue$/,
      loader: 'vue-loader',
      exclude: /node_modules/,
    },
    {
      test: /\.js$/,
      loader: 'babel-loader',
      exclude: /node_modules/,
    }]
  },
  optimization: {
    minimize: (mode === 'production') ? true : false,
    minimizer: [
      new UglifyJsPlugin({
        include: /\.js$/
      }),
    ]
  },
  plugins: [
    new webpack.DefinePlugin({
      __MODE__: JSON.stringify(mode),
    }),
    new VueLoaderPlugin()
  ],
};

export {
  config as default,
  entryFiles,
}