class Board
  attr_reader :grid

  def initialize(grid = Board.default_grid)
    @grid = grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, sym)
    row, col = pos
    @grid[row][col] = sym
  end

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def count
    count = 0
    @grid.each { |row| row.each { |space| count += 1 if space == :s } }
    count
  end

  def empty?(pos = nil)
    if pos == nil
      count == 0
    else
      self.[](pos).nil?
    end
  end

  def full?
    count == @grid.length * @grid[0].length
  end

  def in_range?(pos)
    row, col = pos
    row < @grid.length && col < @grid[0].length
  end

  def place_random_ship
    pos = [rand(@grid.length), rand(@grid[0].length)]
    empty?(pos) ? mark(pos, :s) : place_random_ship
  end

  def mark(pos, sym)
    self.[]=(pos, sym)
  end

  def lost?
    count == 0
  end

  def populate_grid
    5.times { place_random_ship }
  end

  def display
    @grid.each do |row|
      display_row = ""
      row.each do |space|
        display_space = space.nil? ? "[ ]" : "[#{space}]"
        display_row << display_space
      end
      puts display_row
    end
  end

end
