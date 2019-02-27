# Vuetified Shoper Template

Template bootstrap for using [Vue.js](https://vuejs.org/) with Shoper platform, created by [cebe11](https://cube11.pl/) team.

<!-- Production version of template: [devshop-829714.shoparena.pl](https://devshop-829714.shoparena.pl/). -->

## Getting Started

Project created using `gulp` and WebDAV connection to Shoper servers. Styles are preprocessed by gulp, and for JavaScript ES6 or vue files support added Webpack.

Instalation guide:

1. Install npm dependencies
2. Create `.env` file

### Installing

Install all npm dependencies.
```
npm install
```

### Create `.env` file and establish WebDAV connection

Create `.env` file in main project directory and add all belowed credentials:

Specify project name:

* `PROJECT_NAME` - (optional) used in directories name and final files name, if not specified will be used 'template' phrase

You can specify `BUILD_MODE` parameter, otherwise build will be done in `production` mode:

* `BUILD_MODE` - available "development" or "production" (default), "development" mode allows Logger module log every action and saves files with sourcemaps, "production" mode disable logs and final files will be minified without sourcemaps.

Specify WebDAV connection credentials:

* `WEBDAV_TEMPLATE_NAME` - WebDAV template directory folder same as Template name in Shoper settings
* `WEBDAV_HOSTNAME` - shop URL address without 'http://' and ending slashes
* `WEBDAV_PORT` - (optional) use 443 otherwise WebDAV will not work
* `WEBDAV_USER` - find in Shoper Template advanced settings
* `WEBDAV_PASS` - find in Shoper Template advanced settings

You can obtain them in Shoper admin panel in Template Advanced Settings page, after clicking "See more" in "For advanced" section. With Shoper WebDAV servers use port `443`. 

When WebDAV **credentials didn't specified**, the deploy won't work.

## Project structure

Prepare folders similat to bellowed structure. You should manualy replace `[template]` by PROJECT_NAME variable from `.env` file.

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

## Using gulp

By using gulp default task, there files will be complied and deployed on a fly.

```
gulp
```

To obtain list of all available taskt use gulp command with flag `--tasks`

```
gulp --tasks
```

### Run WebDAV watch

This watch updates files directly in template directory, so you can freely edit all *.tpl files on your machine and preview changes on server. Styles and JavaScript files are compiled/transpiled and moved to template directory so remember to add in `header.tpl` file this styles and scripts.

```
gulp watch
```