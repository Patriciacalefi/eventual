set :application, "192.168.0.5"
set :repository,  "git://github.com/seducpma/eventual.git"

set :user, "servidor"
set :use_sudo, false
set :deploy_to, "/home/#{user}/eventual.seducpma.com"
set :scm, :git       

server application, :app, :web, :db, :primary => true

after "deploy:update_code", "deploy:custom_symlinks"
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end

   task :custom_symlinks do
     run "rm -rf #{release_path}/public/anexo"
     run "ln -s #{shared_path}/503.html #{release_path}/public/503.html"
     run "ln -s #{shared_path}/anexo #{release_path}/public/anexo"
   end

    desc "Update the crontab file"
    task :update_crontab, :roles => :db do
      run "cd #{release_path} && whenever --update-crontab #{application}"
    end


 end

