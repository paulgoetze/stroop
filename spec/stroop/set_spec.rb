require 'spec_helper'

describe Stroop::Set do

  let(:arguments) { {rows: 1, columns: 2, mode: :neutral } }
  subject { described_class.new(arguments) }

  describe 'creating a new instance' do
    it 'should raise an error if the given mode is not available' do
      expect {
        described_class.new(arguments.merge({ mode: :not_existing }))
      }.to raise_error Stroop::SetModeNotAvailable
    end

    it 'should not raise an error if the given mode is available' do
      expect {
        described_class.new(arguments.merge({ mode: :neutral }))
        described_class.new(arguments.merge({ mode: :congruent }))
        described_class.new(arguments.merge({ mode: :incongruent }))
      }.not_to raise_error
    end
  end

  [:NEUTRAL, :CONGRUENT, :INCONGRUENT, :COLORS, :MODES].each do |name|
    it "should have a constant '#{name}'" do
      expect(described_class.constants).to include name
    end
  end

  [:rows, :columns, :mode].each do |method|
    it "should respond to ##{method}" do
      expect(subject).to respond_to method
    end
  end

  it 'should return a text with the instantiated number of lines' do
    actual_rows   = subject.to_s.lines.count
    expected_rows = subject.rows + 2 # 2 wrapping empty lines (first & last)

    expect(actual_rows).to eq expected_rows
  end

  it 'should return a text with the defined number of words per line' do
    color_regex = /(#{described_class::COLORS.join('|')})/
    line        = subject.to_s.lines[1] # first line with words
    words       = line.scan(color_regex).flatten

    expect(words.count).to eq subject.columns
  end

end
