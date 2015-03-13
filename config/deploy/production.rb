role :app, %w{asr-course-production.oit.umn.edu}
role :web, %w{asr-course-production.oit.umn.edu}

# Configuration
set :user, 'swadm'
set :server, 'asr-course-production.oit.umn.edu'
set :roles, %w{web app db}
set :web_root, '/swadm/www/courses.umn.edu'
set :deploy_to, "#{fetch(:web_root)}"

server 'asr-course-production.oit.umn.edu',
  roles: fetch(:roles),
  web_root: fetch(:web_root),
  ssh_options: {
    user: fetch(:user),
    forward_agent: true,
    auth_methods: %w(publickey)}
