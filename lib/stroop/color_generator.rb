module Stroop
  class ColorGenerator
    COLORS = %w{ black white red green blue yellow }.freeze

    attr_reader :seed

    def initialize(seed: nil)
      @seed = seed || Random.new_seed
      @single_random = Random.new(@seed)
      @pair_random = Random.new(@seed)
    end

    def generate
      selected = random_select(@single_random)

      while selected == @last_generated do
        selected = random_select(@single_random)
      end

      @last_generated = selected
    end

    def generate_pair
      first = generate
      second = random_select(@pair_random)

      while first == second || second == @last_generated_second do
        second = random_select(@pair_random)
      end

      @last_generated_second = second
      [first, second]
    end

    private

    def random_select(random)
      COLORS.sample(random: random)
    end
  end
end
