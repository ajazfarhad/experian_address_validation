# frozen_string_literal: true

module ExperianAddressValidation
  module Errors
    class ResponseError < StandardError
      attr_reader :status, :body

      def initialize(status:, body:)
        @status = status
        @body = body

        super(build_message)
      end

      private

      def build_message
        return status unless body.is_a?(String)

        parsed_body = JSON.parse(body)
        parsed_body["error"] || body
      end
    end
  end
end
