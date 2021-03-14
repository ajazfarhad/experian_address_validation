# frozen_string_literal: true

module ExperianAddressValidation
  # Base class for API operations
  class Operation
    DEFAULT_HEADERS = {
      content_type: "application/json"
    }.freeze

    def initialize(options = {})
      @options = options
    end

    def execute
      http_client.headers["Auth-Token"] = auth_token

      response = http_client.run_request(http_method, endpoint, json_payload, headers)

      return json_response(response) if response.success?

      raise ExperianAddressValidation::Errors::ResponseError.new(body: response.body, status: response.status)
    end

    def http_method
      :post
    end

    private

    attr_reader :options

    def http_client
      @http_client ||= Faraday.new
    end

    def json_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def json_payload
      @json_payload ||= JSON.generate(payload)
    end

    def payload
      options[:payload]
    end

    def base_url
      config.base_url
    end

    def headers
      DEFAULT_HEADERS.merge(options.fetch(:headers, {}))
    end

    def auth_token
      config.auth_token
    end

    def config
      Client.config
    end

    def default_iso_code
      config.iso_code
    end

    def endpoint; end
  end
end
