require 'spec_helper'

describe Stroop::CLI do

  before do
    allow_any_instance_of(Stroop::Set).to receive(:to_s) { '' }
    allow($stdout).to receive(:puts) { '' }
  end

  [:neutral, :congruent, :incongruent].each do |method|
    it { is_expected.to respond_to method }

    describe "##{method}" do
      let(:size) { '1x1' }

      it 'should create a new Stroop::Set' do
        expect(Stroop::Set).to receive(:new).once
        subject.send(method, size)
      end

      it 'should convert the Stroop::Set to a string' do
        expect_any_instance_of(Stroop::Set).to receive(:to_s).once
        subject.send(method, size)
      end

      it 'should print to the standard output' do
        expect { subject.send(method, size) }.to output.to_stdout
      end
    end
  end

end
