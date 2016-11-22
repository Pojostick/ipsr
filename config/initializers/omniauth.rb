OmniAuth.config.logger = Rails.logger
 
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '816764396586-bfn5s3elakqa1ndmqhbjbf148ao1hkbb.apps.googleusercontent.com', '8WxXTagp8lB5T2NFfAPsBzxC', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end