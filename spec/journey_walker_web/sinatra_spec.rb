require 'spec_helper'
require_relative '../../lib/journey_walker_web/sinatra'

describe JourneyWalkerWeb::Sinatra do
  let(:config) { JSON.parse(File.read('spec/journey_walker_web/config.json'), symbolize_names: true) }
  let(:journey) { JourneyWalker::Journey.new(config) }
  let(:app) { described_class.new('jtest', journey) }

  RSpec.configure { |config| config.include RSpecMixin }

  it 'should get the initial step at the root endpoint' do
    get 'jtest'
    expect(last_response.status).to be(200)
    expect(last_response.body).to include('state1')
  end
end
