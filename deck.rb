require 'csv'

class Deck < Card
  attr_accessor :cards

  def initialize (deck_count)
    @cards = []
    @deck_count = deck_count
  end

  def create_deck
    @deck_count.times do
      suits = [:hearts, :diamonds, :spades, :clubs]
      suits.each do |suit|
        (2..10).each {|value| @cards << Card.new(suit, value)}
        @cards << Card.new(suit, "J")
        @cards << Card.new(suit, "Q")
        @cards << Card.new(suit, "K")
        @cards << Card.new(suit, "A")
      end
    end
  end

end
