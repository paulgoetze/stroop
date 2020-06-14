require 'spec_helper'

describe Stroop::Set do
  [:neutral, :incongruent, :congruent].each do |mode|
    let(:arguments) { {rows: 1, columns: 2, mode: mode } }
    subject { described_class.new(**arguments) }

    describe 'creating a new instance' do
      it 'raises an error if the given mode is not available' do
        expect {
          described_class.new(**arguments.merge({ mode: :not_existing }))
        }.to raise_error Stroop::SetModeNotAvailable
      end

      it 'does not raise an error if the given mode is available' do
        expect {
          described_class.new(**arguments.merge({ mode: :neutral }))
          described_class.new(**arguments.merge({ mode: :congruent }))
          described_class.new(**arguments.merge({ mode: :incongruent }))
        }.not_to raise_error
      end
    end

    [:NEUTRAL, :CONGRUENT, :INCONGRUENT, :MODES].each do |name|
      it "has a constant '#{name}'" do
        expect(described_class.constants).to include name
      end
    end

    [:rows, :columns, :mode, :seed].each do |method|
      it "responds to ##{method}" do
        expect(subject).to respond_to method
      end
    end

    describe '#to_s' do
      it 'returns a text with the instantiated number of lines' do
        actual_rows   = subject.to_s.lines.count
        expected_rows = subject.rows + 2 # 2 wrapping empty lines (first & last)

        expect(actual_rows).to eq expected_rows
      end

      it 'returns a text with the defined number of words per line' do
        color_regex = /(#{Stroop::ColorGenerator::COLORS.join('|')})/
        line        = subject.to_s.lines[1] # first line with words
        words       = line.scan(color_regex).flatten

        expect(words.count).to eq subject.columns
      end

      it 'returns the same text for the same seed' do
        args = arguments.merge(seed: 1234)
        set = described_class.new(**args)
        other_set = described_class.new(**args)

        expect(set.to_s).to eq other_set.to_s
      end

      it 'returns different texts for the different seeds' do
        set = described_class.new(**arguments.merge(seed: 1))
        other_set = described_class.new(**arguments.merge(seed: 2))

        expect(set.to_s).to_not eq other_set.to_s
      end
    end

    describe '#seed' do
      it 'returns the seed the set was initialized with' do
        seed = Random.rand(100)
        args = arguments.merge(seed: seed)
        expect(described_class.new(**args).seed).to eq seed
      end

      it "returns a random seed if none was given" do
        set = described_class.new(**arguments)
        expect(set.seed).to_not be_nil
        expect(set.seed).to be_a Integer
      end
    end
  end
end
