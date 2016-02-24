require 'csv'

class Card
  attr_accessor :suit, :value

  def initialize
    self.suit = suit
    self.value = value
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

  def fetch_cards
    cards = []
    CSV.foreach"cards.csv", headers: true) do |row|
      card_hash = row.to_hash

        card = Card.new
        card.id = card_hash["id"].to_i
        card.value = card_hash["value"].to_i
        card.suit = card_hash["suit"]
        card.img_file = card_hash["img_file"]


        products << product
    end


end
