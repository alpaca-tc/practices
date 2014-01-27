class String
  def is_anagram?(other)
    self.chars.sort == other.chars.sort
  end
end

p 'dog'.is_anagram?('god')
