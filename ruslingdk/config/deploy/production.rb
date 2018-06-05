# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server '172.19.10.19', user: 'deploy', roles: %w[app db web],
                       ssh_options: {
                         proxy: Net::SSH::Proxy::Command.new(
                           if !ENV['SSHPASS'].nil?
                             'sshpass -e ssh fthoms16@student.aau.dk@sshgw.aau.dk -W %h:%p'
                           else
                             'ssh fthoms16@student.aau.dk@sshgw.aau.dk -W %h:%p'
                           end
                         )
                       }

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.
set :stage,           :production
set :rails_env,       'production'
set :puma_env,        fetch(:rack_env, fetch(:rails_env, 'production'))

set :deploy_via,      :remote_cache

set :puma_threads,    [4, 16]
set :puma_workers,    4

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord

set :nginx_config_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :nginx_flags, 'fail_timeout=0'
set :nginx_http_flags, fetch(:nginx_flags)
set :nginx_server_name, 'rusling.dk www.rusling.dk 192.38.56.109'
set :nginx_sites_available_path, '/etc/nginx/sites-available'
set :nginx_sites_enabled_path, '/etc/nginx/sites-enabled'
set :nginx_socket_flags, fetch(:nginx_flags)
set :nginx_ssl_certificate, '/etc/nginx/ssl/nginx.crt'
set :nginx_ssl_certificate_key, '/etc/nginx/ssl/nginx.key'
set :nginx_use_ssl, false

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
set :ssh_options,   keys: %w[~/.ssh/id_rsa],
                    forward_agent: true,
                    auth_methods: %w[publickey password]
