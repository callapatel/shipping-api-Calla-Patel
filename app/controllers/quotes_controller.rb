class QuotesController < ApplicationController
  require './lib/shipping'

  def index
    x = Shipping.new(params[:country], params[:state], params[:city], params[:zip], params[:weight])
    x.credentials
    @v = x.est_ups
    @y = x.est_usps
    @z = @v + @y

    render json: @z


  end
end
