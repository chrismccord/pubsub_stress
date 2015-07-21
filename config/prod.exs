use Mix.Config

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
#
# Finally, we also include the path to a manifest
# containing the digested version of static files. This
# manifest is generated by the mix phoenix.digest task
# which you typically run after static files are built.
config :pubsub_stress, PubsubStress.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "example.com", port: 80]

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section, and set your `:url` port to 443
#
#  config :pubsub_stress, PubsubStress.Endpoint,
#    ...
#    url: [host: "example.com", port: 443],
#    https: [port: 443,
#            keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#            certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

# Do not print debug messages in production
config :logger, level: :error

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :pubsub_stress, PubsubStress.Endpoint, server: true
#

# ## Secrets
config :foo, Foo.Endpoint,
  secret_key_base: "4SSEg1ULRfq7PeThyXuPT00blYbHId11jOjV+f8n6Zu3nssoObpyM1JSB5Cm5Iqt"

# Configure your database
config :foo, Foo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "foo_prod",
  size: 20 # The amount of database connections in the pool
