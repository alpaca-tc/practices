require 'singleton'

class Question
  include Singleton
  include Enumerable

  attr_accessor :answer, :question

  def initialize
    @statement = [
      {
        q: [
          '3 5 R',
          '790319030',
          '091076399',
          '143245946',
          '590051196',
          '398226115',
          '442567154',
          '112705290',
          '716433235',
          '221041645',
        ],
        a: '8226',
      },
      {
        q: [
          '5 7 D',
          '271573743',
          '915078603',
          '102553534',
          '996473623',
          '595593497',
          '573572507',
          '340348994',
          '253066837',
          '643845096',
        ],
        a: '4646',
      },
      {
        q: [
          '2 2 LU',
          '729142134',
          '509607882',
          '640003027',
          '215270061',
          '214055727',
          '745319402',
          '777708131',
          '018697986',
          '277156993',
        ],
        a: '0700'
      },
      {
        q: [
          '8 9 LU',
          '206932999',
          '471100777',
          '973172688',
          '108989704',
          '246954192',
          '399039569',
          '944715218',
          '003664867',
          '219006823',
        ],
        a: '2853',
      },
      {
        q: [
          '8 7 RD',
          '985877833',
          '469488482',
          '218647263',
          '856777094',
          '012249580',
          '845463670',
          '919136580',
          '011130808',
          '874387671',
        ],
        a: '8878',
      },
      {
        q: [
          '1 1 R',
          '729142134',
          '509607882',
          '640003027',
          '215270061',
          '214055727',
          '745319402',
          '777708131',
          '018697986',
          '277156993',
        ],
        a: '7291'
      },
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
  # R: [row, col],
  GAID = {
    R: [0, 1],
    L: [0, -1],
    U: [-1, 0],
    D: [1, 0],
    RU: [-1, 1],
    RD: [1, 1],
    LU: [-1, -1],
    LD: [1, -1],
  }.freeze

  def initialize
    col, row, @w = gets.chomp.split(' ')
    @course = GAID[@w.to_sym].dup
    @current_index = [row.to_i - 1, col.to_i - 1]
    @map = 9.times.map { gets.chomp.split('').map(&:to_i) }
  end

  def solve
    indexes = [@current_index]
    indexes += 3.times.map { ahead }
    indexes.map { |v| @map[v[0]][v[1]] }.join
  end

  private

  def ahead
    # i == 0 #=> row
    # i == 1 #=> col
    @current_index = @course.dup.map.with_index do |v, i|
      next_index = v + @current_index[i]
      if next_index < 0
        next_index += 2
        @course[i] *= -1
      elsif next_index > 8
        next_index -= 2
        @course[i] *= -1
      end

      next_index
    end

    @current_index
  end
end

if Object.const_defined?(:Question)
  Question.instance.each do |expected|
    res = Solver.new.solve
    puts "#{res}:#{expected}"
    puts res == expected
  end
else
  puts Solver.new.solve
end
