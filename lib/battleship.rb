class BattleshipGame
  attr_reader :player_one, :player_two

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
  end

  def game_over?
    @player_one.board.lost?
    @player_two.board.lost?
  end

  def setup
    @player_one.get_ships
    @player_two.get_ships
  end

  def play_turn(attacker, defender)
    pos = attacker.get_play
    raise "Out of bounds." unless defender.board.in_range?(pos)

    defender.ships.each do |ship|
      if ship.hit?(pos)
        ship.hit(pos)

        attacker.enemy_board.mark(pos, :x)

        puts "#{defender.name} hit at #{pos}."
        puts "#{ship.type.capitalize} was sunk." if ship.sunk?

        return pos
      end
    end

    puts "#{defender.name} missed."
    attacker.enemy_board.mark(pos, :o)

    pos
  end

  def play_game
    attacker = @player_one
    defender = @player_two

    until game_over?
      attacker.get_status

      pos = play_turn(attacker, defender)

      attacker, defender = defender, attacker
    end

    puts "#{@player_one.name} won." if @player_two.board.lost?
    puts "#{@player_two.name} won." if @player_one.board.lost?
  end


end
