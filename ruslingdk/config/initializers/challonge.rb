Challonge.configure do |config|
  config.api_user = ENV.fetch("CHALLONGE_API_USER", '')
  config.api_key = ENV.fetch("CHALLONGE_API_KEY", '')
end