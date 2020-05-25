server ENV['EC2_IP_ADRESS'],
    port: 22,
    user: 'naoki',
    roles: %w{app db web},
    primary: true,
    ssh_options: {
        user: 'naoki',
        keys: ["#{ENV['EC2_SSH_KEY_PASS']}"],
        forward_agent: true
    }



    # '52.198.23.227'

    # '~/.ssh/aws/recommebooks.pem'