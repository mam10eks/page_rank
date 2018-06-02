var path = require('path');
var webpack = require('webpack');
var merge = require('webpack-merge');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var autoprefixer = require('autoprefixer');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');


const prod = 'production';
const dev = 'development';

// determine build env
const TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? prod : dev;
const isDev = TARGET_ENV == dev;
const isProd = TARGET_ENV == prod;

// entry and output path/filename variables
const entryPath = path.join(__dirname, 'src/static/index.js');
const outputPath = path.join(__dirname, 'dist');
const outputFilename = isProd ? '[name]-[hash].js' : '[name].js'

console.log('WEBPACK GO! Building for ' + TARGET_ENV);

// common webpack config (valid for dev and prod)
var commonConfig = {
    output: {
        path: outputPath,
        filename: `static/js/${outputFilename}`,
    },
    resolve: {
        extensions: ['.js', '.elm'],
        modules: ['node_modules']
    },
    module: {
        /*noParse: /\.elm$/,*/
        rules: [{
            test: /\.(eot|ttf|woff|woff2|svg)$/,
            use: 'file-loader?publicPath=../../&name=static/css/[hash].[ext]'
        }, {
            test: /\.(gif|png|jpe?g|svg)$/i,
            use: ['url-loader?prefix=img/&limit=5000000', 'image-webpack-loader']
        }, {
            test: /\.sc?ss$/,
            use: ['style-loader', 'css-loader', {loader: 'postcss-loader', options: {plugins: [autoprefixer()]}}, 'sass-loader']
        }]
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: 'src/static/index.html',
            inject: 'body',
            filename: 'index.html'
        })
    ]
}

// additional webpack settings for local env (when invoked by 'npm start')
if (isDev === true) {
    module.exports = merge(commonConfig, {
        mode: 'development',
        entry: [
            'webpack-dev-server/client?http://localhost:8080',
            entryPath
        ],
        devServer: {
            // serve index.html in place of 404 responses
            historyApiFallback: true,
            contentBase: './src',
            hot: true
        },
        module: {
            rules: [{
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [{
                    loader: 'elm-assets-loader',
                    options: {
                      module: 'View.Assets',
                      tagger: 'Asset',
                      package: 'mam10eks/page-rank'
                    }
                  }, {
                    loader: 'elm-webpack-loader',
                    options: {
                        verbose: true,
                        warn: true,
                        debug: true
                    }
                }]
            }]
        }
    });
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if (isProd === true) {
    module.exports = merge(commonConfig, {
        mode: 'production',
        entry: entryPath,
        module: {
            rules: [{
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [ {
                    loader: 'elm-assets-loader',
                    options: {
                      module: 'View.Assets',
                      tagger: 'Asset',
                      package: 'mam10eks/page-rank'
                    }
                  }, 'elm-webpack-loader']
            }]
        },
        plugins: [
            new CopyWebpackPlugin([{from: 'src/favicon.ico' }])
        ]
    });
}
