require 'mongrel_cluster/recipes'

set :user, "fguillen"
set :runner, "fguillen"

set :application, "tienda"
set :repository,  "http://www.fernandoguillen.info/svn/play/sose/trunk/"
set :scm_username, "xxxx"
set :scm_password, "xxxx"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/railsapps/#{application}"


set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"



# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "fernandoguillen.info:2322"
role :web, "fernandoguillen.info:2322"
role :db,  "fernandoguillen.info:2322", :primary => true
