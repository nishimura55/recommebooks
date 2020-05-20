server '52.198.23.227', user: 'naoki', roles: %w{app db web} 

set :ssh_options, keys: '~/.ssh/aws/recommebooks.pem'