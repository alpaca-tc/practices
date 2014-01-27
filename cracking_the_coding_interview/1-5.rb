class String
  def zip
    new_chars = ''
    current_chars = chars
    current_char = [current_chars.shift, 1]

    current_chars.each do |char|
      if char == current_char[0]
        current_char[1] += 1
      else
        new_chars += "#{current_char[0]}#{current_char[1]}"
        current_char = [char, 1]
      end
    end

    new_chars += "#{current_char[0]}#{current_char[1]}"
    new_chars
  end
end

raise 'pending' unless lambda do
  begin
    'aabcccccaaa'.zip == 'a2b1c5a3'
  rescue => e
    p e
  end
end.call
