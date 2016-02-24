require 'csv'

class Card
  attr_accessor :id, :suit, :value, :img_file

  def initialize
    self.suit = suit
    self.value = value
  end

end

class PlayController < Card
  def index
    # if params[:deck_count].present?
    #   deck = create_deck(params[:deck_count].to_i)
    # else
    #   deck = create_deck(1)
    # end

    current_deck = create_deck(1)
    puts "The current deck: #{current_deck}"
    puts "The random card: #{current_deck.sample}"

    @player = []
    2.times do
      puts "The current deck: #{current_deck}"
      puts "The random card: #{current_deck.sample}"
      card = current_deck.sample
      current_deck.delete(card)
      @player << card
    end

    @dealer = []
    2.times do
      card = current_deck.sample
      current_deck.delete(card)
      @dealer << card
    end

  end

  def hit
  end

  def winner
  end

  def fetch_cards
    cards = []
    CSV.foreach("cards.csv", headers: true) do |row|
      card_hash = row.to_hash

        card = Card.new
        card.id = card_hash["id"].to_i
        card.value = card_hash["value"].to_i
        card.suit = card_hash["suit"]
        card.img_file = card_hash["img_file"]

        cards << card
    end
    cards
  end

  def create_deck(deck_count)
    deck = fetch_cards * deck_count.to_i
  end

end

play = PlayController.new
play.index
