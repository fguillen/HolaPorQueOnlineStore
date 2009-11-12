class AddPaypalFieldsToPedido < ActiveRecord::Migration
  def self.up
    add_column  :pedidos, :paypal_errors, :text
    add_column  :pedidos, :paypal_notify_params, :text
    add_column  :pedidos, :paypal_complete_params, :text
    add_column  :pedidos, :paypal_status, :string
    add_column  :pedidos, :transaction_id, :string
    add_column  :pedidos, :purchased_at, :datetime
  end

  def self.down
    remove_column  :pedidos, :paypal_errors
    remove_column  :pedidos, :paypal_notify_params
    remove_column  :pedidos, :paypal_complete_params
    remove_column  :pedidos, :paypal_status
    remove_column  :pedidos, :transaction_id
    remove_column  :pedidos, :purchased_at
  end
end
