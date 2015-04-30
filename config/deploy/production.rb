set :rails_env,  "production"

server 'asr-course-production.oit.umn.edu',
  roles: %w{web app db prod}
