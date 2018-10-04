class UpdateRatesJob < ApplicationJob
  queue_as :default

  def perform
  	ActiveRecord::Base.transaction do
  	  rates = Rate.all
  	  rates.each do |rate|
  	  	result = CurrencyApiService.fetch(rate)
  	  	if result['error'] == 0
  	      rate['amount'] = result['amount']
  	      rate.save!
  	    else
  	      puts "Error #{result['error']} for rate #{rate[:from]} - #{rate[:to]}.#{result["error_message"]}"
  	    end
  	  end
  	end
  end
end