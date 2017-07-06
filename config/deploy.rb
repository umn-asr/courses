# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'courses'
set :repo_url, 'https://github.com/umn-asr/courses'
set :web_root, '/swadm/www/courses.umn.edu'
set :deploy_to, "#{fetch(:web_root)}"
set :user, 'swadm'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :linked_dirs, %w(log tmp/cache)
set :linked_files, %w{config/database.yml config/initializers/environment_variables.rb}

set :whenever_environment, ->{ "#{fetch(:rails_env)}" }
set :whenever_identifier,  ->{ "#{fetch(:application)}_#{fetch(:rails_env)}" }
set :whenever_roles,       ->{ [:prod] }

set :ssh_options, {
  user: fetch(:user),
  forward_agent: true,
  auth_methods: %w(publickey)
}

namespace :deploy do
  desc 'Symlink Repository'
  task :symlink_repo do
    on roles(:app) do
      execute :ln, "-nsf #{deploy_to}/repo #{release_path}/.git"
    end
  end

  desc 'link in the shared tmp folder'
  task :link_shared_tmp_folder do
    on roles(:app) do
      execute "ln -nfs /swadm/tmp #{release_path}/tmp/json_tmp"
    end
  end

  task :configure_monit do
    on roles(:all) do
      execute "cp #{release_path}/config/monit/* /swadm/etc/monit.d/"
      execute "monit reload"
    end
  end

  after :updating, :symlink_repo
  after :updating, :link_shared_tmp_folder
  after :publishing, :configure_monit
end


set :passenger_restart_with_touch,  true
