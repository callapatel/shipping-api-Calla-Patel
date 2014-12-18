require 'active_shipping'
include ActiveMerchant::Shipping
class Shipping

  def origin
    Location.new(:country => 'US',
                 :state => 'CA',
                 :city => 'San Jose',
                 :zip => '95134')
  end

  def destination
    #Location.new(params_hash[:address])
    Location.new(:country => 'US',
                  :state => 'TX',
                  :city => 'kemah',
                  :zip => '77565')
  end

  def packages
    Package.new( 100,
                 nil,
                 :cylinder => true)
  end

  def credentials
    ups = UPS.new(:login => 'auntjudy', :password => 'secret', :key => ENV["UPS_KEY"])
    @response1 = ups.find_rates(origin, destination, packages)
    usps = USPS.new(:login => ENV["USPS_KEY"])
    @response2 = usps.find_rates(origin, destination, packages)

  end

  def est_ups
    @ups_rates = @response1.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end

  def est_usps
    @usps_rates = @response2.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end



end
