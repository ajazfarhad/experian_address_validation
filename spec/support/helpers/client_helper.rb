# frozen_string_literal: true

def configure_client(base_url: nil, auth_token: nil, iso_code: nil)
  ExperianAddressValidation::Client.configure do |config|
    config.base_url = base_url || ENV.fetch("BASE_URL")
    config.auth_token = auth_token || ENV.fetch("AUTH_TOKEN")
    config.iso_code = iso_code || ENV.fetch("ISO_CODE")
  end
end
