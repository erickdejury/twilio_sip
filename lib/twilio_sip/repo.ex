defmodule TwilioSip.Repo do
  use Ecto.Repo,
    otp_app: :twilio_sip,
    adapter: Ecto.Adapters.Postgres
end
