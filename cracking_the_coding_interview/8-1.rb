require 'delegate'

class Card < Struct.new(:number, :mark)
  include Comparable

  module MARK
    const_set(:JORKER, :jorker)
    const_set(:CLOVER, :clover)
    const_set(:DIAMOND, :diamond)
    const_set(:HEART, :heart)
    const_set(:SPADE, :spade)
  end

  def initialize(*attributes)
    attributes[0] = nil if attributes[1] == MARK::JORKER
    super(*attributes)
  end

  def value
    number
  end

  def <=>(other)
    value = other.is_a?(self.class) ? other.number : other
    self.number <=> value
  end

  def to_i
    mark == MARK::JORKER ? Float::INFINITY : number
  end
end

class Cards < DelegateClass(Array)
  attr_accessor :card

  const_set(:DEFAULT_RULE, {
    Card::MARK::CLOVER => (1..13),
    Card::MARK::DIAMOND => (1..13),
    Card::MARK::HEART => (1..13),
    Card::MARK::SPADE => (1..13),
    Card::MARK::JORKER => (1..2),
  })

  def initialize(rule = nil, card_klass = nil)
    super([])

    @card = card_klass || Card
    @default_cards = set_deck(rule || DEFAULT_RULE).dup
  end

  def restart
    self.replace(@default_cards.dup.shuffle)
  end

  def draw_card
    pop
  end

  def set_deck(rule = [])
    deck = []

    rule.each do |mark, number_or_range|
      case number_or_range
      when Range
        deck += number_or_range.map { |i| card.new(i, mark) }
      when Numeric
        deck << card.new(number_or_range, mark)
      end
    end

    self.replace(deck.shuffle)
  end
end

class Card::BlackJackCard < Card
  def value
    case self.number
    when 11, 12, 13
      10
    else
      self.number
    end
  end

  def is_ace?
    self.number == 1
  end
end

class BlackJack < Cards
  const_set(
    :BLACK_JACK_RULE,
    {
      Card::MARK::CLOVER => (1..13),
      Card::MARK::DIAMOND => (1..13),
      Card::MARK::HEART => (1..13),
      Card::MARK::SPADE => (1..13),
    }
  )

  def initialize
    super(BLACK_JACK_RULE, Card::BlackJackCard)
  end
end

class BlackJackHund
  attr_accessor :cards

  include Comparable

  def initialize
    restart
  end

  def restart
    @standed = false
    @cards = []
  end

  def draw(card_instance)
    @cards << card_instance.draw_card unless @standed
  end
  alias :hit :draw

  def score
    @cards.inject(0) do |sum, card|
      sum += if card.is_ace?
               score > 11 ? 1 : 11
             else
               card.value
             end
      sum
    end
  end

  def busted?
    score > 21
  end

  def <=>(other)
    my_score = self.score
    other_score = other.score

    my_score = 0 if my_score > 21
    other_score = 0 if other_score > 21

    my_score.<=> other_score
  end

  # こいつが責任を持つべきか？
  def duel(other)
    result = self.<=>(other)
    if result == -1
      'lose'
    elsif result == 0
      'draw'
    else
      'win'
    end
  end

  private

  def stand
    @standed = true
  end
end

black_jack_cards = BlackJack.new

me = BlackJackHund.new
me.draw(black_jack_cards)
me.draw(black_jack_cards)
me.draw(black_jack_cards) unless me.busted?

opponent = BlackJackHund.new
opponent.draw(black_jack_cards)
opponent.draw(black_jack_cards)
opponent.draw(black_jack_cards) unless opponent.busted?

p me.score, opponent.score
p me.duel(opponent)
