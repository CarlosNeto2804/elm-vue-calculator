module.exports = {
  chainWebpack: config => {
    config.module
      .rule('elm')
      .test(/\.elm$/)
      .use('elm-webpack-loader')
        .loader('elm-webpack-loader')
        .end()
  
  },
  /* configureWebpack: {
    module: {
      rules: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: {
            loader: "elm-webpack-loader",
            options: {},
          },
        },
      ],
    },
  }, */
};
