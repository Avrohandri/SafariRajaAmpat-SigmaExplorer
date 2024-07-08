// Variabel untuk posisi karakter
float maleX;
float maleY;
float femaleX;
float femaleY;

// Variabel untuk posisi awan
float cloud1X, cloud2X, cloud3X, cloud4X;
float cloudSpeed = 1;

void setup() {
  size(1920, 1080);
  background(135, 206, 235); // Warna langit biru muda
  maleX = 400; // Posisi awal karakter laki-laki lebih jauh dari garis pohon
  maleY = height / 2 + 200; // Posisi awal karakter laki-laki di bawah pulau
  femaleX = 500; // Posisi awal karakter perempuan lebih jauh dari garis pohon
  femaleY = height / 2 + 200; // Posisi awal karakter perempuan di bawah pulau
  fullScreen();

  // Posisi awal awan
  cloud1X = 300;
  cloud2X = 800;
  cloud3X = 1300;
  cloud4X = 1700;
}

void draw() {
  background(135, 206, 235); // Warna langit biru muda
  drawSunWithRays();
  drawMountains();
  drawIsland();
  drawPalmTrees();
  drawClouds(); // Memanggil fungsi untuk menggambar awan
  drawCharacters(); // Menggambar karakter
  moveCharacters(); // Menggerakkan karakter
  moveClouds(); // Menggerakkan awan
}

void drawSunWithRays() {
  float sunSize = 80;  // Ukuran matahari
  float sunX = width - 900;  // Posisi matahari
  float sunY = 150;
  int rayCount = 12;  // Jumlah sinar matahari
  float rayLength = 60;  // Panjang sinar matahari

  // Warna oranye untuk matahari
  fill(255, 165, 0);  
  noStroke();
  ellipse(sunX, sunY, sunSize, sunSize);

  // Menggambar sinar matahari
  stroke(255, 165, 0);
  strokeWeight(3);
  for (int i = 0; i < rayCount; i++) {
    float angle = TWO_PI / rayCount * i;
    float x1 = sunX + cos(angle) * (sunSize / 2);
    float y1 = sunY + sin(angle) * (sunSize / 2);
    float x2 = sunX + cos(angle) * (sunSize / 2 + rayLength);
    float y2 = sunY + sin(angle) * (sunSize / 2 + rayLength);
    line(x1, y1, x2, y2);
  }
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
  ellipse(x + 10, y + 10, 20, 20); // Buah kelapa kedua
  ellipse(x, y + 25, 20, 20); // Buah kelapa ketiga
}

void drawClouds() {
  // Menggambar awan
  fill(255); // Warna awan (putih)
  noStroke();

  // Awan pertama
  ellipse(cloud1X, 200, 200, 80);
  ellipse(cloud1X + 100, 200, 150, 60);
  ellipse(cloud1X + 200, 200, 180, 70);

  // Awan kedua
  ellipse(cloud2X, 250, 180, 70);
  ellipse(cloud2X + 100, 250, 120, 50);
  ellipse(cloud2X + 200, 250, 150, 60);

  // Awan ketiga
  ellipse(cloud3X, 180, 160, 60);
  ellipse(cloud3X + 100, 180, 130, 50);
  ellipse(cloud3X + 200, 180, 140, 55);

  // Awan keempat
  ellipse(cloud4X, 220, 190, 75);
  ellipse(cloud4X + 100, 220, 140, 55);
  ellipse(cloud4X + 200, 220, 170, 65);
}

void drawCharacters() {
  // Menggambar karakter laki-laki
  MaleCharacter male = new MaleCharacter(maleX, maleY, 0.8);
  male.drawCharacter();

  // Menggambar karakter perempuan
  FemaleCharacter female = new FemaleCharacter(femaleX, femaleY, 0.8);
  female.drawCharacter();
}

void moveCharacters() {
  if (maleX < width - 50) { // Menggerakkan karakter laki-laki ke kanan sampai ujung layar
    maleX += 1;
  }
  
  if (femaleX < width - 50) { // Menggerakkan karakter perempuan ke kanan sampai ujung layar
    femaleX += 1;
  }
}

void moveClouds() {
  cloud1X += cloudSpeed;
  cloud2X += cloudSpeed;
  cloud3X += cloudSpeed;
  cloud4X += cloudSpeed;

  // Jika awan melewati tepi kanan layar, balik arah ke kiri
  if (cloud1X > width) {
    cloud1X = -200;
  }
  if (cloud2X > width) {
    cloud2X = -200;
  }
  if (cloud3X > width) {
    cloud3X = -200;
  }
  if (cloud4X > width) {
    cloud4X = -200;
  }
}

// Kelas untuk karakter laki-laki
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
    ellipse(x, y - 75 * s, 40 * s, 50 * s);
    
    // Blue shirt
    fill(0, 0, 255);
    rect(x - 20 * s, y - 50 * s, 40 * s, 50 * s);
    
    // Arms
    fill(255, 204, 153);
    rect(x - 30 * s, y - 50 * s, 10 * s, 50 * s);
    rect(x + 20 * s, y - 50 * s, 10 * s, 50 * s);
    
    // Red pants
    fill(255, 0, 0);
    rect(x - 20 * s, y, 15 * s, 50 * s);
    rect(x + 5 * s, y, 15 * s, 50 * s);
    
    // Shoes
    fill(0);
    rect(x - 20 * s, y + 50 * s, 15 * s, 10 * s);
    rect(x + 5 * s, y + 50 * s, 15 * s, 10 * s);
    
    // Face features (eyes and smile)
    fill(255);
    ellipse(x - 7.5 * s, y - 82.5 * s, 10 * s, 10 * s); // Left eye
    ellipse(x + 7.5 * s, y - 82.5 * s, 10 * s, 10 * s); // Right eye
    fill(0);
    ellipse(x - 7.5 * s, y - 82.5 * s, 5 * s, 5 * s); // Left pupil
    ellipse(x + 7.5 * s, y - 82.5 * s, 5 * s, 5 * s); // Right pupil
    
    // Smile
    noFill();
    stroke(0);
    strokeWeight(1);
    arc(x, y - 75 * s, 20 * s, 10 * s, 0, PI);
  }
}

// Kelas untuk karakter perempuan
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
    arc(x, y - 85 * s, 45 * s, 50 * s, PI, TWO_PI); // Hair on top of the head
    rect(x - 22.5 * s, y - 85 * s, 45 * s, 25 * s); // Hair falling on the sides
    
    // Skin color
    fill(255, 204, 153);
    noStroke();
    
    // Head
    ellipse(x, y - 75 * s, 40 * s, 50 * s);
    
    // Red dress
    fill(255, 0, 0);
    beginShape();
    vertex(x - 20 * s, y - 50 * s);
    vertex(x + 20 * s, y - 50 * s);
    vertex(x + 30 * s, y + 50 * s);
    vertex(x - 30 * s, y + 50 * s);
    endShape(CLOSE);
    
    // Shoes
    fill(0);
    rect(x - 20 * s, y + 50 * s, 15 * s, 10 * s);
    rect(x + 5 * s, y + 50 * s, 15 * s, 10 * s);
    
    // Arms
    fill(255, 204, 153);
    rect(x - 30 * s, y - 50 * s, 10 * s, 50 * s);
    rect(x + 20 * s, y - 50 * s, 10 * s, 50 * s);
    
    // Face features (eyes and smile)
    fill(255);
    ellipse(x - 7.5 * s, y - 82.5 * s, 10 * s, 10 * s); // Left eye
    ellipse(x + 7.5 * s, y - 82.5 * s, 10 * s, 10 * s); // Right eye
    fill(0);
    ellipse(x - 7.5 * s, y - 82.5 * s, 5 * s, 5 * s); // Left pupil
    ellipse(x + 7.5 * s, y - 82.5 * s, 5 * s, 5 * s); // Right pupil
    
    // Smile
    noFill();
    stroke(0);
    strokeWeight(1);
    arc(x, y - 75 * s, 20 * s, 10 * s, 0, PI);
  }
}
