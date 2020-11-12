require('dotenv').config();
const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
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
  node: {
    fs: 'empty',
    net: 'empty',
  },
  resolve: {
    extensions: ['.js', '.jsx'],
    alias: {
      '@stores': path.resolve(__dirname, './src/stores'),
      '@components': path.resolve(__dirname, './src/components'),
      '@atoms': path.resolve(__dirname, './src/components/atoms'),
      '@molecules': path.resolve(__dirname, './src/components/molecules'),
      '@organisms': path.resolve(__dirname, './src/components/organisms'),
      '@templates': path.resolve(__dirname, './src/components/templates'),
      '@pages': path.resolve(__dirname, './src/components/pages'),
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
  ],
  devtool: 'cheap-eval-source-map',
};
