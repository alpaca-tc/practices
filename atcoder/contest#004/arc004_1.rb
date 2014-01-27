require 'singleton'

class Question
  include Singleton
  include Enumerable

  attr_accessor :answer, :question

  def initialize
    @statement = [
      {
        q: [
          '3',
          '1 1',
          '2 4',
          '4 3',
        ],
        a: '3.605551',
      },
      {
        q: [
          '10',
          '1 8',
          '4 0',
          '3 7',
          '2 4',
          '5 9',
          '9 1',
          '6 2',
          '0 2',
          '8 6',
          '7 8',
        ],
        a: '10.630146',
      }
    ]
  end

  def each(&block)
    until @statement.empty?
      build_question
      self.instance_exec(@answer, &block)
    end
  end

  def gets
    build_question unless @question && @answer
    @question.shift
  end

  def build_question
    @question, @answer = @statement.shift.values_at(:q, :a)
    answer
  end

  module STDIN
    def self.gets
      Question.instance.gets
    end
  end
  $stdin = STDIN
end

require 'delegate'

class Point < DelegateClass(Array)
  def initialize(*path)
    super([])
    path.dup.length.times { |i| self[i] = path.shift }
  end

  def distance_of(other)
    x = ((self[0] - other[0]) ** 2)
    y = ((self[1] - other[1]) ** 2)
    Math.sqrt(x + y)
  end
end

class Solver
  def initialize
    @points = gets.to_i.times.map { Point.new(*gets.chomp.split(' ').map(&:to_i)) }
  end

  def solve
    lines = []
    @points.combination(2) do |a, b|
      lines << a.distance_of(b)
    end

    sprintf('%.6f', lines.max)
  end
end

if Object.const_defined?(:Question)
  Question.instance.each do |expected|
    puts Solver.new.solve == expected
  end
else
  puts Solver.new.solve
end


