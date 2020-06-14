require 'thor'
require_relative 'set'

module Stroop
  class CLI < Thor
    DEFAULT_SIZE = 5.freeze

    class_option :seed, type: :numeric, aliases: "-s", description: "The random seed to generate the color words"

    desc 'neutral COLSxROWS', 'prints neutral color words in COLS columns and ROWS rows'
    def neutral(size = '10x5')
      print(size: size, mode: Set::NEUTRAL, seed: options[:seed])
    end

    desc 'congruent COLSxROWS', 'prints congruent color words in COLS columns and ROWS rows'
    def congruent(size = '10x5')
      print(size: size, mode: Set::CONGRUENT, seed: options[:seed])
    end

    desc 'incongruent COLSxROWS', 'prints incongruent color words in COLS columns and ROWS rows'
    def incongruent(size = '10x5')
      print(size: size, mode: Set::INCONGRUENT, seed: options[:seed])
    end

    private

    def print(size:, mode:, seed:)
      rows, columns = dimensions(size)
      rows          = apply_default_size(rows)
      columns       = apply_default_size(columns)

      set = Stroop::Set.new(rows: rows, columns: columns, mode: mode, seed: seed)
      puts set, "🌱 Generated with seed: #{set.seed}"
    end

    def dimensions(size)
      size.split('x')
    end

    def apply_default_size(number)
      number.to_i.zero? ? DEFAULT_SIZE : number.to_i.abs
    end
  end
end
