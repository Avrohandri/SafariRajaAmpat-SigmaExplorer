float[] logAngles = new float[5];
PVector[] logPositions = new PVector[5];
PVector[] cloudPositions = new PVector[4];
float cloudSpeed = 2;

void setup() {
  size(1920, 1080);
  background(255, 140, 0); // Warna langit jingga untuk sore hari
  fullScreen(); 

  // Inisialisasi posisi dan sudut kayu
  for (int i = 0; i < 5; i++) {
    logAngles[i] = random(-PI / 6, PI / 6);
    logPositions[i] = new PVector(width / 2, height - 200);
  }
  
  // Inisialisasi posisi awan
  cloudPositions[0] = new PVector(300, 50);
  cloudPositions[1] = new PVector(800, 100);
  cloudPositions[2] = new PVector(1300, 50);
  cloudPositions[3] = new PVector(1700, 100);
}

void draw() {
  background(255, 140, 0); // Warna langit jingga untuk sore hari
  drawSun();
  drawMountains();
  drawIsland();
  drawPalmTrees();
  drawClouds();
  drawCampfire();

  // Draw characters on the left side
  MaleCharacter male = new MaleCharacter(width / 4, height - 200, 0.6); // Skala diperkecil menjadi 0.6
  male.drawCharacter();

  FemaleCharacter female = new FemaleCharacter(width / 4 + 100, height - 200, 0.6); // Skala diperkecil menjadi 0.6
  female.drawCharacter();
}

void drawSun() {
  fill(255, 69, 0); // Warna matahari jingga
  noStroke();
  ellipse(width - 1700, 150, 100, 100); // Posisi matahari di sebelah atas barat
}

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
  for (int i = 0; i < 8; i++) {
    float angle = PI / 4 + i * PI / 4;
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
  ellipse(x + 10, y + 10, 20, 29);
    ellipse(x, y + 25, 20, 20); // Buah kelapa ketiga
}

void drawClouds() {
  fill(205, 133, 63); // Warna awan kecoklatan
  noStroke();

  // Menggambar awan di posisi yang telah diperbarui
  for (int i = 0; i < cloudPositions.length; i++) {
    drawSingleCloud(cloudPositions[i].x, cloudPositions[i].y);
  }

  // Memperbarui posisi awan
  updateCloudPositions();
}

void drawSingleCloud(float x, float y) {
  ellipse(x, y, 200, 80);
  ellipse(x + 100, y, 150, 60);
  ellipse(x + 200, y, 180, 70);
}

void updateCloudPositions() {
  for (int i = 0; i < cloudPositions.length; i++) {
    cloudPositions[i].x += cloudSpeed;

    // Membuat awan bergerak bolak-balik
    if (cloudPositions[i].x > width + 100) {
      cloudPositions[i].x = -200; // Memulai kembali dari kiri setelah melewati batas kanan
    }
  }
}

void drawCampfire() {
  // Gambar batu di sekitar api unggun
  drawCampfireStones(width / 2, height - 200);

  // Gambar kayu di bawah api unggun
  drawLogs(width / 2, height - 200);

  // Gambar api unggun
  drawFlames(width / 2, height - 200);
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
