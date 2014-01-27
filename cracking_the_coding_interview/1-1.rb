class String
  def are_chars_unique?
    self.chars.all? { |v| self.count(v) == 1 }
  end
end
