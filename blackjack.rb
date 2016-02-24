require_relative 'deck'

class Blackjack < Deck

  def initialize (deck_count)
    @deck = Deck.new(deck_count)
  end


end

game = Blackjack.new(1)
puts game.inspect
