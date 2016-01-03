require_relative '../lib/journey_walker_web/sinatra'
require_relative 'services/customer_service'
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
      name: 'email_address',
      data: [
        {
          name: 'customer_data',
          value: {
            source: 'customer_service',
            source_method: 'fetch_email'
          }
        }
      ]
    }
  ],
  data_sources: [
    {
      type: 'custom',
      name: 'customer_service',
      parameters: [
        {
          name: 'class_name',
          value: 'JourneyWalkerWeb::Example1::CustomerService'
        }
      ]
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
      action: 'parental_controls',
      data: {
        friendly_name: 'Parental Controls'
      }
    },
    {
      from: 'menu',
      to: 'email_address',
      action: 'email_address',
      data: {
        friendly_name: 'Email Address'
      }
    },
    {
      from: 'parental_controls',
      to: 'menu',
      action: 'back',
      data: {
        friendly_name: 'Back to Menu'
      }
    },
    {
      from: 'email_address',
      to: 'menu',
      action: 'back',
      data: {
        friendly_name: 'Back to Menu'
      }
    }
  ]
}

run JourneyWalkerWeb::Sinatra.new(endpoint: 'settings',
                                  journey: JourneyWalker::Journey.new(config),
                                  views_dir: File.join(File.dirname(File.expand_path(__FILE__)), 'views'))
