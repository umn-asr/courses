set :rails_env,  "staging"

server 'asr-courses-qat-web-03.oit.umn.edu',
  roles: %w{web app db}
