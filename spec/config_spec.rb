# frozen_string_literal: true

RSpec.describe ExperianAddressValidation::Config do
  it { is_expected.to respond_to(:base_url, :base_url=) }
  it { is_expected.to respond_to(:auth_token, :auth_token=) }
  it { is_expected.to respond_to(:iso_code, :iso_code=) }
end
