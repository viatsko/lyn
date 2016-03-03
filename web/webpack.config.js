var webpack = require('webpack')
module.exports = {
  entry: "./index",
  output: {
    path: '../priv/static', //typical output on the default directory served by Plug.Static
    filename: 'client.[hash].js', //dynamic name for long term caching, or code splitting, use WebPack.file_of(:main) to get it
    publicPath: '/public/'
  },

  externals: { react: "React" }, //for performance you can use the react from a CDN
  plugins: (function(){
    if(process.env.MIX_ENV == "prod") //you can make use of the MIX_ENV to handle multiple config
      return [new webpack.optimize.UglifyJsPlugin({minimize: true})]
    else
      return []
  })(),

  module: {
    loaders: [
      //!!! very important, use "reaxt/style" loader instead of "style" for css
      { test: /\.css$/, loader: "reaxt/style!css" },
      //with react-hot, you have automatically hot loading of your components available
      { test: /components\/.*\.js$/, loader: "react-hot!jsx?harmony" }
    ]
  },

}
