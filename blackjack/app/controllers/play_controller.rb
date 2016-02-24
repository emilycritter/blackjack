require 'csv'
class PlayController < ApplicationController
  def index
    if params[:deck_count].present?
      @deck = create_deck(params[:deck_count].to_i)
    else
      @deck = create_deck(1)
    end

    @player = []
    2.times do |card|
      card = @deck.sample
      @deck.delete(card)
      @player << card
    end
    @player_value = @player.map {|card| card.value}.reduce(:+)

    @dealer = []
    2.times do |card|
      card = @deck.sample
      @deck.delete(card)
      @dealer << card
    end
    @dealer_value = @dealer.map {|card| card.value}.reduce(:+)

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
