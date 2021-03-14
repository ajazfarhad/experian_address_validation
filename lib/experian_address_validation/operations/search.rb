# frozen_string_literal: true

# POST {{ base_url }}/address/search/v1
module ExperianAddressValidation
  module Operations
    # Handles address search operataion
    class Search < Operation
      private

      def endpoint
        "#{base_url}/address/search/v1"
      end

      def payload
        data = options[:payload]
        {
          country_iso: default_iso_code || data[:iso_code],
          components: {
            unspecified: [data[:query]]
          },
          location: data[:location],
          dataset: data[:dataset]
        }
      end
    end
  end
end
