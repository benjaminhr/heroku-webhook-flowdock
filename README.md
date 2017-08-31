# Heroku webhook + Flowdock notifications template

- **Things you will need to do:**
  - follow this [tutorial](https://devcenter.heroku.com/articles/app-webhooks#receiving-webhooks) to setup heroku webhook
  - follow this [tutorial](https://www.flowdock.com/api/integration-getting-started) to setup Flowdock notifications
  - Add Flowdock curl command with your own keys, etc. to **app.rb**

- **Explanation**
  1. Make change in Heroku app you are subscribed to
  2. Heroku triggers webhook --> sends POST request to your webhook app
  3. Webhook app receives POST request, triggers curl command with parameters from POST request
  4. Flowdock receives POST with parameters, sends message to specified flow inbox
  5. Great success.

- **Ruby related --> Gemfile.lock
