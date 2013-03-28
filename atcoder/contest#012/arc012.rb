class Week
  WEEK = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
  HOLIDAY = %w[Sunday Saturday]

  class << self
    def week
      @week ||= WEEK.dup.delete_if { |day| HOLIDAY.include? day }
    end

    def HOLIDAY=(days)
      const_set(:HOLIDAY, days)
      @week = nil
    end

    def weekend_at(day)
      HOLIDAY.include?(day) ? 0 : 5 - week.index(day)
    end
  end
end

input = STDIN.gets.strip
p Week.weekend_at(input)
