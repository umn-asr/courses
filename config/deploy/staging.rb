role :app, %w{asr-course-staging.oit.umn.edu}
role :web, %w{asr-course-staging.oit.umn.edu}

# Configuration
set :user, 'swadm'
set :server, 'asr-course-staging.oit.umn.edu'
set :roles, %w{web app}
set :web_root, '/swadm/www/courses-staging.umn.edu'
set :deploy_to, "#{fetch(:web_root)}"

server 'asr-course-staging.oit.umn.edu',
  roles: fetch(:roles),
  web_root: fetch(:web_root),
  ssh_options: {
    user: fetch(:user),
    forward_agent: true,
    auth_methods: %w(publickey)}
