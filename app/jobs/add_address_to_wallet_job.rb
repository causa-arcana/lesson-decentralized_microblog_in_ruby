class AddAddressToWalletJob < ApplicationJob
  queue_as :default

  def perform(address)
    return if address.added_to_wallet?

    success = %x[dash-cli importaddress '#{address.value}' '' true]

    raise 'dash-cli importaddress failed' unless success

    address.update! added_to_wallet: true
  end
end
