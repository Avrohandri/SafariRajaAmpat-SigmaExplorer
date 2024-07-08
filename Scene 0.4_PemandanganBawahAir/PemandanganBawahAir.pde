int[] fishDirections = {-1, -1, -1, -1, -1};
int[] starfishDirections = {-1, -1};
int[] jellyfishDirections = {1, -1};
float[] fishX = {300, 800, 1300, 600, 1100};
float[] fishY = {600, 400, 800, 900, 200};
float[] starfishX = {400, 1400};
float[] starfishY = {700, 600};
float[] jellyfishX = {1600, 200};
float[] jellyfishY = {900, 300};

void setup() {
  size(1920, 1080);
  background(0, 0, 128); 
  fullScreen();
}

void draw() {
  background(43, 101, 236); 

  // Draw and move fish
  for (int i = 0; i < fishX.length; i++) {
    if (fishDirections[i] == -1) {
      drawFishLeft(fishX[i], fishY[i], color(255 - 50 * i, 100 + 50 * i, 100 + 50 * i)); // Different colors
    } else {
      drawFishRight(fishX[i], fishY[i], color(255 - 50 * i, 100 + 50 * i, 100 + 50 * i)); // Different colors
    }
    fishX[i] += fishDirections[i] * 2;
    if (fishX[i] < 0 || fishX[i] > width) {
      fishDirections[i] *= -1;
    }
  }

  // 
  for (int i = 0; i < starfishX.length; i++) {
    drawStarfish(starfishX[i], starfishY[i], color(255, 165 - 60 * i, 0 + 120 * i)); // Different colors
    starfishX[i] += starfishDirections[i];
    if (starfishX[i] < 0 || starfishX[i] > width) {
      starfishDirections[i] *= -1;
    }
  }

  // Draw and move jellyfish
  for (int i = 0; i < jellyfishX.length; i++) {
    drawJellyfish(jellyfishX[i], jellyfishY[i], color(150 - 150 * i, 0, 255 - 105 * i)); // Different colors
    jellyfishY[i] += jellyfishDirections[i];
    if (jellyfishY[i] > height || jellyfishY[i] < 0) {
      jellyfishDirections[i] *= -1;
    }
  }

  // Draw rocks and seaweed
  drawRock(100, height - 10);
  drawRock(width - 400, height - 10);
  drawSeaweed(80, height - 20);
  drawSeaweed(120, height - 20);
  drawSeaweed(160, height - 20);
  drawSeaweed(width - 420, height - 20);
  drawSeaweed(width - 380, height - 20);
  drawSeaweed(width - 340, height - 20);
}

void drawFishLeft(float x, float y, color c) {
  fill(c);
  noStroke();
  
  // Body
  beginShape();
  vertex(x, y);
  bezierVertex(x + 75, y - 45, x + 150, y - 45, x + 225, y);
  bezierVertex(x + 150, y + 45, x + 75, y + 45, x, y);
  endShape(CLOSE);
  
  // Tail
  beginShape();
  vertex(x + 225, y);
  vertex(x + 270, y - 30);
  vertex(x + 270, y + 30);
  endShape(CLOSE);
  
  // Dorsal fin
  beginShape();
  vertex(x + 75, y - 22);
  vertex(x + 105, y - 67);
  vertex(x + 135, y - 22);
  endShape(CLOSE);
  
  // Pectoral fin
  beginShape();
  vertex(x + 75, y + 22);
  vertex(x + 105, y + 52);
  vertex(x + 135, y + 22);
  endShape(CLOSE);
  
  // Eye
  fill(0);
  ellipse(x + 45, y - 15, 15, 15); // Eye
}

void drawFishRight(float x, float y, color c) {
  fill(c);
  noStroke();
  
  // Body
  beginShape();
  vertex(x, y);
  bezierVertex(x - 75, y - 45, x - 150, y - 45, x - 225, y);
  bezierVertex(x - 150, y + 45, x - 75, y + 45, x, y);
  endShape(CLOSE);
  
  // Tail
  beginShape();
  vertex(x - 225, y);
  vertex(x - 270, y - 30);
  vertex(x - 270, y + 30);
  endShape(CLOSE);
  
  // Dorsal fin
  beginShape();
  vertex(x - 75, y - 22);
  vertex(x - 105, y - 67);
  vertex(x - 135, y - 22);
  endShape(CLOSE);
  
  // Pectoral fin
  beginShape();
  vertex(x - 75, y + 22);
  vertex(x - 105, y + 52);
  vertex(x - 135, y + 22);
  endShape(CLOSE);
  
  // Eye
  fill(0);
  ellipse(x - 45, y - 15, 15, 15); // Eye
}

void drawStarfish(float x, float y, color c) {
  fill(c);
  noStroke();
  
  beginShape();
  vertex(x, y - 30);
  vertex(x + 10, y - 10);
  vertex(x + 30, y - 10);
  vertex(x + 15, y + 5);
  vertex(x + 20, y + 25);
  vertex(x, y + 15);
  vertex(x - 20, y + 25);
  vertex(x - 15, y + 5);
  vertex(x - 30, y - 10);
  vertex(x - 10, y - 10);
  endShape(CLOSE);
}

void drawJellyfish(float x, float y, color c) {
  fill(c);
  noStroke();
  
  // Body
  ellipse(x, y, 100, 100);
  
  // Tentacles
  for (int i = -2; i <= 2; i++) {
    float offsetX = i * 20;
    float offsetY = 50 + abs(i) * 20;
    bezier(x + offsetX, y + 50, x + offsetX - 10, y + 100, x + offsetX + 10, y + 150, x + offsetX, y + 200);
  }
}

void drawRock(float x, float y) {
  fill(128, 128, 128); // Gray color for the rock
  noStroke();

  beginShape();
  vertex(x, y);
  vertex(x + 50, y - 50);
  vertex(x + 100, y - 25);
  vertex(x + 150, y - 60);
  vertex(x + 200, y - 15);
  vertex(x + 250, y - 40);
  vertex(x + 300, y);
  endShape(CLOSE);
}

void drawSeaweed(float x, float y) {
  fill(34, 139, 34); // Seaweed green color
  noStroke();
  
  beginShape();
  vertex(x, y);
  bezierVertex(x - 20, y - 80, x + 20, y - 160, x, y - 240);
  bezierVertex(x + 20, y - 160, x - 20, y - 80, x, y);
  endShape(CLOSE);
}
