class RectPacker {

  // 2D array to remember which cells have been filled
  boolean cells[][];
  ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();

  // Essentially, the minimum width and height in pixels for a given rectangle
  // The space will be filled most evenly if this number is a factor of both the width and height
  int cellSize;

  // Dimensions of the space to fill
  int sizeX, sizeY;
  int totalCellsX, totalCellsY;

  // Higher numbers here limit the maximum size of all rectangles
  int maxSizeFactor;
  int maxCellWidth;

  // Used for iteration as the cells array is populated.
  int x = 0;
  int y = 0;

  RectPacker(int _sizeX, int _sizeY, int _cellSize, int _maxSizeFactor) {
    sizeX = _sizeX;
    sizeY = _sizeY;
    cellSize = _cellSize;
    maxSizeFactor = _maxSizeFactor;

    totalCellsX = int(sizeX / cellSize);
    totalCellsY = int(sizeY / cellSize);

    maxCellWidth = totalCellsX / maxSizeFactor;

    // Initialize the cells array.
    cells = new boolean[totalCellsX][totalCellsY];
  }

  void generate() {
    while (x < totalCellsX && y < totalCellsY) {
      if (cells[x][y] == false) {
        println("Saving rect at " + x + "," + y);
        // If the cell isn't full, start drawing a rectangle here.
        int maxSize = 0;
        int checkX = x;

        // Determine the maximum width (in cells) of the rectangle (it shouldn't overlap with any taken cells)
        while (checkX < totalCellsX && cells[checkX][y] == false) {
          maxSize++;
          checkX++;
        }
        // If the calculated max is greater than the predetermined maximum, set it to the maximum
        if (maxSize > maxCellWidth) maxSize = maxCellWidth;
        // Generate random dimensions (in cells) for the rectangle
        int randW = int(random(maxSize) + 1);
        int randH = int(random(maxSize) + 1);
        // Helps reduce number of small squares at right edge of grid
        if (maxSize < 8 && random(maxCellWidth) > 1) randW = maxSize;

        // If the rectangle's height exceeds the bottom boundry of the canvas, set it to the maximum possible
        if (y + randH > totalCellsY) {
          randH = randH - ((y + randH) - totalCellsY);
        }
        // Determine the height in pixels by multiplying the cellSize by the random number of cells
        int rectWidth = randW * cellSize;
        int rectHeight = randH * cellSize;

        // Add the rectangle to the array
        rectangles.add(new Rectangle(x * cellSize, y * cellSize, rectWidth, rectHeight));

        // Fill all cells used by the randomly generated rectangle
        for (int cellsX = x; cellsX < x + randW; cellsX++) {
          for (int cellsY = y; cellsY < y + randH; cellsY++) {          
            if (cellsY >= totalCellsY) cellsY = totalCellsY-1;
            cells[cellsX][cellsY] = true;
          }
        }
        // Increment the x position by the randomly generated width to skip occupied cells
        x+=randW;
      } else {
        // This cell is full, move on to the next
        x++;
      }
      checkIncrementer();
    }
    
    println("Done generating.");
  }
  void checkIncrementer() {
    if (x >= totalCellsX && y < totalCellsY-1) {
      // If at then end of a row, reset to position 0, and move down to the next row
      x = 0;
      y++;
    }
  }
}