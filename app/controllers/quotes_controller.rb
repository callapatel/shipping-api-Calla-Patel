class QuotesController < ApplicationController
  require './lib/shipping'

  def index
    x = Shipping.new
    x.origin
    x.destination
    x.packages
    x.credentials
    @v = x.est_ups
    @y = x.est_usps
    render :json => { @v => @v,
         @y => @y}

  end
end
