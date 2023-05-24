require_relative 'player'

class Dealer < Player
  def initialize(name = 'Dealer', bank = 100)
    super(name, bank)
  end

  def hide_cards
    @hand.each { |card| card.hide }
  end

  def reveal_cards
    @hand.each { |card| card.reveal }
  end

  def play(deck)
    while total_points < 17
      take_card(deck.deal_card)
    end
  end
end
