require 'spec_helper'

describe Stroop::CLI do
  let(:seed) { 1234 }

  before do
    allow_any_instance_of(Stroop::Set).to receive(:seed) { seed }
    allow_any_instance_of(Stroop::Set).to receive(:to_s) { '' }
    allow($stdout).to receive(:puts) { '' }
  end

  subject { described_class.new([seed]) }

  [:neutral, :congruent, :incongruent].each do |method|
    it { is_expected.to respond_to method }

    describe "##{method}" do
      let(:columns) { 1 }
      let(:rows) { 1 }
      let(:args) { "#{columns}x#{rows}" }

      it 'prints to the standard output' do
        expect { subject.send(method, args) }.to output.to_stdout
      end

      it 'prints the stroop set' do
        set = Stroop::Set.new(columns: columns, rows: rows, mode: method, seed: seed)
        output = capture(:stdout) { subject.send(method, args) }

        expect(output).to include set.to_s
        expect(output).to include "Generated with seed: #{seed}"
      end
    end
  end
end
