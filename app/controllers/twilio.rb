require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']

@client.messages.create(
  from: '+14085604374 ',
  to: '+14084555868',
  body: 'Hey there!'
)
