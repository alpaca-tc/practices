luckey_number = gets.chomp.split(' ').map(&:to_i)
bonus_number = gets.chomp.to_i
my_number = gets.chomp.split(' ').map(&:to_i)

count = my_number.inject(0) { |sum, i| sum += 1 if luckey_number.include?(i); sum }
result = case count
         when 6
           1
         when 5
           my_number.include?(bonus_number) ? 2 : 3
         when 4
           4
         when 3
           5
         else
           0
         end

puts result
