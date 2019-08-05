class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  enable :sessions
  set :session_secret, "d3c6b77d15ac10d78c5e0d4797b159614f162810edb34cb52f330cd7ee2434729159e785595d074857c57794d38f34ddb45719a1ed94206aa54631ed6a5ad16e"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end
end