# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'courses'
set :repo_url, 'https://github.com/umn-asr/courses'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call


set :linked_dirs, %w(bin log tmp/cache vendor/bundle)
set :linked_files, %w{config/database.yml config/initializers/environment_variables.rb}

after "deploy:updated", :link_shared_tmp_folder do
  # link in the shared tmp folder
  on roles(:app) do
    execute "ln -nfs /swadm/tmp #{release_path}/tmp/json_tmp"
  end
end
