require 'thor'
require_relative 'generator'

module Stroop
  class CLI < Thor

    DEFAULT_SIZE = 5.freeze

    def self.start
      super
    end

    desc 'incongruent COLSxROWS', 'prints incongruent color words in COLS columns and ROWS rows'
    def incongruent(size = '10x5')
      rows, columns = dimensions(size)
      rows_count    = apply_default_size(rows)
      columns_count = apply_default_size(columns)

      Generator.print(rows: rows_count, columns: columns_count)
    end

    private

    def dimensions(size)
      size.split('x')
    end

    def apply_default_size(number)
      number.to_i.zero? ? DEFAULT_SIZE : number.to_i.abs
    end
  end
end
