include ActiveMerchant::Shipping
class Shipping

  def initialize(country, state, city, zip, weight)
    @destination = destination(country, state, city, zip)
    @packages = packages(weight)
  end

  def origin
    Location.new(:country => 'US',
                 :state => 'CA',
                 :city => 'San Jose',
                 :zip => '95134')
  end

  def destination(country, state, city, zip)
    Location.new(:country => country,
                  :state => state,
                  :city => city,
                  :zip => zip)
  end

  def packages(weight)
    Package.new( weight.to_i,
                 nil,
                 :cylinder => true)
  end

  def credentials
    ups = UPS.new(:login => 'auntjudy', :password => 'secret', :key => ENV["UPS_KEY"])
    @response1 = ups.find_rates(origin, @destination, @packages)
    usps = USPS.new(:login => ENV["USPS_KEY"])
    @response2 = usps.find_rates(origin, @destination, @packages)

  end

  def est_ups
    @ups_rates = @response1.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end

  def est_usps
    @usps_rates = @response2.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end



end
