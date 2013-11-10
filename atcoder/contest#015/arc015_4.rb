require 'mathn'

module Stub
  def gets
    @count = -1 unless @count
    @count += 1
    [
      # '10 2 0.5',
      # '0.5 10 1',
      # '0.5 2 1',

      # '100000 3 0.01',
      # '0.48175 7 77',
      # '0.033325 777 13',
      # '0.484925 1 100',

      '300 1 1',
      '1 2 1000'
    ][@count]
  end
end
extend Stub

effects = []
T, N, P = gets.strip.split(/\s/).map { |v| v.to_f }
N.to_i.times do
  # probability, pow, duration
  effects << gets.strip.split(/\s/).map { |v| v.to_f }
end

class CookieBabaa
  def initialize(t, p, effects)
    @time = 0
    @duration = t
    @probability = p
    @cookie = 1
    @golden_time = []
    @effects = effects
  end

  def go_ahead
    @time += 1
    evaluate_golden_time
    display_golden_cookie
  end

  def start
    0.upto(@duration - 1) do
      go_ahead
      report
    end

    @cookie
  end

  private
  def report
    puts <<-CODE.gsub(/^\s/, '')
    -- #{@time} : #{@cookie}
    #{@golden_time}

    CODE
  end

  def evaluate_golden_time
    @golden_time.map! do |(probability, power, duration)|
      @cookie += power * probability
      duration -= 1

      if duration == -1
        nil
      else
        [probability, power, duration]
      end
    end

    @golden_time.reject! { |v| v.nil? }
  end

  def display_golden_cookie
    parsed_effects.dup.each { |v| @golden_time << v.dup }
  end

  def parsed_effects
    @parsed_effects ||= begin
      @effects.map! { |v| [v[0] * @probability, v[1], v[2]] }
      golden = @effects.transpose[0].inject(&:+)
      @effects << [1.0 - golden, 1, 1] if golden < 1
      @effects
    end
  end
end

p CookieBabaa.new(T.to_i, P, effects).start
