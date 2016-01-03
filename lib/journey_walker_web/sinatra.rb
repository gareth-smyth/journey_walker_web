require 'journey_walker'
require 'sinatra/base'
require 'slim'

module JourneyWalkerWeb
  # This sinatra app can be created with a journey and will automatically use slim templates defined under
  # /templates with the same name as the states in the journey
  class Sinatra < Sinatra::Base
    def initialize(parameters = {})
      @endpoint = parameters.fetch(:endpoint, false)
      @journey = parameters.fetch(:journey, false)
      @views_dir = parameters.fetch(:views_dir, false)
      Sinatra.get "/#{@endpoint}" do
        redirect_for(params[:state], params[:action])
      end
      super()
    end

    def redirect_for(state_name, action)
      redirect "/#{@endpoint}?state=#{@journey.start[:name]}" if state_name.nil?
      redirect "/#{@endpoint}?state=#{@journey.perform_action(state_name, action)[:name]}" unless action.nil?
      state = @journey.current_state(state_name)
      slim state_name.to_sym, views: @views_dir, locals: { state_name: state_name,
                                                           actions: @journey.allowed_actions(state_name),
                                                           data: state[:data] }
    end
  end
end
