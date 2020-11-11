require('dotenv').config();
const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const port = process.env.PORT || 80;
module.exports = {
  mode: 'development',
  entry: './src/index',
  output: {
    path: path.join(
      __dirname + process.env.DIST_PATH || '',
      process.env.DIST_PATH ? 'public' : 'dist'
    ),
    filename: 'bundle.js',
  },

  resolve: {
    extensions: ['.js', '.jsx'],
    alias: {
      '@components': path.resolve(__dirname, './src/components'),
      '@pages': path.resolve(__dirname, './src/pages'),
      '@utils': path.resolve(__dirname, './src/utils'),
      '@styles': path.resolve(__dirname, './src/styles'),
    },
  },

  module: {
    rules: [
      {
        test: /\.(js|jsx)?$/,
        loader: 'babel-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.(css)$/,
        use: ['style-loader', 'css-loader'],
      },
      {
        test: /\.(jpeg|jpg|JPG|svg)$/,
        loader: 'file-loader',
        options: {
          name: '[name].[ext]',
        },
      },
    ],
  },

  devServer: {
    host: process.env.HOST,
    contentBase: path.join(
      __dirname + process.env.DIST_PATH || '',
      process.env.DIST_PATH ? 'public' : 'dist'
    ),
    port: port,
    open: true,
    hot: true,
    inline: true,
    historyApiFallback: true,
  },

  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      template: `public/index.html`,
    }),
    new CleanWebpackPlugin(),
  ],
  devtool: 'cheap-module-source-map',
};
