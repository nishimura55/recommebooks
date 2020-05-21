server '52.198.23.227',
    user: 'naoki',
    roles: %w{app db web},
    ssh_options: {
        user: 'naoki',
        keys: '~/.ssh/aws/recommebooks.pem',
        forward_agent: true
    }