require 'mathn'

# module Stub
#   @count = -1
#   def self.gets
#     @count += 1
#     [
#       '5',
#       'chou 360 shaku',
#       'jou 100 sun',
#       'ken 60 sun',
#       'li 2160 ken',
#       'li 12960 shaku',
#     ][@count]
#   end
# end

@table = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
@keys  = []
def append(from, value, to)
  @table[from][to] = value
  @table[to][from] = (1 / value)
end

N = gets.strip.to_i
N.times do
  from, value, to = gets.strip.split(/\s/)
  value = value.to_i
  append(from, value, to)
end

@res = {}
def solve(key, value = 1)
  @table[key].each do |to, increase|
    unless @res.has_key?(to)
      @res[to] = value * increase
      solve(to, value * increase)
    end
  end
end
solve(@table.keys.first)
result = @res.sort_by { |k, v| v }
min, max = result.first, result.last
puts "1#{min[0]}=#{max[1] / min[1]}#{max[0]}"
