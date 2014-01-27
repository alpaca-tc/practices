class Array
  def tilt(angle)
    self.transpose.map { |v| v.reverse }
  end
end

raise 'pending' unless lambda do
  begin
    [
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 10, 11, 12],
      [13, 14, 15, 16],
    ].tilt(1) == [
      [13, 9, 5, 1],
      [14, 10, 6, 2],
      [15, 11, 7, 3],
      [16, 12, 8, 4],
    ]
  rescue => e
    p e
  end
end.call
