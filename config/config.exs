# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :twilio_sip,
  ecto_repos: [TwilioSip.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :twilio_sip, TwilioSipWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: TwilioSipWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TwilioSip.PubSub,
  live_view: [signing_salt: "3sf6HhgV"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :twilio_sip, TwilioSip.Mailer, adapter: Swoosh.Adapters.Local

config :twilio_sip, :voice,
  phone_number: System.get_env("twilio_phone", "+12184234743"),
  account_sid: System.get_env("account_sid", "AC89e856d7c5c85ddccddd59cd1bd706d9"),
  auth_token: System.get_env("auth_token", "f895096387bae74e032976bf511777fe"),
  base_url:
    System.get_env(
      "base_url",
      "https://api.twilio.com/2010-04-01/Accounts/AC89e856d7c5c85ddccddd59cd1bd706d9/Calls.json"
    ),
  call_url: System.get_env("call_url", "http://demo.twilio.com/docs/voice.xml")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
