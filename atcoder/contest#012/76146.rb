input = STDIN.gets.chomp
n, va, vb, l = input.split(' ').map { |i| i.to_f }

n.to_i.times do
  time = l / Float(va)
  l = time * vb
  p l
end
