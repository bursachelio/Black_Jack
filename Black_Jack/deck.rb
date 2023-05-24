require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    build_deck
    shuffle_cards
  end

  def build_deck
    suits = ['♠', '♥', '♦', '♣']
    ranks = (2..10).to_a + ['J', 'Q', 'K', 'A']

    suits.each do |suit|
      ranks.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
  end

  def shuffle_cards
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end

  def cards_left
    @cards.length
  end

  def reset
    @cards.clear
    build_deck
    shuffle_cards
  end
end
