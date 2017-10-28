# Heroku webhook + Flowdock notifications template

- **Things you will need to do:**
  - follow this [tutorial](https://devcenter.heroku.com/articles/app-webhooks#receiving-webhooks) to setup heroku webhook
  - follow this [tutorial](https://www.flowdock.com/api/integration-getting-started) to setup Flowdock notifications
  - Add Flowdock curl command with your own keys, etc. to **app.rb**

- **How does it work**
  - Webhook triggers app
  - Sends notification to flowdock with appropriate params
  - Great success

