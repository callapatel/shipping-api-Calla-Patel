  require ''
  include ActiveMerchant::Shipping
class Shipping

  def origin
    Location.new(params_hash[:origin])
  end

  def destination
    Location.new(params_hash[:destination])
  end
end
