require 'singleton'

class Question
  include Singleton
  include Enumerable

  attr_accessor :answer, :question

  def initialize
    @statement = [
      {
        q: [
          '1',
          '1024',
        ],
        a: "1024\n1024",
      },
      {
        q: [
          '3',
          '3',
          '4',
          '5',
        ],
        a: "12\n0"
      },
      {
        q: [
          '10',
          '1',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8',
          '9',
          '10',
        ],
        a: "55\n0"
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

class Solver
  def initialize
    @positions = gets.chomp.to_i.times.map { gets.chomp.to_i }
  end

  def solve
    max = @positions.inject(&:+)

    base_distance = @positions.max
    rest_distance = max - base_distance

    min = base_distance <= rest_distance ? 0 : base_distance - rest_distance

    "#{max}\n#{min}"
  end
end

if Object.const_defined?(:Question)
  Question.instance.each do |expected|
    puts Solver.new.solve == expected
  end
else
  puts Solver.new.solve
end
