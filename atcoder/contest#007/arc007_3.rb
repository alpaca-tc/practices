class EconomyPlanner
  def initialize
    @on_and_off = STDIN.gets.strip.split('').map { |v| v == 'o' }
  end

  def generate
    on_and_off = @on_and_off
    patterns_rotated = (0...on_and_off.length).map { on_and_off.rotate!.dup }
    goodness_pattern = @on_and_off
    count = 1

    until goodness_pattern.all?
      goodness_pattern = patterns_rotated.map { |pattern|
        goodness_pattern.zip(pattern).map { |a, b| a || b }
      }.sort_by { |p|
        p.count(true)
      }.last

      count += 1
    end

    puts count
  end
end

EconomyPlanner.new.generate
