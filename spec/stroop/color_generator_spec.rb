require 'spec_helper'

describe Stroop::ColorGenerator do
  describe 'without seed' do
    subject { described_class.new }

    describe '#generate' do
      it 'returns a random color' do
        expect(Stroop::ColorGenerator::COLORS).to include subject.generate
      end
    end

    describe '#generate_pair' do
      it 'returns a pair of colors that are different' do
        20.times do
          first, second = subject.generate_pair
          expect(first).to_not eq second
        end
      end

      it 'returns another pair in subsequent calls' do
        previous_colors = subject.generate_pair

        20.times do
          new_colors = subject.generate_pair
          expect(new_colors).to_not eq previous_colors
          previous_colors = new_colors
        end
      end
    end

    describe 'with seed' do
      let(:seed) { 1234 }
      let(:generator) { described_class.new(seed: seed) }
      let(:other_generator) { described_class.new(seed: seed) }

      describe '#generate' do
        it 'uses the given seed to generate colors deterministically' do
          20.times { expect(generator.generate).to eq other_generator.generate }
        end
      end

      describe '#generate_pair' do
        it 'uses the given seed to generate colors deterministically' do
          20.times { expect(generator.generate_pair).to eq other_generator.generate_pair }
        end
      end

      it 'generates the same colors for #generate and #generate_pair (first color only)' do
        generated_colors = 20.times.map { generator.generate }
        generated_pairs_first_colors = 20.times.map { other_generator.generate_pair.first }

        expect(generated_colors).to eq generated_pairs_first_colors
      end
    end
  end
end
