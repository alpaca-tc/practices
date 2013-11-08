require 'mathn'

module Stub
  @idx = -1

  def self.gets
    @idx += 1
    [
     '7',
     '3 3',
     '2 5',
     '4 6',
     '2 3',
     '3 6',
     '3 4',
     '4 6',
     '2 5',
     '1 5'
    ][@idx]
  end
end

N = Stub::gets.chomp.to_i
START, GOAL = Stub::gets.chomp.split(' ').map { |str| str.to_i }
@route = []
(N + 1).times do |idx|
  @route << Stub::gets.chomp.split(' ').map { |str| str.to_i }
end

result = []
position = [N, START]
line = N

until line <= 0
  way = @route[line][0]...@route[line][1]
  next_way = way
  p way

  # until way.cover?(next_way)
  #   next_way = @route[line - 1][0]...@route[line - 1][1]
  #   line -= 1
  # end
  line -= 1
end
