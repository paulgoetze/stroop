require 'colorize'

module Stroop
  class Generator

    COLORS = %w{ black white red green blue yellow }

    attr_reader :rows, :columns

    def self.print(*args)
      self.new(*args).print
    end

    def initialize(rows:, columns:)
      @rows    = rows.to_i.abs
      @columns = columns.to_i.abs
    end

    def print
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
      word, color = random_different_colors
      word.center(total_word_width).send(color).bold.on_light_black
    end

    def random_different_colors
      color_a = COLORS.sample
      color_b = COLORS.sample

      while color_a == color_b
        color_b = COLORS.sample
      end

      [color_a, color_b]
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
