# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rails secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Rails.application.config.secret_key_base = ENV.fetch("SECRET_KEY_BASE") {
  'efa61a01de305f28f1e29f7ed25b27c5bc0c29152d879bdf730e2ec01ed8768c1196d455bed5b69c4d0284a28f734815042a60a947f85aeae0ccd08f08b08746'
}
