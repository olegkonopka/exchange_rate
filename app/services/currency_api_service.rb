require 'rest-client'

class CurrencyApiService
  class << self
    def fetch args
      condition = {params: {api_key: CURRENCY_API_SERVICE['settings']['api_key']}}
      condition[:params].merge!(from: args[:from], to: args[:to]) if args[:from] && args[:to]
      result = JSON.parse(RestClient.get(CURRENCY_API_SERVICE['settings']['url'], condition))
    end
  end
end