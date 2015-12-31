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

    def redirect_for(state, action)
      redirect "/#{@endpoint}?state=#{@journey.start.name}" if state.nil?
      redirect "/#{@endpoint}?state=#{@journey.perform_action(state, action).name}" unless action.nil?
      slim state.to_sym, views: @views_dir, locals: { state_name: state, actions: @journey.allowed_actions(state) }
    end
  end
end
