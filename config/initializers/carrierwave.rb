CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.amazon[:key_id],
    aws_secret_access_key: Rails.application.credentials.amazon[:access_key]
  }
  config.storage = :fog
  config.fog_directory = 'bookstrore-rg'
end
