const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  entry: './js/app.js',
  output: {
    filename: 'app.js',
    path: path.resolve(__dirname, '../priv/static/assets'),
    publicPath: '/assets/'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'postcss-loader'
        ]
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: 'app.css' }),
    new CopyWebpackPlugin({
      patterns: [
        { from: 'static/', to: '../', noErrorOnMissing: true }
      ]
    })
  ],
  optimization: {
    minimize: true,
    minimizer: [
      '...',
      new CssMinimizerPlugin()
    ]
  }
};
