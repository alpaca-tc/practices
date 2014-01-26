module Stub
  Q_AND_A = [
    {
      q: [
      ],
      a: ''
    },
    {
      q: [
      ],
      a: ''
    }
  ]

  def gets
    @q_and_a ||= Q_AND_A.dup

    q_and_a = @q_and_a.pop
    [
,
      %w[
        7
        93
        249
        150
        958
        442
        391
        25
      ],
    ][1][@count]
  end

  def self.answer
    raise 'pending' unless lambda do
      begin
        answer = Solver.new.solve
      rescue => e
        p e
      end
    end.call
  end
end

class Solver
  include Stub if const_defined?(:Stub)

  def initialize
  end

  def solve
  end
end


