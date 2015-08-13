class HumanPlayer
  attr_reader :name, :board, :enemy_board, :ships

  RESULTS = { :x => "HIT", :o => "MISSED" }

  def initialize(name, board = Board.new)
    @name = name
    @board = board
    @enemy_board = Board.new
  end

  def get_ships
    @ships = []
    Ship::SHIPS.each do |type, _|
      ship = Ship.new(type, @board)
      @ships << ship
      print "Select location: "
      pos = gets.chomp
      x, y = pos.scan(/\d/)
      pos = [x.to_i, y.to_i]
      print "V or H? "
      orientation = gets.chomp.upcase.to_sym
      orientation == :V ? ship.place_vertical(pos) :
                          ship.place_horizontal(pos)
      @board.display
    end
  end

  def get_play
    print "Attack: "
    pos = gets.chomp
    x, y = pos.scan(/\d/)
    [x.to_i, y.to_i]
  end

  def get_status
    enemy_board.display
    puts "------------------------------"
    board.display
  end

end

class ComputerPlayer < HumanPlayer

  def get_play
    [rand(@board.grid.length), rand(@board.grid[0].length)]
  end

  def get_ships
    @ships = []
    Ship::SHIPS.each do |type, _|
      ship = Ship.new(type, @board)
      @ships << ship
      pos = [rand(@board.grid.length), rand(@board.grid[0].length)]
      orientation = rand(2)
      orientation == 1 ? ship.place_vertical(pos) :
                         ship.place_horizontal(pos)
    end
  end


  def get_status

  end

end
