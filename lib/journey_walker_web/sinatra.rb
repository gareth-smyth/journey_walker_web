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
      make_endpoints
      super()
    end

    private

    def make_endpoints
      Sinatra.get "/#{@endpoint}" do
        redirect_for(params[:state], params[:action])
      end
      Sinatra.post "/#{@endpoint}" do
        redirect_for(params[:state], params[:action])
      end
    end

    def redirect_for(state_name, action)
      initial_state if state_name.nil?
      perform_transition(action, state_name) unless action.nil?
      respond_with_page(state_name)
    end

    def respond_with_page(state_name)
      state = @journey.current_state(state_name)
      slim state_name.to_sym, views: @views_dir, locals: { state_name: state_name,
                                                           actions: @journey.allowed_actions(state_name),
                                                           data: state[:data] }
    end

    def initial_state
      redirect "/#{@endpoint}?state=#{@journey.start[:name]}"
    end

    def perform_transition(action, state_name)
      symbolised_params = Hash[params.map { |k, v| [k.to_sym, v] }]
      redirect "/#{@endpoint}?state=#{@journey.perform_action(state_name,
                                                              action,
                                                              action_params: symbolised_params)[:name]}"
    end
  end
end
