set :rails_env,  "production"

server 'asr-courses-prd-web-03.oit.umn.edu',
  roles: %w{web app db prod}
