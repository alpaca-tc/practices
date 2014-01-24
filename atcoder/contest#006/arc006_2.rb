module Stub
  def gets
    @count = -1 unless @count
    @count += 1
    [
      [
        '1 5',
        '|',
        '|',
        '|',
        '|',
        '|',
        'o',
      ],
      [
        '4 2',
        '| | | |',
        '| | | |',
        '      o',
      ]
    ][1][@count]
  end
end
extend Stub

class Amida
  attr_accessor :line, :goal

  def initialize(length)
    @length = length
    @start_to_goal = Array.new(length) { |i| i + 1 }
  end

  def append_line(line)
    line.gsub('|', '').chars.map.with_index do |char, index|
      if char == '-'
        @start_to_goal[index], @start_to_goal[index + 1] =
          @start_to_goal[index + 1], @start_to_goal[index]
      end
    end
  end

  def solve
    raise 'Goal is not given!' unless @goal
    raise 'Goal is invalid!' unless @start_to_goal[@goal]
    @start_to_goal[@goal]
  end
end

N, L = gets.split(' ').map(&:to_i)

solver = Amida.new(N)
(0...L).map { |v| solver.append_line(gets.chomp) }
solver.goal = (gets.chomp.index('o') / 2).ceil
p solver.solve
