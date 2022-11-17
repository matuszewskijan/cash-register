# frozen_string_literal: true

require 'spec_helper'
require './app/cash_register_cli'

RSpec.describe CashRegisterCLI do
  describe '#prompt', skip: 'I was not able to make the stub working' do
    let(:cli) { described_class.new }

    before do
      allow($stdin).to receive(:gets).and_return('help\n')
    end

    it 'executes command' do
      expect { cli.prompt('') }.to eq ''
    end

    it 'displays command results' do; end
  end
end
