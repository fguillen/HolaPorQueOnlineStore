class AddAddressFieldsToPedido < ActiveRecord::Migration
  def self.up
    add_column :pedidos, :usuarioCiudad, :string, :null => false
    add_column :pedidos, :usuarioPais, :string, :null => false
    add_column :pedidos, :usuarioCp, :string, :null => false
  end

  def self.down
    remove_column :pedidos, :usuarioCp
    remove_column :pedidos, :usuarioPais
    remove_column :pedidos, :usuarioCiudad
  end
end
