require('dotenv').config()

const HtmlWebpackPlugin = require('html-webpack-plugin')
const port = process.env.PORT || 3000

module.exports = {
  mode: "development",

  entry: "./src/index",
  output: {
    filename: "bundle.js"
  },

  resolve: {
    extensions: [".js", ".jsx"]
  },

  module: {
    rules: [
      {
        test: /\.jsx?$/,
        loader: "babel-loader",
        exclude: /node_modules/
      },
      {
          test: /\.(css)$/,
          use: ["style-loader", "css-loader"],
      }
    ]
  },

  devServer: {
    host: process.env.HOST,
    port: port,
    open: true
    },

  plugins: [
    new HtmlWebpackPlugin({
      template: `public/index.html`
    })
  ]
};