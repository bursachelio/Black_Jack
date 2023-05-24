require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class Game
  def initialize
    puts 'Добро пожаловать в игру Black Jack!'
    print 'Введите ваше имя: '
    player_name = gets.chomp
    @player = Player.new(player_name)
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    loop do
      reset_game
      deal_initial_cards
      show_initial_hands

      loop do
        player_turn
        break if player_finished?

        dealer_turn
        break if dealer_finished?
      end

      reveal_all_cards
      show_result
      collect_bets
      break unless play_again?
    end

    puts 'Спасибо за игру! До свидания!'
  end

  private

  def reset_game
    @deck.reset
    @player.reset_hand
    @dealer.reset_hand
  end

  def deal_initial_cards
    2.times do
      @player.take_card(@deck.deal_card)
      @dealer.take_card(@deck.deal_card)
    end
  end

  def show_initial_hands
    puts "\n#{'-' * 20}"
    puts 'Карты игрока:'
    @player.hand.each { |card| puts card.display }
    puts "\nКарты дилера:"
    @dealer.hide_cards
    @dealer.hand.each { puts '* *' }
    puts "#{@player} имеет очков: #{points_for(@player)}"
    puts "#{@dealer} имеет очков: ???"
    puts "#{@player} имеет в банке: $#{@player.bank}"
    puts "#{@dealer} имеет в банке: $#{@dealer.bank}"
    puts "#{@player} делает ставку: $10"
    puts "#{@dealer} делает ставку: $10"
    puts '-' * 20
  end

  def player_turn
    puts "\nХод игрока #{@player}:"
    choice = get_player_choice
    case choice
    when '1'
      puts 'Игрок пропускает ход.'
    when '2'
      card = @deck.deal_card
      @player.take_card(card)
      puts "Игрок получает карту: #{card.display}"
      puts "#{@player} имеет очков: #{points_for(@player)}"
    when '3'
      puts 'Игрок открывает карты.'
    end
  end

  def get_player_choice
    loop do
      puts 'Выберите действие:'
      puts '1. Пропустить ход'
      puts '2. Добавить карту' if @player.hand.size == 2
      puts '3. Открыть карты'
      print 'Ваш выбор: '
      choice = gets.chomp
      return choice if valid_player_choice?(choice)

      puts 'Некорректный выбор. Попробуйте еще раз.'
    end
  end

  def valid_player_choice?(choice)
    %w[1 2 3].include?(choice)
  end

  def player_finished?
    @player.hand.size == 3 || @player.hand_points > 21 || get_player_choice == '3'
  end

  def dealer_turn
    puts "\nХод дилера #{@dealer}:"
    if @dealer.hand_points < 17
      card = @deck.deal_card
      @dealer.take_card(card)
      puts "Дилер получает карту: #{card.display}"
    else
      puts 'Дилер пропускает ход.'
    end
  end

  def dealer_finished?
    @dealer.hand_points >= 17
  end

  def reveal_all_cards
    @dealer.reveal_cards
    puts "\nКарты дилера:"
    @dealer.hand.each { |card| puts card.display }
    puts "#{@dealer} имеет очков: #{points_for(@dealer)}"
  end

  def show_result
    player_points = points_for(@player)
    dealer_points = points_for(@dealer)
    puts "\nРезультат игры:"
    if player_points > 21
      puts "#{@player} проиграл. У него перебор!"
      puts "#{@dealer} выиграл."
    elsif dealer_points > 21
      puts "#{@dealer} проиграл. У него перебор!"
      puts "#{@player} выиграл."
    elsif player_points > dealer_points
      puts "#{@player} выиграл."
    elsif player_points < dealer_points
      puts "#{@dealer} выиграл."
    else
      puts 'Ничья!'
    end
  end

  def collect_bets
    if points_for(@player) > 21
      @dealer.add_to_bank(20)
    elsif points_for(@dealer) > 21
      @player.add_to_bank(20)
    elsif points_for(@player) > points_for(@dealer)
      @player.add_to_bank(20)
    elsif points_for(@player) < points_for(@dealer)
      @dealer.add_to_bank(20)
    end
  end

  def play_again?
    loop do
      print 'Хотите сыграть еще раз? (да/нет): '
      answer = gets.chomp.downcase
      return true if answer == 'да'
      return false if answer == 'нет'

      puts 'Некорректный ответ. Попробуйте еще раз.'
    end
  end

  def points_for(player)
    player.hand_points
  end
end

# Запуск игры
game = Game.new
game.start
