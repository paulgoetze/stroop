require 'colorize'
require_relative 'exceptions'

module Stroop
  class Set
    COLORS = %w{ black white red green blue yellow }.freeze

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

    attr_reader :rows, :columns, :mode

    def initialize(rows:, columns:, mode:)
      raise SetModeNotAvailable.new unless MODES.include?(mode)

      @rows    = rows.to_i.abs
      @columns = columns.to_i.abs
      @mode    = mode.to_sym
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
      color = COLORS.sample
      color = random_color if color == @latest_random_color
      @latest_random_color = color
    end

    def max_word_length
      @max_word_length ||= COLORS.map { |color| color.chars.count }.max
    end

    def total_word_width
      max_word_length + 2
    end
  end
end
