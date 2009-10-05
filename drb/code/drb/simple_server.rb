require 'drb'

# Start server on a random port serving up an empty array
DRb.start_service nil, []

# We need the uri of the service to connect a client
puts DRb.uri

# wait for the DRb service to finish before exiting
DRb.thread.join