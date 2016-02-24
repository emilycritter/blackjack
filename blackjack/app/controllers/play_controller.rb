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

    @current_cards = Current.new(@player, @dealer, @deck)
    @current_cards.id

  end

  def hit
    update_current = []
    ObjectSpace.each_object Current do |item|
      update_current << item
    end

    @current_cards = update_current.find{|current| current.id == params[:id].to_i }

    if @current_cards.nil?
      render text: "Error.", status: 404
      @deck = []
      @dealer = []
      @player = []
    else
      @deck = @current_cards.deck
      @dealer = @current_cards.dealer
      @player = @current_cards.player
    end

    card = @deck.sample
    @deck.delete(card)
    @player << card
    puts @player

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
    render :index
  end

  def stay
    update_current = []
    ObjectSpace.each_object Current do |item|
      update_current << item
    end

    @current_cards = update_current.find{|current| current.id == params[:id].to_i }

    if @current_cards.nil?
      render text: "Error.", status: 404
      @deck = []
      @dealer = []
      @player = []
    else
      @deck = @current_cards.deck
      @dealer = @current_cards.dealer
      @player = @current_cards.player
    end

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
    elsif @player_value > @dealer_value
      @winner = "PLAYER WINS"
    elsif @player_value < @dealer_value
      @winner = "DEALER WINS"
    elsif @player_value == @dealer_value
      @winner = "TIE ==> DEALER WINS"
    else
      @winner = nil
    end
    render :index
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
