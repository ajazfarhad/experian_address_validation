# frozen_string_literal: true

RSpec.describe ExperianAddressValidation::Operations::Format do
  describe "#execute" do
    before { configure_client }

    subject(:format_address) { described_class.new(options) }

    let(:global_address_key) do
      "aWQ9TWFpbCBCb3hlcyBFdGMsIDkxIFdlc3Rlcm4g"\
      "Um9hZCwgQnJpZ2h0b24sIEJOMSAyTlcsIFVuaXR"\
      "lZCBLaW5nZG9tfmFsdF9rZXk9MDIxODU2MzN-ZGF0"\
      "YXNldD1HQlJfUEFGfmZvcm1hdF9rZXk9R0JSJCRlZDU"\
      "3MzM3MS04NWY5LTQyYzctYmQ5ZC0zZjY2Mjc2OWI0MmQkJCQ"
    end
    let(:options) do
      {
        global_address_key: global_address_key
      }
    end

    context "with formatted result" do
      let(:response) { format_address.execute[:result] }

      let(:expected_result) do
        {
          address_line_1: "Mail Boxes Etc",
          address_line_2: "91 Western Road",
          address_line_3: "",
          locality: "BRIGHTON",
          region: "",
          postal_code: "BN1 2NW",
          country: "UNITED KINGDOM"
        }
      end

      it "include address feilds" do
        VCR.use_cassette("experian/operations/format/format_address") do
          expect(response[:address]).to include(expected_result)
          expect(response[:components]).not_to be_empty
        end
      end
    end
  end
end
