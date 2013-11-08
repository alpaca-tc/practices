gets
answers = gets.strip.split('')
result = (1..4).to_a.map { |i| answers.select { |v| v.to_i == i }.length }
puts "#{result.max} #{result.min}"
