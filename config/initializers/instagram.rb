require 'instagram'
require 'sinatra'

case Rails.env
when 'development', 'test'
  Instagram.configure do |config|
    config.client_id = "55b89c9652df4cd4b5249cada73369e9"
    config.client_secret = "ce4fb9cd068c477d8fda40fc651b4449"
  end
when 'production'
  Instagram.configure do |config|
    config.client_id = "55b89c9652df4cd4b5249cada73369e9"
    config.client_secret = "ce4fb9cd068c477d8fda40fc651b4449"
  end
end