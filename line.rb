require "json"
require "uri"
require "net/http"

def line_message (message)
  url = URI("https://notify-api.line.me/api/notify")

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Post.new(url)
  key = JSON.load(File.open "secrets.json")["line"]
  request["Authorization"] = "Bearer #{key}"
  form_data = [['message', message]]
  request.set_form form_data, 'multipart/form-data'
  response = https.request(request)
  return response.read_body
end
