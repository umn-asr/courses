# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'courses'
set :repo_url, 'https://github.com/umn-asr/courses'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call


set :linked_dirs, %w(bin log tmp/cache vendor/bundle)

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
