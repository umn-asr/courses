set :rails_env,  "staging"

server 'asr-courses-qat-web-02.oit.umn.edu',
  roles: %w{web app db}
