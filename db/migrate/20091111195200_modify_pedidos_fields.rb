class ModifyPedidosFields < ActiveRecord::Migration
  def self.up
    add_column :pedidos, :usuarioNombre_2, :string, :null => false
    add_column :pedidos, :usuarioDireccion_2, :string, :null => false
    add_column :pedidos, :usuarioEmail_2, :string, :null => false

    Pedido.all.each do |pedido|
      pedido.update_attribute( :usuarioNombre_2, pedido.usuarioNombre )
      pedido.update_attribute( :usuarioDireccion_2, pedido.usuarioDireccion )
      pedido.update_attribute( :usuarioEmail_2, pedido.usuarioEmail )
    end

    remove_column :pedidos, :usuarioNombre
    remove_column :pedidos, :usuarioDireccion
    remove_column :pedidos, :usuarioEmail
    
    add_column :pedidos, :usuarioNombre, :string, :null => false
    add_column :pedidos, :usuarioDireccion, :string, :null => false
    add_column :pedidos, :usuarioEmail, :string, :null => false
    
    Pedido.all.each do |pedido|
      pedido.update_attribute( :usuarioNombre, pedido.usuarioNombre_2 )
      pedido.update_attribute( :usuarioDireccion, pedido.usuarioDireccion_2 )
      pedido.update_attribute( :usuarioEmail, pedido.usuarioEmail_2 )
    end
    
    remove_column :pedidos, :usuarioNombre_2
    remove_column :pedidos, :usuarioDireccion_2
    remove_column :pedidos, :usuarioEmail_2

  end

  def self.down
  end
end
