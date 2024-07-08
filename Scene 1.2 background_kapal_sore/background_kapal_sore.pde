float cloud1X, cloud2X, cloud3X;
float cloudSpeed = 1.5; // Adjust speed of clouds
float jumpSpeed = 5; // Speed of jump
boolean jumpingMale = true;
boolean jumpingFemale = true;
float maleY, femaleY;
float maleJumpY, femaleJumpY;
boolean goingUpMale = true;
boolean goingUpFemale = true;

void setup() {
  size(1920, 1080);
  // Initialize cloud starting positions
  fullScreen();
  cloud1X = -200;
  cloud2X = -600;
  cloud3X = -1000;
  
  // Initial character positions
  maleY = height - 150;
  femaleY = height - 150;
  
  maleJumpY = 0;
  femaleJumpY = 0;
}

void draw() {
  // Redraw background to clear previous frames
  background(255, 140, 0); // Dark orange background
  
  // Redraw static elements
  drawMountains();
  drawSea();
  drawBeach();
  drawRocks();
  drawTrees();
  
  // Draw clouds
  drawCloud(cloud1X, height/4);
  drawCloud(cloud2X, height/3);
  drawCloud(cloud3X, height/5);
  
  // Update cloud positions for animation
  cloud1X += cloudSpeed;
  cloud2X += cloudSpeed;
  cloud3X += cloudSpeed;
  
  // Check if clouds have moved off-screen and reset their position
  if (cloud1X > width + 200) {
    cloud1X = -200;
  }
  if (cloud2X > width + 200) {
    cloud2X = -200;
  }
  if (cloud3X > width + 200) {
    cloud3X = -200;
  }
  
  // Draw ship
  drawShip(width/2 - 250, height/2 + 260, 1.0); // Adjust position and scale as needed
  
  // Draw sun
  drawSun();
  
  // Update jumping positions
  if (goingUpMale) {
    maleJumpY -= jumpSpeed;
    if (maleY + maleJumpY <= height - 300) {
      goingUpMale = false;
    }
  } else {
    maleJumpY += jumpSpeed;
    if (maleY + maleJumpY >= height - 150) {
      goingUpMale = true;
    }
  }
  
  if (goingUpFemale) {
    femaleJumpY -= jumpSpeed;
    if (femaleY + femaleJumpY <= height - 300) {
      goingUpFemale = false;
    }
  } else {
    femaleJumpY += jumpSpeed;
    if (femaleY + femaleJumpY >= height - 150) {
      goingUpFemale = true;
    }
  }
  
  // Draw male character
  MaleCharacter male = new MaleCharacter(width/3, maleY + maleJumpY);
  male.drawCharacter();
  
  // Draw female character
  FemaleCharacter female = new FemaleCharacter(2*width/3, femaleY + femaleJumpY);
  female.drawCharacter();
}

void drawSun() {
  fill(255, 69, 0); // Orange color for sun
  noStroke();
  ellipse(width - 1700, 150, 100, 100); // Sun in the top right corner
}

void drawCloud(float x, float y) {
  noStroke();
  fill(255, 165, 0); 
  
  // Ellipses for cloud shape
  ellipse(x, y, 100, 80);
  ellipse(x + 30, y - 20, 100, 80);
  ellipse(x + 60, y, 100, 80);
  ellipse(x + 30, y + 20, 100, 80);
}

void drawMountains() {
  fill(119, 136, 153); // Dark gray for mountain color
  noStroke();
  
  // Draw first mountain
  beginShape();
  vertex(0, height/2);        // Bottom left corner
  vertex(300, height/2 - 300); // Top peak
  vertex(600, height/2);      // Bottom right corner
  endShape(CLOSE);
  
  // Draw second mountain
  beginShape();
  vertex(200, height/2);       // Bottom left corner
  vertex(500, height/2 - 250); // Top peak
  vertex(800, height/2);       // Bottom right corner
  endShape(CLOSE);
}

void drawSea() {
  fill(30, 144, 255); // Darker sea blue
  noStroke();
  rect(0, height/2, width, height/2);
}

void drawBeach() {
  fill(255, 255, 224); // Light yellow for beach sand
  noStroke();
  rect(0, height/2 + 175, width, height/2 - 50); // Adjust the beach area to be above the sea
}

void drawRocks() {
  fill(120, 120, 120); // Gray rocks
  noStroke();
  
  // Draw multiple rocks on the left
  ellipse(200, height - 200, 160, 100);
  ellipse(300, height - 240, 200, 120);
  ellipse(400, height - 180, 180, 110);
  ellipse(260, height - 160, 120, 80);
}

void drawTrees() {
  fill(139, 69, 19); // Brown for tree trunks
  noStroke();

  // First tree trunk
  rect(width - 300, height/2 + 50, 40, 270);
  
  // Second tree trunk
  rect(width - 200, height/2 + 30, 40, 240);

  fill(34, 139, 34); // Green for leaves
  // First tree leaves
  ellipse(width - 280, height/2 + 30, 160, 160);
  ellipse(width - 320, height/2 - 10, 160, 160);
  ellipse(width - 240, height/2 - 10, 160, 160);
  
  // Second tree leaves
  ellipse(width - 180, height/2 + 10, 160, 160);
  ellipse(width - 220, height/2 - 30, 160, 160);
  ellipse(width - 140, height/2 - 30, 160, 160);
}

void drawShip(float x, float y, float scale) {
  // Adjusting dimensions based on scale
  float shipWidth = 200 * scale;
  float shipHeight = 100 * scale;
  
  fill(139, 69, 19); // Brown color for ship
  noStroke();
  
  // Ship body
  beginShape();
  vertex(x, y); // Bottom-left corner
  vertex(x + shipWidth, y); // Bottom-right corner
  vertex(x + shipWidth + 50 * scale, y - shipHeight); // Top-right corner
  vertex(x - 50 * scale, y - shipHeight); // Top-left corner
  endShape(CLOSE);
  
  // Cabin
  fill(160, 82, 45); // Dark brown for cabin
  rect(x + 30 * scale, y - shipHeight + 20 * scale, 60 * scale, 40 * scale);
  
  fill(160, 82, 45); // Dark brown for cabin
  rect(x + 100 * scale, y - shipHeight + 20 * scale, 60 * scale, 40 * scale);
  
  // Mast
  stroke(0); // Black color for mast
  strokeWeight(2); // Thin stroke
  float mastHeight = 120 * scale; // Height of the mast
  line(x + shipWidth / 2, y - shipHeight, x + shipWidth / 2, y - shipHeight - mastHeight); // Making mast taller
  
  // Sail
  fill(255); // White color for sail
  noStroke();
  float sailHeight = 80 * scale; // Height of the sail
  float sailWidth = 60 * scale; // Width of the sail
  triangle(x + shipWidth / 2, y - shipHeight - mastHeight, // Bottom vertex of the triangle, lower position
           x + shipWidth / 2 + sailWidth, y - shipHeight - mastHeight + sailHeight, // Right vertex of the triangle, right side
           x + shipWidth / 2, y - shipHeight - mastHeight + sailHeight); // Left vertex of the triangle, left side
}

class MaleCharacter {
  float x, y;
  
  MaleCharacter(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void drawCharacter() {
    // Skin color
    fill(255, 204, 153);
    noStroke();
    
    // Head
    ellipse(x, y - 150, 80, 100);
    
    // Blue shirt
    fill(0, 0, 255);
    rect(x - 40, y - 100, 80, 100);
    
    // Brown pants
    fill(139, 69, 19);
    rect(x - 40, y, 35, 100);
    rect(x + 5, y, 35, 100);
    
    // Black shoes
    fill(0);
    rect(x - 40, y + 100, 35, 10);
    rect(x + 5, y + 100, 35, 10);
    
    // Arms
    fill(255, 204, 153);
    rect(x - 60, y - 100, 20, 100);
    rect(x + 40, y - 100, 20, 100);
    
    // Face features (eyes and smile)
    fill(255);
    ellipse(x - 15, y - 165, 20, 20); // Left eye
    ellipse(x + 15, y - 165, 20, 20); // Right eye
    fill(0);
    ellipse(x - 15, y - 165, 10, 10); // Left pupil
    ellipse(x + 15, y - 165, 10, 10); // Right pupil
    
    // Smile
    noFill();
    stroke(0);
    strokeWeight(2);
    arc(x, y - 150, 40, 20, 0, PI);
  }
}

class FemaleCharacter {
  float x, y;
  
  FemaleCharacter(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void drawCharacter() {
    // Hair
    fill(0); // Black hair color
    arc(x, y - 170, 90, 100, PI, TWO_PI); // Hair on top of the head
    rect(x - 45, y - 170, 90, 50); // Hair falling on the sides
    rect(x - 40, y - 150, 80, 30); // Hair covering the forehead
    
    // Skin color
    fill(255, 204, 153);
    noStroke();
    
    // Head
    ellipse(x, y - 150, 80, 100);
    
    // Red dress
    fill(255, 0, 0);
    beginShape();
    vertex(x - 40, y - 100);
    vertex(x + 40, y - 100);
    vertex(x + 60, y + 100);
    vertex(x - 60, y + 100);
    endShape(CLOSE);
    
    // Shoes
    fill(0);
    rect(x - 40, y + 100, 35, 10);
    rect(x + 5, y + 100, 35, 10);
    
    // Arms
    fill(255, 204, 153);
    rect(x - 60, y - 100, 20, 100);
    rect(x + 40, y - 100, 20, 100);
    
    // Face features (eyes and smile)
    fill(255);
    ellipse(x - 15, y - 165, 20, 20); // Left eye
    ellipse(x + 15, y - 165, 20, 20); // Right eye
    fill(0);
    ellipse(x - 15, y - 165, 10, 10); // Left pupil
    ellipse(x + 15, y - 165, 10, 10); // Right pupil
    
    // Smile
    noFill();
    stroke(0);
    strokeWeight(2);
    arc(x, y - 150, 40, 20, 0, PI);
  }
}
