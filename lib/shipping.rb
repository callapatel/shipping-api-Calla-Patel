require 'active_shipping'
include ActiveMerchant::Shipping
class Shipping

  def origin
    Location.new(:country => 'US',
                 :state => 'WA',
                 :city => 'Seattle',
                 :zip => '98103')
  end

  def destination
    Location.new(params_hash[:address])
  end

  def packages
    Package.new( params[:weight],
                 nil,
                 :cylinder => false)
  end

  def credentials
    ups = UPS.new(:login => 'auntjudy', :password => 'secret', :key => ENV["UPS_KEY"])
    @response1 = ups.find_rates(origin, destination, packages)
    usps = USPS.new(:login => 'developer-key')
    @response2 = usps.find_rates(origin, destination, packages)

  end

  def getanest
    @ups_rates = @response1.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    @usps_rates = @response2.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end




end
