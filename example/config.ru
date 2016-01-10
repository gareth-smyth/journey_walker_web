require_relative '../lib/journey_walker_web/sinatra'
require_relative 'services/customer_service'
require_relative 'services/identity_service'
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
          name: 'email',
          value: {
            source: 'customer_service',
            source_method: 'fetch_email',
            parameters: [
              {
                name: 'user',
                value: {
                  source: 'identity_service',
                  source_method: 'identity'
                }
              }
            ]
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
    },
    {
      type: 'custom',
      name: 'identity_service',
      parameters: [
        {
          name: 'class_name',
          value: 'JourneyWalkerWeb::Example1::IdentityService'
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
    },
    {
      from: 'email_address',
      to: 'menu',
      action: 'save',
      data: {
        friendly_name: 'Save & Return to Menu'
      },
      events: [
        {
          'source': 'customer_service',
          'source_method': 'update_email',
          'parameters': [
            {
              'name': 'user',
              value: {
                source: 'identity_service',
                source_method: 'identity'
              }
            },
            {
              'name': 'email',
              'value': {
                'type': 'action_param',
                'name': 'form_email'
              }
            }
          ]
        }
      ]
    }
  ]
}

run JourneyWalkerWeb::Sinatra.new(endpoint: 'settings',
                                  journey: JourneyWalker::Journey.new(config),
                                  views_dir: File.join(File.dirname(File.expand_path(__FILE__)), 'views'))
