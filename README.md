# Experian Address Validation
Ruby wrapper for Experian Address Validation REST API

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'experian_address_validation'
```
And then execute:

    $ bundle

Or install it yourself as:
```ruby
$ gem install experian_address_validation
```

## Usage
------
## Configure client
**For using this Gem in a Rails app. Add the following code as an initializer**

``` ruby
  ExperianAddressValidation::Client do |config|
    config.auth_token = ENV["AUTH_TOKEN"]
    config.base_url = ENV["BASE_URL"]
    config.iso_code = ENV["ISO_CODE"]
  end
```
**You can provide default ``iso_code`` through a config variable or you can send as a payload option to search endpoint.**

## Experian Address Validation API Reference
https://www.edq.com/documentation/apis-r/address-validate/experian-address-validation/#/AddressFormat/Get

# Endpoints
---

### Search Address
------

``` ruby
ExperianAddressValidation::Operations::Search.new(payload: {
  query: 'BN1 2NW', country_iso: 'GBR'}
}).execute
```
The call to above operation will return response in the following structure.

``body`` - containing hash with the following data

``` ruby
{
  result: {
    more_results_available: true,
    confidence: "Verified match",
    suggestions: [
      {
        global_address_key: "aWQ9ZWUwMzhjYzAtY2IxZi00MDRiLTTlfVTQwXzI0XzBfMF8",
        text: "Mail Boxes Etc, 91 Western Road, Brighton, BN1 2NW",
        format: "https://localhost/capture/address/v3/format/aWQ9ZWUwMzhjYzAtY2IxZi00MDRiLTTlfVTQwXzI0XzBfMF8"
      }
    ]
  }
}
```
``code`` - Status code e.g ``200``

Address Search endpoint:
https://api.experianaperture.io/address/search/v1

### Format Address
------

``` ruby
ExperianAddressValidation::Operations::Format.new({
  global_address_key: 'aWQ9ZWUwMzhjYzAtY2IxZi00MDRiL...'
}).execute
```
``Add-Metadata`` and ``Add-Components`` headers are default set to ``true`` in ``Format`` call.
However you can override them by passing ``headers`` hash as an option to the ``Format`` endpoint.

``` ruby
headers:  { Add-Metadata: false, Add-Components: false }
```

``code`` - Status code e.g ``200``

The call to above operation will return response in the following structure.

``` ruby
{
    result: {
        global_address_key: "aWQ9ZWUwMzhjYzAtY2IxZi00MDRiL...",
        confidence: "Verified match",
        address: {
            address_line_1: "Mail Boxes Etc",
            address_line_2: "91 Western Road",
            address_line_3: "",
            locality: "BRIGHTON",
            region: "",
            postal_code: "BN1 2NW",
            country: "UNITED KINGDOM"
        },
        components: {
            language: "en-GB",
            country_name: "United Kingdom",
            country_iso_3: "GBR",
            postal_code: {
                full_name: "BN1 2NW",
                primary: "BN1 2NW"
            },
            building: {
                building_number: "91"
            },
            organization: {
                company_name: "Mail Boxes Etc"
            },
            street: {
                full_name: "Western Road",
                name: "Western",
                type: "Road"
            },
            locality: {
                town: {
                    name: "Brighton"
                }
            }
        }
    },
    "metadata": {
        "address_info": {
            "identifier": {
                "udprn": "123123"
            }
        }
    }
}
```

Address Format endpoint:
https://api.experianaperture.io/address/format/v1/#{global_address_key}

## Running specs

To run the specs, add your development credentials to your dev env.test file:
```
BASE_URL=https://api.experianaperture.io
AUTH_TOKEN=<api_token>
ISO_CODE=GBR
```
