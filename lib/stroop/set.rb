require 'colorize'
require_relative 'exceptions'

module Stroop
  class Set

    COLORS = %w{ black white red green blue yellow }

    NEUTRAL     = :neutral
    CONGRUENT   = :congruent
    INCONGRUENT = :incongruent

    MODES  = [NEUTRAL, CONGRUENT, INCONGRUENT].freeze

    attr_reader :rows, :columns, :mode

    def initialize(rows:, columns:, mode:)
      raise SetModeNotAvailable.new unless MODES.include?(mode)

      @rows    = rows.to_i.abs
      @columns = columns.to_i.abs
      @mode    = mode.to_sym
    end

    def to_s
      [empty_line, *lines, empty_line].join("\n")
    end

    private

    def empty_line
      wrap(space * (total_word_width * columns))
    end

    def lines
      (1..rows).map { line }
    end

    def line
      line = (1..columns).map { random_word }.join
      wrap(line)
    end

    def wrap(line)
      space + line + space
    end

    def random_word
      word, color = word_color_pair
      word.center(total_word_width).send(color).bold.on_light_black
    end

    def word_color_pair
      case mode
      when :neutral
        word  = random_color
        color = :black
      when :congruent
        word  = random_color
        color = word
      when :incongruent
        word, color = random_different_colors
      end

      [word, color]
    end

    def random_different_colors
      first  = random_color
      second = random_color

      while first == second
        second = random_color
      end

      [first, second]
    end

    def random_color
      COLORS.sample
    end

    def space
      " ".on_light_black
    end

    def max_word_length
      @max_word_length ||= COLORS.map { |color| color.chars.count }.max
    end

    def total_word_width
      max_word_length + 2
    end
  end
end
