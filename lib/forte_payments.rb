require 'faraday'
require 'faraday_middleware'


module FortePayments
end

module FortePayments
  class Client
  end
end

require_relative 'forte_payments/resources/address'
require_relative 'forte_payments/resources/customer'
require_relative 'forte_payments/resources/paymethod'
require_relative 'forte_payments/resources/settlement'
require_relative 'forte_payments/resources/transaction'


require_relative 'forte_payments/client'

