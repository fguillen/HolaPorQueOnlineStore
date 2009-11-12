ActionController::Routing::Routes.draw do |map|
  map.root :controller => "camisetas", :action => 'portada'

  map.pedido_completado '/pedidos/completado/:id', :controller => 'pedidos', :action => 'complete'
  map.pedido_notificado '/pedidos/notificado/:id', :controller => 'pedidos', :action => 'notify', :method => :post
  
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action'
end
