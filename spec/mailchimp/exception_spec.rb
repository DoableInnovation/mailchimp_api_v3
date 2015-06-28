# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::APIKeyError, vcr: { cassette_name: 'exception' } do
  let(:bad_key) { 'xxxxxxxxxx-us11' }

  it 'raises an exception if the API key is not valid' do
    expect { Mailchimp.connect(bad_key).account }.to raise_error { |e|
      expect(e).to be_a Mailchimp::APIKeyError
      expect(e.type).to eq 'http://kb.mailchimp.com/api/error-docs/401-api-key-invalid'
      expect(e.title).to eq 'API Key Invalid'
      expect(e.status).to eq 401
      expect(e.detail).to eq 'Your API key may be invalid, or you\'ve attempted to access the wrong datacenter.'
    }
  end
end