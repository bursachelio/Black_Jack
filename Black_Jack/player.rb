require_relative 'deck'

class Player
  attr_reader :name, :bank, :hand
  attr_accessor :choice

  def initialize(name)
    @name = name
    @bank = 100
    @hand = []
  end

  def make_bet
    @bank -= 10
    10
  end

  def take_card(card)
    @hand << card
  end

  def hand_points
    points = 0
    aces_count = 0

    @hand.each do |card|
      if card.rank.is_a?(Integer)
        points += card.rank
      elsif %w[J Q K].include?(card.rank)
        points += 10
      elsif card.rank == 'A'
        points += 11
        aces_count += 1
      end
    end

    aces_count.times do
      points -= 10 if points > 21
    end

    points
  end

  def reset_hand
    @hand.clear
  end

  def add_to_bank(amount)
    @bank += amount
  end

  def hide_cards
    @hand.each { |card| card.hide }
  end

  def reveal_cards
    @hand.each { |card| card.reveal }
  end
  
  def to_s
    @name
  end
end
