ActionController::Routing::Routes.draw do |map|
  map.connect 'projects/:project_id/hipchat', :controller => 'hipchat', :action => 'index'
  map.connect 'projects/:project_id/hipchats', :controller => 'hipchat', :action => 'save'
end