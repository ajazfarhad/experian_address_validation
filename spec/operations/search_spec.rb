# frozen_string_literal: true

RSpec.describe ExperianAddressValidation::Operations::Search do
  describe "#execute" do
    before { configure_client }

    subject(:search) { described_class.new(options) }

    let(:options) do
      {
        payload: { query: "WC1B 3DG" }
      }
    end

    context "with single result" do
      let(:response) { search.execute[:result] }
      let(:suggestions) { response[:suggestions].first }

      it "does not include multiple results" do
        VCR.use_cassette("experian/operations/search/single_result") do
          expect(response[:more_results_available]).to eq false
          expect(suggestions).to include(global_address_key: a_kind_of(String))
          expect(suggestions[:text]).to eq("British Museum, Great Russell Street, London, WC1B 3DG")
        end
      end
    end

    context "with multiple results" do
      before { options[:payload][:query] = "BN1 2NW" }
      let(:response) { search.execute[:result] }
      let(:suggestions) { response[:suggestions] }
      let(:expected_result) do
        [
          "Mail Boxes Etc, 91 Western Road, Brighton, BN1 2NW",
          "Mail Boxes Etc, Dept. 228, 91 Western Road, Brighton, BN1 2NW",
          "Mail Boxes Etc, Department 228, 91 Western Road, Brighton, BN1 2NW",
          "Mail Boxes Etc, Unit 214, 91 Western Road, Brighton, BN1 2NW"
        ]
      end
      it "include multiple results" do
        VCR.use_cassette("experian/operations/search/multiple_result") do
          expect(response[:more_results_available]).to eq true
          results = suggestions.map { |result| result[:text] }
          expect(results).to eq(expected_result)
        end
      end
    end

    context "with errors" do
      before { options[:headers] = { "Auth-Token": "invalid-api-token" } }

      it "raises an error" do
        VCR.use_cassette("experian/operations/search/error") do
          expect { search.execute }
            .to raise_error(ExperianAddressValidation::Errors::ResponseError, /Authentication has been denied/)
        end
      end
    end
  end
end
