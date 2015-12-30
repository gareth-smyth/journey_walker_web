require 'spec_helper'
require_relative '../../lib/journey_walker_web/sinatra'

describe JourneyWalkerWeb::Sinatra do
  let(:config) { JSON.parse(File.read('spec/journey_walker_web/config.json'), symbolize_names: true) }
  let(:journey) { JourneyWalker::Journey.new(config) }
  let(:app) do
    described_class.new(endpoint: 'jtest',
                        journey: journey,
                        views_dir: File.join(File.dirname(File.expand_path(__FILE__)), '../views'))
  end

  RSpec.configure { |config| config.include RSpecMixin }

  it 'should redirect to the initial step at the root endpoint' do
    get 'jtest'
    follow_redirect!
    expect(last_response.status).to be(200)
    expect(last_request.url).to include('state=state1')
  end

  it 'should redirect to the next step when an action is performed' do
    get 'jtest?state=state1&action=proceed'
    follow_redirect!
    expect(last_response.status).to be(200)
    expect(last_request.url).to include('state=state2')
  end

  it 'should load the state one slim for state1' do
    get 'jtest?state=state1'
    expect(last_response.status).to be(200)
    expect(last_response.body).to include('Hello, this is state one.')
  end
end
