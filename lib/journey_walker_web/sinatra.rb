require 'journey_walker'
require 'sinatra/base'

module JourneyWalkerWeb
  # This sinatra app can be created with a journey and will automatically use slim templates defined under
  # /templates with the same name as the states in the journey
  class Sinatra < Sinatra::Base
    def initialize(endpoint, journey)
      @journey = journey
      Sinatra.get '/' + endpoint do
        respond_for
      end
      super()
    end

    def respond_for
      @journey.start.name
    end
  end
end
