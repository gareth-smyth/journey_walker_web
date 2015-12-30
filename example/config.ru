require_relative '../lib/journey_walker_web/sinatra'
require 'journey_walker'

config = {
  states: [
    {
      name: 'menu'
    },
    {
      name: 'parental_controls'
    },
    {
      name: 'email_address'
    }
  ],
  transitions: [
    {
      to: 'menu',
      action: 'start'
    },
    {
      from: 'menu',
      to: 'parental_controls',
      action: 'parental_controls'
    },
    {
      from: 'menu',
      to: 'email_address',
      action: 'email_address'
    }
  ]
}

run JourneyWalkerWeb::Sinatra.new(endpoint: 'settings', journey: JourneyWalker::Journey.new(config))
