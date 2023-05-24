require_relative 'deck'
# Пример использования класса Deck
deck = Deck.new
puts "Количество карт в колоде: #{deck.cards_left}"

card = deck.deal_card
puts "Разданная карта: #{card.rank}#{card.suit}"

puts "Количество карт в колоде: #{deck.cards_left}"

deck.reset
puts "Количество карт после сброса: #{deck.cards_left}"
