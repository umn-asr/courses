set :rails_env,  "staging"

server 'asr-course-staging.oit.umn.edu',
  roles: %w{web app db}