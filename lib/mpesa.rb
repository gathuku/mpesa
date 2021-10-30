# frozen_string_literal: true

require_relative 'mpesa/version'

# main module
module Mpesa
  autoload :Error, 'mpesa/error'
  autoload :Client, 'mpesa/client'
  autoload :Object, 'mpesa/object'
  autoload :Resource, 'mpesa/resource'
  autoload :SecurityCred, 'mpesa/securitycred'

  autoload :Register, 'mpesa/resources/register'
  autoload :Token, 'mpesa/resources/token'
  autoload :Stk, 'mpesa/resources/stk'
  autoload :Payout, 'mpesa/resources/payout'
  autoload :Status, 'mpesa/resources/status'
  autoload :Balance, 'mpesa/resources/balance'
  autoload :Reversal, 'mpesa/resources/reversal'

  autoload :Instance, 'mpesa/objects/instace'
end
