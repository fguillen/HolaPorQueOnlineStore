class AddTipoEnvioToPedido < ActiveRecord::Migration
  def self.up
    add_column :pedidos, :tipoEnvio, :string, :null => false
  end

  def self.down
    remove_column :pedidos, :tipoEnvio
  end
end
