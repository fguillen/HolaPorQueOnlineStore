class AddMailingToPedido < ActiveRecord::Migration
  def self.up
    add_column  :pedidos, :mailing, :boolean, :defaul => false
  end

  def self.down
    remove_column  :pedidos, :mailing
  end
end
