class UpdateAddressOpReturnJob < ApplicationJob
  queue_as :default

  OP_RETURN_RE = /\AOP_RETURN ([0-9a-fA-F]*)\z/.freeze
  MIN_CONFIRMATIONS = 1

  def perform(address)
    return unless address.update_op_return?

    all_tx_datas = JSON.parse %x[dash-cli listtransactions "*" 100]

    tx_datas = all_tx_datas.select do |tx_data|
      tx_data['address'] == address.value &&
        tx_data['category'] == 'send' &&
        tx_data['confirmations'] >= MIN_CONFIRMATIONS
    end

    tx_ids = tx_datas.map { |tx_data| tx_data['txid'] }.uniq

    tx_full_datas = tx_ids.map do |tx_id|
      JSON.parse %x[dash-cli getrawtransaction #{tx_id} 1]
    end

    all_tx_vouts = tx_full_datas.flat_map do |tx_full_data|
      tx_full_data['vout'].map do |vout|
        tx_full_data.merge 'vout' => vout
      end
    end

    tx_vouts = all_tx_vouts.select do |tx_vout|
      tx_vout['vout']['scriptPubKey'] != nil &&
        tx_vout['vout']['scriptPubKey']['asm'] != nil &&
        tx_vout['vout']['scriptPubKey']['asm'].match?(OP_RETURN_RE)
    end

    if tx_vouts.empty?
      address.update! op_return_value: nil,
                      op_return_updated_at: Time.zone.now
      return
    end

    actual_tx_vout = tx_vouts.sort_by do |tx_vout|
      [
        tx_vout['confirmations'],
        -tx_vout['vout']['n'],
      ]
    end.first

    asm = actual_tx_vout['vout']['scriptPubKey']['asm']
    match = OP_RETURN_RE.match asm
    hex = match[1]
    ascii = [hex].pack 'H*'

    address.update! op_return_value: ascii,
                    op_return_updated_at: Time.zone.now
  end
end
