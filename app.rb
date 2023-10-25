require "sinatra"
require "sinatra/reloader"

get("/") do
  api_url ="https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_RATE_KEY")
  require "http"
  require "json"
  erb(:home)
end
