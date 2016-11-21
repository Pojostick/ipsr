OmniAuth.config.logger = Rails.logger
 
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '288178610370-56ea7aq79sbhaafin54u0vk3b9un297l.apps.googleusercontent.com', 'vKaWS8ZkfZM5IJLS6Zp6e2P0', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end