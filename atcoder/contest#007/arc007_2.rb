require 'pry'
N, M = gets.strip.split(/\s+/).map(&:to_i)

cd_cases = Hash.new { |h,k| h[k] = k }
1.upto(N) { |i| cd_cases[i] }

listening = 0

M.times do
  cd_number = gets.strip.to_i
  unless cd_number == listening
    position = cd_cases.key(cd_number)
    cd_cases[position] = listening
    listening = cd_number
  end
end

cd_cases.values.each { |v| puts v }
