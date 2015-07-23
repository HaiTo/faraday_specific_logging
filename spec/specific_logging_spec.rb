require 'spec_helper'

describe Faraday::SpecificLogging do
  let(:options) { {logger: logger, target_key: target_key} }
  let(:middleware) { described_class.new(lambda {|env| env }, options) }
  let(:rails_logger) { Rails.logger }

  def process(body, method = :post)
    env = {body: body, request_headers: Faraday::Utils::Headers.new}
    env[:method] = method
    middleware.call(Faraday::Env.from(env))
  end

  before do
    allow(middleware).to receive(:@logger).and_return(rails_logger)
  end

  context 'when missing options' do
    context 'missing logger' do
      let(:logger) { nil }
      let(:target_key) { 'id' }

      specify do
        expect(rails_logger).not_to receive(:send)

        process('id=2')
      end
    end

    context 'missing target_key' do
      let(:logger) { Rails.logger }
      let(:target_key) { nil }

      specify do
        expect(rails_logger).not_to receive(:send)

        process('id=2')
      end
    end
  end

  context 'when correct case' do
    let(:logger) { Rails.logger }
    let(:target_key) { :id }

    specify do
      expect(rails_logger).to receive(:send)

      process('id=2')
    end
  end
end
