require 'thor'
require_relative 'set'

module Stroop
  class CLI < Thor

    DEFAULT_SIZE = 5.freeze

    def self.start
      super
    end

    desc 'neutral COLSxROWS', 'prints neutral color words in COLS columns and ROWS rows'
    def neutral(size = '10x5')
      print(size: size, mode: Set::NEUTRAL)
    end

    desc 'congruent COLSxROWS', 'prints congruent color words in COLS columns and ROWS rows'
    def congruent(size = '10x5')
      print(size: size, mode: Set::CONGRUENT)
    end

    desc 'incongruent COLSxROWS', 'prints incongruent color words in COLS columns and ROWS rows'
    def incongruent(size = '10x5')
      print(size: size, mode: Set::INCONGRUENT)
    end

    private

    def print(size:, mode:)
      rows, columns = dimensions(size)
      rows_count    = apply_default_size(rows)
      columns_count = apply_default_size(columns)

      puts Set.new(rows: rows_count, columns: columns_count, mode: mode)
    end

    def dimensions(size)
      size.split('x')
    end

    def apply_default_size(number)
      number.to_i.zero? ? DEFAULT_SIZE : number.to_i.abs
    end
  end
end
