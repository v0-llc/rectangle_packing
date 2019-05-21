// Simple demo of how the output of the RectPacker class can be visualized

// Total cells for x and y axis
int sizeX = 500;
int sizeY = 500;

// Cells X, Cells Y, Cell Size, Max Size Limiter (higher means smaller)
RectPacker generator = new RectPacker(sizeX, sizeY, 10, 5);

// Iterator for drawing the rectangles over time.
int currentI;

void setup() {
  size(800, 800, P3D);
  smooth(8);
  
  // Generate all of the rectangles
  generator.generate();
}

void draw() {
  background(0);
  
  // Add lights
  lights();
  directionalLight(51, 102, 126, 0.5, 0.5, 0);
  
  ortho();
  // Center
  translate(width/2, height/2);
  rotateX(HALF_PI * 0.5);
  rotateZ(HALF_PI * 0.5);  

  stroke(0, 0, 0, 20);

  // Draw all of the generated rectangles as 3D boxes
  for (int i = 0; i < currentI; i++) {
    Rectangle currentRect = generator.rectangles.get(i);
    pushMatrix();
    translate(
      currentRect.x - sizeX / 2 + currentRect.w / 2, // Boxes are drawn from center so some adjustment is required.
      currentRect.y - sizeY / 2 + currentRect.h / 2,
      currentRect.h / 2 + (sin(millis()*0.005 + i)*6)); // Some movement just for fun.
      
    box(currentRect.w, currentRect.h, currentRect.h);
    popMatrix();
  }
  
  // Increment the number of boxes drawn so they're drawn over time.
  if(currentI < generator.rectangles.size()){
    currentI++;
  }
}