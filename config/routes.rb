ActionController::Routing::Routes.draw do |map|
  map.resources :disciplinas

  map.resources :logs

  map.resources :apuracaos, :collection => {:filtros => :get, :classificacao => :get}

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users, :collection => {:associar => :get}
  map.resource :about
  map.resource :session
  map.sobre '/sobre', :controller => 'abouts'
  map.resources :formularios, :collection => {:cancelados => :get, :classificacao => :get, :impressao => :get,:listagem_por_curso => :get, :naoautorizado => :get, :nota => :get , :apuracao_nota => :get, :listar_nota => :get, :listar_nota_curso => :get, :classificacao_curso => :get, :sem_documentos => :get, :completa => :get, :edital => :get, :iformulario => :get}
  map.email_geral '/email_geral', :controller => 'homes', :action => "email_geral"
  map.busca_cpf '/busca_cpf', :controller => 'homes', :action => "busca_cpf"
  map.status '/status_inscricao', :controller => 'formularios', :action => 'ativo'
  map.cancelados '/cancelados', :controller => 'formularios', :action => 'cancelados'
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.root :controller => "homes"
   map.buscar '/buscar', :controller => 'homes', :action => 'buscar'
   map.edital '/edital', :controller => 'formularios', :action => 'edital'
   map.download_edital '/download', :controller => 'formularios', :action => 'download_edital'
  # See how all your routes lay out with "rake routes"
   map.anexo '/download', :controller => 'homes', :action => 'edital'
   map.listagem '/listagem', :controller => 'apuracaos', :action => 'listagem'
   map.gabarito '/gabarito', :controller => 'homes', :action => 'gabarito'
   map.ativo '/listagem_ativos', :controller => 'homes', :action => 'listagem_ativos'
   map.documento '/listagem_documentos', :controller => 'homes', :action => 'listagem_com_documentos'
   map.filtro '/filtro', :controller => "apuracaos", :action => "seleciona_curso"
   map.inscrito '/inscrito', :controller => "apuracaos", :action => "inscrito"
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
