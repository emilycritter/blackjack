require 'csv'
class PlayController < ApplicationController
  def index
    @current_cards = get_hand(2)
    # puts "I am current_cards.inspect: #{@current_cards.inspect}"

    if @current_cards.nil?
      render text: "Error.", status: 404
      @deck = []
      @dealer = []
      @player = []
    else
      @deck = @current_cards.pop
      @dealer = @current_cards.pop
      @player = @current_cards.pop
    end

    # puts "I am player.inspect: #{@player.inspect}"
    # puts "I am dealer.inspect: #{@dealer.inspect}"
    # puts "I am deck.inspect: #{@deck.inspect}"

    @current_cards = []
    @current_cards << @player
    @current_cards << @dealer
    @current_cards << @deck
    # puts "Puts me: #{current_cards}"
    @current_cards

    # call_hit(@current_cards)

    @player_value = @player.map {|card| card.value}.reduce(:+)
    @dealer_value = @dealer.map {|card| card.value}.reduce(:+)


    if @dealer_value == 21
      @winner = "DEALER WINS"
    elsif @player_value == 21
      @winner = "PLAYER WINS"
    elsif @player_value > 21
      @winner = "PLAYER BUSTS, DEALER WINS"
    elsif @dealer_value > 21
      @winner = "DEALER BUSTS, PLAYER WINS"
    else
      @winner = nil
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

  def get_hand(hit_count)
    if params[:deck_count].present?
      deck = create_deck(params[:deck_count].to_i)
    else
      deck = create_deck(1)
    end

    player = []
    hit_count.times do |card|
      card = deck.sample
      deck.delete(card)
      player << card
    end

    dealer = []
    2.times do |card|
      card = deck.sample
      deck.delete(card)
      dealer << card
    end

    current_cards = []
    current_cards << player
    current_cards << dealer
    current_cards << deck
    # puts "Puts me: #{current_cards}"
    current_cards
  end

  def call_hit(current_cards)
    if current_cards.nil?
      render text: "Error.", status: 404
      deck = []
      dealer = []
      player = []
    else
      deck = current_cards.pop
      dealer = current_cards.pop
      player = current_cards.pop
    end

    card = deck.sample
    deck.delete(card)
    player << card

    dealer_value = dealer.map {|card| card.value}.reduce(:+)
    if dealer_value < 16
      card = deck.sample
      deck.delete(card)
      dealer << card
      dealer_value = dealer.map {|card| card.value}.reduce(:+)
    end

    current_cards = []
    current_cards << player
    current_cards << dealer
    current_cards << deck
    # puts "Puts me: #{current_cards}"
    current_cards
  end

end
