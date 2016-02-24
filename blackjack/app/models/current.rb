class Current
  attr_accessor :id, :player, :dealer, :deck, :wins

  def initialize (player, dealer, deck)
    self.player = player
    self.dealer = dealer
    self.deck = deck
  end

  def id
    self.id = 1
  end

  def wins

  end

end
