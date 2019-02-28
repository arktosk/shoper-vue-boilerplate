const dotenv = require('dotenv');
const paths = require('./paths.config');
// import dotenv from 'dotenv';
// import paths from './paths.config';

const config = dotenv.config({path: paths.dotenv});

console.log(config.parsed)
console.log(process.env)