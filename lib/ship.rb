class Ship
  attr_reader :type, :length, :location

  SHIPS = { :carrier => 5,
            :battleship => 4,
            :submarine => 3,
            :destroyer => 3,
            :patrol => 2 }

  def initialize(type, board)
    @type = type
    @length = SHIPS[type]
    @board = board
    @location = {}
  end


  def place_horizontal(pos)
    row, col = pos
    (0 ... @length).each { |i| @location[[row, col + i]] = :s }

    place_on_board
  end

  def place_vertical(pos)
    row, col = pos
    (0 ... @length).each { |i| @location[[row + i, col]] = :s }

    place_on_board
  end

  def place_on_board
    if @location.keys.any? { |pos| !@board.in_range?(pos) }
       raise "Invalid location."
    end

    @location.each { |pos, value| @board.mark(pos, value) }
  end

  def hit?(pos)
    @location.has_key?(pos)
  end

  def hit(pos)
    @location[pos] = :x if hit?(pos)

    place_on_board
  end

  def sunk?
    !@location.has_value?(:s)
  end
end
