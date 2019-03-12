# Vuetified Shoper Template

Template bootstrap for using [Vue.js](https://vuejs.org/) with Shoper platform, created by [cebe11](https://cube11.pl/).

This setup allow you to freely work with [Shoper](https://www.shoper.pl/) SaaS platform. Because of implemented file synchronization by WebDAV protocol,
every file change will be immediately deployed to the server. However, there is also, safe mode to work on production instance. In safe mode every
change will be displayed only on local server, but nothing will be send to server, so you can develop new features without worry you ruin something.

Main feature of this setup is live preview of every change. This can be achieved by setting live server with proxy to SaaS instance, and injecting or
replacing content by newly compiled files.

#### Table of content

1. [Getting Started](#getting-started)
2. [Project structure](#project-structure)
2. [Theme development](#theme-development)
2. [Building final package](#building-final-package)
2. [Deploying project](#deploying-project)

## Getting Started

To use full features of this setup you should have minimal knowledge of node.js environment and create proper configuration file.

**Installation guide**:

1. Install npm dependencies
2. Create `.env` file

### Installing

Install all npm dependencies.
```
npm install
```

### Create environment configuration file

Create `.env` file in main project directory and add all bellowed credentials:

Specify project name:

* `PROJECT_NAME` - (optional) used in directories name and final files name, if not specified will be used 'template' phrase

Specify WebDAV connection credentials:

* `WEBDAV_TEMPLATE_NAME` - WebDAV template directory folder same as Template name in Shoper settings
* `WEBDAV_HOSTNAME` - shop URL address without 'http://' and ending slashes
* `WEBDAV_PORT` - (optional) use 443 otherwise WebDAV will not work
* `WEBDAV_USER` - find in Shoper Template advanced settings
* `WEBDAV_PASSWORD` - find in Shoper Template advanced settings

You can obtain them in Shoper admin panel in Template Advanced Settings page, after clicking "See more" in "For advanced" section. With Shoper WebDAV servers use port `443`. 

When WebDAV **credentials have not been specified**, the deploy won't work.

## Project structure

All source files are placed in 'src' directory. Remember that if you changed the PROJECT_NAME variable in `.env` file, then you should always change directories marked as `[template]` to the same name as environment variable. Otherwise, remove PROJECT_NAME from `.env` and keep `template` in directory names.

* `boxes` - smarty template files for template modules
* `images`
    * `user` - images visible in Shoper Template setting page
* `js` - Java Script files
    * `[template]` - \[template\] additional scripts
    * user.js - file editable in Shoper Template settings in Custom JS tab
    * main.js - main mechanics of Shoper Template
* `scripts` - smarty template files
* `styles` - CSS, Less and Sass files
    * `[template]` - \[template\] additional scripts

## Theme development

```
npm start
npm run serve
```

## Building final package

```
npm run build
npm run build:dev
```


## Deploying project

```
npm run deploy
npm run deploy:dev
```
