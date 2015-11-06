require 'colorize'

module Stroop
  class Generator

    COLORS = %w{ black white red green blue yellow }

    NEUTRAL     = :neutral
    CONGRUENT   = :congruent
    INCONGRUENT = :incongruent

    MODES  = [NEUTRAL, CONGRUENT, INCONGRUENT].freeze

    attr_reader :rows, :columns, :mode

    def self.print(*args)
      self.new(*args).print
    end

    def initialize(rows:, columns:, mode:)
      @rows    = rows.to_i.abs
      @columns = columns.to_i.abs
      @mode    = mode.to_sym
    end

    def print
      return unless MODES.include?(mode)

      puts empty_line
      (1..rows).each { puts line }
      puts empty_line
    end

    private

    def empty_line
      wrap(space * (total_word_width * columns))
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
