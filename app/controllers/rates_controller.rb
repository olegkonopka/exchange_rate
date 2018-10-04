class RatesController < ApplicationController
  before_action :get_rates
  def index
    @amount = 0
    unless params[:amount].to_f.zero?
      @rates.each{|rate| rate['amount'] = params[:amount].to_f * rate['amount']}
      @amount = params[:amount]
    end
  end

  def create
    result = CurrencyApiService.fetch(params[:rate])
    if result['error'] == 0
      rate = Rate.where(from: params[:rate][:from], to: params[:rate][:to]).first
      if rate 
        flash.now[:alert] = 'Rate is currently added!'
        render 'index'
      else
        Rate.create!(from: params[:rate][:from], to: params[:rate][:to], amount: result['amount'].round(2))
        redirect_to root_path
      end
    else
      flash.now[:alert] = result['error_message']
      render 'index'
    end 
  end

  private
  def get_rates
    @rates = Rate.all.order(created_at: :desc)
  end
end