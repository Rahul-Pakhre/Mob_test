OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1579878905577307', '85935739067ce8542f76ad86d7f0f217'
  # provider :twitter, '2243964830-NJ7vxOmqOMZR5ZD361MQPCagU7KYxwnSHBTw7I6', 'I8b5jNKnwpCBAbdlS1vT8fYSiBC4m0sKKKLohQ53SjrhD'
  provider :twitter, 'H7IZgYt4sruDS8X77ZszXN3Jl', 'DghV6OhxV23vaC5l6zZE2aBDm6s7Qweemly2fqzJvdz8joN13B'
end

