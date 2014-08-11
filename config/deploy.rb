lock '3.2.1'

set :application, 'oasis'
set :repo_url, "git@github.com:GSA/oasis.git"
set :rails_env, "production"
set :deploy_to, "/home/search/oasis"
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets}
set :linked_files, %w{config/flickr.yml config/instagram.yml config/secrets.yml config/elasticsearch.yml}
set :bundle_binstubs, nil

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :parallel do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
  after :finishing, "deploy:cleanup"

end
