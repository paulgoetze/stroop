require 'colorize'
require_relative 'exceptions'
require_relative 'color_generator'

module Stroop
  class Set
    NEUTRAL     = :neutral
    CONGRUENT   = :congruent
    INCONGRUENT = :incongruent

    MODES  = [NEUTRAL, CONGRUENT, INCONGRUENT].freeze

    BOX = {
      vertical: "┊",
      horizontal: "┄",
      top_left: "┌",
      top_right: "┐",
      bottom_left: "└",
      bottom_right: "┘"
    }.transform_values(&:light_black).freeze

    attr_reader :rows, :columns, :mode, :seed

    def initialize(rows:, columns:, mode:, seed: nil)
      raise SetModeNotAvailable.new unless MODES.include?(mode)

      @rows = rows.to_i.abs
      @columns = columns.to_i.abs
      @mode = mode.to_sym
      @generator = ColorGenerator.new(seed: seed)
      @seed = @generator.seed
    end

    def to_s
      [empty_line(:top), *lines, empty_line(:bottom)].join("\n")
    end

    private

    def empty_line(location)
      corner_left = BOX[:"#{location}_left"]
      line = BOX[:horizontal] * (total_word_width * columns)
      corner_right = BOX[:"#{location}_right"]

      corner_left + line + corner_right
    end

    def lines
      (1..rows).map { line }
    end

    def line
      line = (1..columns).map { random_word }.join
      wrap(line)
    end

    def wrap(line)
      BOX[:vertical] + line + BOX[:vertical]
    end

    def random_word
      word, color = word_color_pair
      word.center(total_word_width).send(color).bold
    end

    def word_color_pair
      case mode
      when :neutral
        word  = @generator.generate
        color = :black
      when :congruent
        word  = @generator.generate
        color = word
      when :incongruent
        word, color = @generator.generate_pair
      end

      [word, color]
    end

    def max_word_length
      @max_word_length ||= ColorGenerator::COLORS.map { |color| color.chars.count }.max
    end

    def total_word_width
      max_word_length + 2
    end
  end
end
