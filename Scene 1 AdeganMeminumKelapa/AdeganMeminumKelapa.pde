float[] logAngles = new float[5];
PVector[] logPositions = new PVector[5];

void setup() {
  size(1920, 1080);
  background(255, 140, 0); // Warna langit jingga untuk sore hari
  fullScreen(); 

  // Inisialisasi posisi dan sudut kayu
  for (int i = 0; i < 5; i++) {
    logAngles[i] = random(-PI / 6, PI / 6);
    logPositions[i] = new PVector(width / 2, height - 200);
  }
}

void draw() {
  background(255, 140, 0); // Warna langit jingga untuk sore hari
  //drawSunWithRays();
  drawMountains();
  drawIsland();
  drawPalmTrees();
  drawClouds();
  drawCampfire();
  drawSun();

  // Draw characters on the sides of the campfire
  MaleCharacter male = new MaleCharacter(width / 2 - 150, height - 200, 0.6); // Skala diperkecil menjadi 0.6
  male.drawCharacter();

  FemaleCharacter female = new FemaleCharacter(width / 2 + 150, height - 200, 0.6); // Skala diperkecil menjadi 0.6
  female.drawCharacter();
}

//void drawSunWithRays() {
//  float sunSize = 80;  // Ukuran matahari
//  float sunX = width - 200;  // Posisi matahari di pojok kanan atas
//  float sunY = 150;
//  int rayCount = 12;  // Jumlah sinar matahari
//  float rayLength = 60;  // Panjang sinar matahari

//  // Warna oranye untuk matahari
//  fill(255, 165, 0);  
//  noStroke();
//  ellipse(sunX, sunY, sunSize, sunSize);

//  // Menggambar sinar matahari
//  stroke(255, 165, 0);
//  strokeWeight(3);
//  for (int i = 0; i < rayCount; i++) {
//    float angle = TWO_PI / rayCount * i;
//    float x1 = sunX + cos(angle) * (sunSize / 2);
//    float y1 = sunY + sin(angle) * (sunSize / 2);
//    float x2 = sunX + cos(angle) * (sunSize / 2 + rayLength);
//    float y2 = sunY + sin(angle) * (sunSize / 2 + rayLength);
//    line(x1, y1, x2, y2);
//  }
//}

void drawMountains() {
  fill(105, 105, 105); // Warna pegunungan
  noStroke();
  
  beginShape();
  vertex(0, height / 2);
  vertex(200, height / 3);
  vertex(400, height / 2);
  vertex(600, height / 3);
  vertex(800, height / 2);
  vertex(1000, height / 3);
  vertex(1200, height / 2);
  vertex(1400, height / 3);
  vertex(width, height / 2);
  endShape(CLOSE);
}

void drawIsland() {
  fill(255, 228, 181); // Warna pasir pantai
  noStroke();
  rect(0, height / 2, width, height / 2);

  fill(244, 164, 96); // Warna pantai
  rect(17, height / 2 + 20, 1880, height / 2 - 40);
}

void drawPalmTrees() {
  drawPalmTree(width / 2 - 800, height / 3 + 20, 100);
  drawPalmTree(width / 2 - 600, height / 3 + 50, 100);
  drawPalmTree(width / 2 - 400, height / 3 + 90, 100);
  drawPalmTree(width / 2 - 200, height / 3 + 60, 100);
  drawPalmTree(width / 2, height / 3 + 100, 100);
  drawPalmTree(width / 2 + 200, height / 3 + 60, 100);
  drawPalmTree(width / 2 + 400, height / 3 + 90, 100);
  drawPalmTree(width / 2 + 600, height / 3 + 120, 100);
  drawPalmTree(width / 2 + 800, height / 3 + 70, 100);
}

void drawPalmTree(float x, float y, float leafLength) {
  fill(139, 69, 19); // Warna coklat untuk batang pohon
  noStroke();
  rect(x - 10, y, 20, 200); // Menggambar batang pohon (lebih kurus dan lebih tinggi)

  // Gambar batu di sekitar pohon kelapa
  drawStones(x, y + 150); // Penyesuaian posisi batu di bawah pohon kelapa

  // Gambar daun
  for (int i = 0; i < 12; i++) {
    float angle = PI / 3 + i * PI / 6;
    drawPalmLeaf(x, y, leafLength, angle);
  }

  // Gambar buah kelapa
  drawCoconuts(x, y);
}

void drawStones(float x, float y) {
  fill(105); // Warna batu (abu-abu tua)
  noStroke();

  ellipse(x - 20, y + 50, 70, 50); // Batu pertama
  ellipse(x + 20, y + 50, 60, 40); // Batu kedua
}

void drawPalmLeaf(float x, float y, float length, float angle) {
  fill(34, 139, 34); // Warna daun
  noStroke();

  pushMatrix();
  translate(x, y);
  rotate(angle);

  beginShape();
  vertex(0, 0);
  for (float i = 0; i <= length; i += 10) {
    float width = 10 * sin(PI * i / length);
    vertex(-width, i);
  }
  for (float i = length; i >= 0; i -= 10) {
    float width = 10 * sin(PI * i / length);
    vertex(width, i);
  }
  endShape(CLOSE);

  popMatrix();
}

void drawCoconuts(float x, float y) {
  fill(144, 238, 144); // Warna hijau muda untuk buah kelapa
  noStroke();

  ellipse(x - 10, y + 10, 20, 20); // Buah kelapa pertama
  ellipse(x + 10, y + 10, 20, 20); // Buah kelapa kedua
  ellipse(x, y + 25, 20, 20); // Buah kelapa ketiga
}

void drawClouds() {
  // Menggambar awan
  fill(205, 133, 63); // Warna awan kecoklatan
  noStroke();

  // Awan pertama
  ellipse(300, 100, 200, 80);
  ellipse(400, 100, 150, 60);
  ellipse(500, 100, 180, 70);

  // Awan kedua
  ellipse(800, 150, 180, 70);
  ellipse(900, 150, 120, 50);
  ellipse(1000, 150, 150, 60);

  // Awan ketiga
  ellipse(1300, 100, 160, 60);
  ellipse(1400, 100, 130, 50);
  ellipse(1500, 100, 140, 55);

  // Awan keempat
  ellipse(1700, 150, 190, 75);
  ellipse(1800, 150, 140, 55);
  ellipse(1900, 150, 170, 65);
}

void drawCampfire() {
  // Gambar batu di sekitar api unggun
  drawCampfireStones(width / 2, height - 200);

  // Gambar kayu di bawah api unggun
  drawLogs(width / 2, height - 200);

  // Gambar api unggun
  drawFlames(width / 2, height - 200);

  // Gambar kelapa dengan sedotan di depan api unggun
  drawCoconut(width / 2 - 90, height - 150);
  drawCoconut(width / 2 + 90, height - 150);
}

void drawCampfireStones(float x, float y) {
  fill(105); // Warna batu (abu-abu tua)
  noStroke();
  
  for (int i = 0; i < 8; i++) {
    float angle = TWO_PI / 8 * i;
    float xOffset = cos(angle) * 50;
    float yOffset = sin(angle) * 50;
    ellipse(x + xOffset, y + yOffset, 50, 30);
  }
}

void drawLogs(float x, float y) {
  fill(139, 69, 19); // Warna kayu coklat
  noStroke();

  // Gambar beberapa batang kayu
  for (int i = 0; i < 5; i++) {
    pushMatrix();
    translate(logPositions[i].x, logPositions[i].y);
    rotate(logAngles[i]);
    rect(-60, -10, 120, 20); // Menggambar batang kayu
    popMatrix();
  }
}

void drawFlames(float x, float y) {
  fill(255, 140, 0); // Warna api jingga
  noStroke();

  beginShape();
  vertex(x, y);
  vertex(x - 20, y - 60);
  vertex(x, y - 120);
  vertex(x + 20, y - 60);
  endShape(CLOSE);

  fill(255, 69, 0); // Warna api merah
  beginShape();
  vertex(x, y);
  vertex(x - 10, y - 40);
  vertex(x, y - 80);
  vertex(x + 10, y - 40);
  endShape(CLOSE);
}
void drawSun() {
  fill(255, 69, 0); // Warna matahari jingga
  noStroke();
  ellipse(width - 1800, 150, 100, 100); // Posisi matahari di sebelah atas barat
}

void drawCoconut(float x, float y) {
  fill(139, 69, 19); // Warna kelapa coklat
  noStroke();
  ellipse(x, y, 50, 50); // Kelapa

  // Sedotan
  stroke(255); // Warna putih untuk sedotan
  strokeWeight(3);
  line(x, y - 25, x, y - 50); // Sedotan
}

class MaleCharacter {
  float x, y, scale;
  
  MaleCharacter(float x, float y, float scale) {
    this.x = x;
    this.y = y;
    this.scale = scale;
  }
  
  void drawCharacter() {
    // Scale factor for resizing the character
    float s = scale;
    
    // Skin color
    fill(255, 204, 153);
    noStroke();
    
    // Head
    ellipse(x, y - 250 * s, 80 * s, 100 * s);
    
    // Blue shirt
    fill(0, 0, 255);
    rect(x - 40 * s, y - 200 * s, 80 * s, 100 * s);
    
    // Red pants
    fill(255, 0, 0);
    rect(x - 40 * s, y - 100 * s, 35 * s, 100 * s);
    rect(x + 5 * s, y - 100 * s, 35 * s, 100 * s);
    
    // Shoes
    fill(0);
    rect(x - 40 * s, y, 35 * s, 10 * s);
    rect(x + 5 * s, y, 35 * s, 10 * s);
    
    // Arms
    fill(255, 204, 153);
    rect(x - 60 * s, y - 200 * s, 20 * s, 100 * s);
    rect(x + 40 * s, y - 200 * s, 20 * s, 100 * s);
    
    // Face features (eyes and smile)
    fill(255);
    ellipse(x - 15 * s, y - 265 * s, 20 * s, 20 * s); // Left eye
    ellipse(x + 15 * s, y - 265 * s, 20 * s, 20 * s); // Right eye
    fill(0);
    ellipse(x - 15 * s, y - 265 * s, 10 * s, 10 * s); // Left pupil
    ellipse(x + 15 * s, y - 265 * s, 10 * s, 10 * s); // Right pupil
    
    // Smile
    noFill();
    stroke(0);
    strokeWeight(2);
    arc(x, y - 250 * s, 40 * s, 20 * s, 0, PI);
  }
}

class FemaleCharacter {
  float x, y, scale;
  
  FemaleCharacter(float x, float y, float scale) {
    this.x = x;
    this.y = y;
    this.scale = scale;
  }
  
  void drawCharacter() {
    // Scale factor for resizing the character
    float s = scale;
    
    // Hair
    fill(0); // Black hair color
    arc(x, y - 270 * s, 90 * s, 100 * s, PI, TWO_PI); // Hair on top of the head
    rect(x - 45 * s, y - 270 * s, 90 * s, 50 * s); // Hair falling on the sides
    rect(x - 40 * s, y - 250 * s, 80 * s, 30 * s); // Hair covering the forehead
    
    // Skin color
    fill(255, 204, 153);
    noStroke();
    
    // Head
    ellipse(x, y - 250 * s, 80 * s, 100 * s);
    
    // Red dress
    fill(255, 0, 0);
    beginShape();
    vertex(x - 40 * s, y - 200 * s);
    vertex(x + 40 * s, y - 200 * s);
    vertex(x + 60 * s, y);
    vertex(x - 60 * s, y);
    endShape(CLOSE);
    
    // Shoes
    fill(0);
    rect(x - 40 * s, y, 35 * s, 10 * s);
    rect(x + 5 * s, y, 35 * s, 10 * s);
    
    // Arms
    fill(255, 204, 153);
    rect(x - 60 * s, y - 200 * s, 20 * s, 100 * s);
    rect(x + 40 * s, y - 200 * s, 20 * s, 100 * s);
    
    // Face features (eyes and smile)
    fill(255);
    ellipse(x - 15 * s, y - 265 * s, 20 * s, 20 * s); // Left eye
    ellipse(x + 15 * s, y - 265 * s, 20 * s, 20 * s); // Right eye
    fill(0);
    ellipse(x - 15 * s, y - 265 * s, 10 * s, 10 * s); // Left pupil
    ellipse(x + 15 * s, y - 265 * s, 10 * s, 10 * s); // Right pupil
    
    // Smile
    noFill();
    stroke(0);
    strokeWeight(2);
    arc(x, y - 250 * s, 40 * s, 20 * s, 0, PI);
  }
}
