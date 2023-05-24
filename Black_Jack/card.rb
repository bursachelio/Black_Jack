class Card
  attr_reader :rank, :suit
  attr_accessor :hidden

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def hide
    @hidden = true
  end

  def reveal
    @hidden = false
  end

  def display
    if hidden
      '* *'
    else
      "#{rank}#{suit}"
    end
  end

  def face_card?
    ['J', 'Q', 'K'].include?(@rank)
  end
  
  def ace?
    @rank == "A"
  end

  def value
    return 10 if face_card?
    return 11 if ace?
    @rank.to_i
  end

  def to_s
    "#{@rank}#{@suit}"
  end
end
