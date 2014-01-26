require 'singleton'

class Question
  include Singleton
  include Enumerable

  attr_accessor :answer, :question

  def initialize
    @statement = [
      {
        q: [
          '5',
          'Takahashikun is not an eel.'
        ],
        a: '1',
      },
      {
        q: [
          '5',
          'TAKAHASHIKUN loves TAKAHASHIKUN and takahashikun.',
        ],
        a: '3',
      },
      {
        q: [
          '1',
          'takahashikunTAKAHASHIKUNtakahashikun.'
        ],
        a: '0',
      },
      {
        q: [
          '18',
          'You should give Kabayaki to Takahashikun on July twenty seventh if you suspect that he is an eel.'
        ],
        a: '1'
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
  TAKASHI = %w!TAKAHASHIKUN Takahashikun takahashikun!.freeze

  def initialize
    gets
    @line = gets.chomp
  end

  def solve
    @line.split(/\W/).count { |v| TAKASHI.include?(v) }.to_s
  end
end

if Object.const_defined?(:Question)
  Question.instance.each do |expected|
    puts Solver.new.solve == expected
  end
else
  puts Solver.new.solve
end
