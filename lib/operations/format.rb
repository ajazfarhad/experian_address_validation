# frozen_string_literal: true

# GET {{ base_url }}/address/format/v1/{global_address_key}
module ExperianAddressValidation
  module Operations
    # Handles address formatting
    class Format < Operation
      FORMAT_HEADERS = {
        "Add-Metadata": "true",
        "Add-Components": "true"
      }.freeze

      private

      def endpoint
        "#{base_url}/address/format/v1/#{global_address_key}"
      end

      def global_address_key
        options[:global_address_key]
      end

      def http_method
        :get
      end

      def headers
        option_headers = options.fetch(:headers, {})
        DEFAULT_HEADERS.merge(**FORMAT_HEADERS, **option_headers)
      end
    end
  end
end
