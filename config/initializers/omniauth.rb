OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1604437849813271', '36309a1c8f9641a5be5c6619959cf309', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
