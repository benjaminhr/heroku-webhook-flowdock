require 'sinatra'

get '/' do
  "<h3>ignore</h3>"
end

# global var - used in index.html.erb
$output = []

post '/webhook' do
  status 200

  # heroku webhook authentication
  def valid_signature?(request, webhook_secret)
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(
      OpenSSL::Digest.new('sha256'),
      webhook_secret,
      request.raw_post
    )).strip
    heroku_hmac = request.headers['Heroku-Webhook-Hmac-SHA256']

    heroku_hmac && Rack::Utils.secure_compare(calculated_hmac, heroku_hmac)
  end

  # picking out data from heroku post request
  json_data = JSON.parse(request.body.read.to_s)
  $output << json_data
  $output.join(", ")

  heroku_app_name = json_data["data"]["app"]["name"]
  heroku_timestamp = json_data["data"]["created_at"]
  heroku_description = json_data["data"]["description"]
  heroku_email = json_data["actor"]["email"]

  # command to post message to flowdock with unique flow token
  %x(curl -i -X POST -H "Content-Type: application/json" -d '{
        "flow_token": "",
        "event": "activity",
        "author": {
          "name": "#{heroku_app_name}",
          "avatar": "https://a.slack-edge.com/bfaba/img/api/hosting_heroku.png"
        },
        "title": "#{heroku_description}",
        "external_thread_id": "#{heroku_timestamp}",
        "thread": {
          "title": "Heroku",
          "body": "none",
          "external_url": "",
          "status": {
            "color": "grey",
            "value": "CHANGE"
          }
        }
      }' https://api.flowdock.com/messages)

end

get '/webhook' do
  erb :'index.html'
end
