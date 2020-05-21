# config valid for current version and patch releases of Capistrano
lock "~> 3.14.0"

set :application, "recommebooks"

set :repo_url, "git@github.com:nishimura55/recommebooks.git"

set :branch, 'master'

set :deploy_to, "/var/www/projects/recommebooks"

set :linked_files, fetch(:linked_files, []).push('config/master.key')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :keep_releases, 5

set :rbenv_ruby, '2.7.0'

set :log_level, :debug

set :default_environment, { 
    'PKG_CONFIG_PATH' => '/usr/lib/pkgconfig:/usr/local/lib/pkgconfig'
}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
