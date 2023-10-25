require "sinatra"
require "sinatra/reloader"

get("/") do
  api_url_list ="https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_RATE_KEY")
  require "http"
  resp = HTTP.get(api_url_list)
  raw_resp = resp.to_s

  require "json"
  parsed_resp = JSON.parse(raw_resp)
  currency_hash = parsed_resp.fetch("currencies")

  @currency_keys = currency_hash.keys

  erb(:home)
end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url_list ="https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_RATE_KEY")
  
  require "http"
  resp = HTTP.get(api_url_list)
  raw_resp = resp.to_s

  require "json"
  parsed_resp = JSON.parse(raw_resp)
  currency_hash = parsed_resp.fetch("currencies")

  @currency_keys = currency_hash.keys

  erb(:single_currency)

end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url_fx = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

  require "http"
  resp = HTTP.get(api_url_fx)
  raw_resp = resp.to_s

  require "json"
  parsed_resp = JSON.parse(raw_resp)
  @conversion_rate = parsed_resp.fetch("result")

  erb(:convert_currency)
  
  # some more code to parse the URL and render a view template
end
