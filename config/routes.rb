ActionController::Routing::Routes.draw do |map|
  map.root :controller => "camisetas", :action => 'portada'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action'
end
