require('dotenv').config();
const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const port = process.env.PORT || 3000;

module.exports = {
  mode: 'development',
  entry: './src/index',
  output: {
    filename: 'bundle.js',
  },

  resolve: {
    extensions: ['.js', '.jsx'],
    alias: {
      '@components': path.resolve(__dirname, './src/components'),
      '@pages': path.resolve(__dirname, './src/pages'),
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
    contentBase: path.join(__dirname, 'dist'),
    port: port,
    open: true,
    hotOnly: true,
    historyApiFallback: true,
  },

  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      template: `public/index.html`,
    }),
    new CleanWebpackPlugin(),
  ],
};
