// Variabel untuk posisi kapal
float shipX;
float shipY;
float shipSpeed = 1;  // Kecepatan pergerakan kapal

// Variabel untuk awan
float cloud1X, cloud2X, cloud3X;
float cloudSpeed1 = 0.3;
float cloudSpeed2 = 0.4;
float cloudSpeed3 = 0.5;

// Variabel untuk pulau
float islandX;
float islandSpeed = 0.1;  // Kecepatan pergerakan pulau yang lebih lambat

// Variabel untuk ombak
int waveCount = 20;  // Banyaknya ombak
float[] waveX = new float[waveCount];
float[] waveY = new float[waveCount];
float waveSpeed = 1.0;

void setup() {
  size(1920, 1080);  // ukuran canvas
  shipX = width - 300;  // posisi kapal di dekat pulau
  shipY = height * 0.75;  // posisi kapal di dekat bagian bawah canvas
  fullScreen(); 

  // Inisialisasi posisi awan
  cloud1X = 0;
  cloud2X = width / 2;
  cloud3X = width;

  // Inisialisasi posisi pulau
  islandX = width - 300;  // posisi pulau lebih ke kanan

  // Inisialisasi posisi ombak
  for (int i = 0; i < waveCount; i++) {
    waveX[i] = random(width);
    waveY[i] = height * 0.5 + random(height * 0.5);
  }
}

void draw() {
  background(255, 140, 0);  // Warna oranye langit sore

  // Menggambar lautan
  drawOcean();

  // Menggambar ombak yang bergerak
  moveWaves();
  drawWaves();

  // Menggambar awan yang bergerak
  moveClouds();
  drawCloud(cloud1X, 200);
  drawCloud(cloud2X, 250);
  drawCloud(cloud3X, 220);

  // Menggambar pulau
  drawIsland();

  // Menggambar kapal dan menggerakkannya
  moveShip();
  drawShip(shipX, shipY, 1.0);  // Skala kapal diperkecil menjadi 1.0

  // Menggambar matahari di pojok kanan atas
  drawSun();
}

// Fungsi untuk menggambar lautan
void drawOcean() {
  noStroke();
  fill(30, 144, 255);  // Warna biru laut
  rect(0, height * 0.5, width, height * 0.5);  // Bagian bawah canvas sebagai laut
}

// Fungsi untuk menggambar awan
void drawCloud(float x, float y) {
  noStroke();
  fill(255, 165, 0);  // Warna oranye awan
  ellipse(x, y, 120, 90);
  ellipse(x + 45, y - 22.5, 105, 75);
  ellipse(x + 90, y, 120, 90);
}

// Fungsi untuk menggambar pulau
void drawIsland() {
  // Warna pulau diganti menjadi warna pasir laut (kecoklatan)
  fill(255, 235, 205);  // Warna pasir laut
  noStroke();
  
  // Menggambar dasar pulau (bentuk bulat)
  ellipse(islandX + 300, height * 0.7, 800, 400);  // Menyesuaikan ukuran pulau
  
  // Menggambar pohon-pohon baru di sekitar pulau
  drawPalmTree(islandX + 20, height * 0.6);  
  drawPalmTree(islandX + 100, height * 0.65);  
  drawPalmTree(islandX + 300, height * 0.7); 
  drawPalmTree(islandX + 300, height * 0.8); 
  drawPalmTree(islandX + 300, height * 0.6); 
  drawPalmTree(islandX + 260, height * 0.7);
  drawPalmTree(islandX + 50, height * 0.6);
}

// Fungsi untuk menggambar pohon dengan batang, ranting, dan daun
//void drawTree(float x, float y) {
//  // Batang pohon
//  fill(139, 69, 19);  // Warna coklat untuk batang pohon
//  rect(x - 3, y, 6, 40);  // Menyesuaikan ukuran batang pohon

//  // Ranting pohon
//  fill(139, 69, 19);  // Warna coklat untuk ranting pohon
//  rect(x - 10, y - 30, 20, 5);  // Menyesuaikan ukuran ranting pohon

//  // Daun pohon
//  fill(34, 139, 34);  // Warna hijau tua untuk daun pohon
//  ellipse(x, y - 40, 60, 60);  // Menyesuaikan ukuran daun pohon
//  ellipse(x + 20, y - 20, 60, 60);  // Menyesuaikan ukuran daun pohon
//  ellipse(x - 20, y - 20, 60, 60);  // Menyesuaikan ukuran daun pohon
//}

// Fungsi untuk menggambar pohon kelapa
void drawPalmTree(float x, float y) {
  // Batang pohon
  fill(139, 69, 19);  // Warna coklat untuk batang pohon
  rect(x - 5, y - 100, 10, 100);  // Menyesuaikan ukuran batang pohon

  // Daun pohon kelapa
  fill(34, 139, 34);  // Warna hijau tua untuk daun pohon kelapa
  for (int i = 0; i < 8; i++) {
    float angle = TWO_PI / 8 * i;
    drawPalmLeaf(x, y - 100, 50, angle);  // Daun lebih kecil dan lancip
  }

  // Buah kelapa
  fill(144, 238, 144);  // Warna hijau muda untuk buah kelapa
  ellipse(x, y - 100, 20, 20);  // Buah kelapa di tengah
  ellipse(x + 15, y - 90, 20, 20);  // Buah kelapa di kanan
  ellipse(x - 15, y - 90, 20, 20);  // Buah kelapa di kiri
}

// Fungsi untuk menggambar daun pohon kelapa
void drawPalmLeaf(float x, float y, float length, float angle) {
  fill(34, 139, 34);  // Warna daun
  noStroke();

  pushMatrix();
  translate(x, y);
  rotate(angle);

  beginShape();
  vertex(0, 0);
  for (float i = 0; i <= length; i += 10) {
    float width = 5 * sin(PI * i / length);
    vertex(-width, i);
  }
  for (float i = length; i >= 0; i -= 10) {
    float width = 5 * sin(PI * i / length);
    vertex(width, i);
  }
  endShape(CLOSE);

  popMatrix();
}

// Fungsi untuk menggambar kapal dan menggerakkannya
void drawShip(float x, float y, float scale) {
  // Mengatur dimensi berdasarkan skala
  float shipWidth = 200 * scale;
  float shipHeight = 100 * scale;

  fill(139, 69, 19);  // Warna coklat kapal
  noStroke();

  // Badan kapal
  beginShape();
  vertex(x, y);  // Sudut kiri bawah
  vertex(x - shipWidth, y);  // Sudut kanan bawah
  vertex(x - shipWidth - 30 * scale, y - shipHeight);  // Sudut kanan atas
  vertex(x + 30 * scale, y - shipHeight);  // Sudut kiri atas
  endShape(CLOSE);

  // Kabin
  fill(160, 82, 45);  // Warna coklat tua kabin
  rect(x - 90 * scale, y - shipHeight + 20 * scale, 60 * scale, 40 * scale);
  rect(x - 160 * scale, y - shipHeight + 20 * scale, 60 * scale, 40 * scale);

  // Tiang
  stroke(0);  // Warna hitam tiang
  strokeWeight(2);  // Ketebalan garis
  float mastHeight = 120 * scale;  // Tinggi tiang
  line(x - shipWidth / 2, y - shipHeight, x - shipWidth / 2, y - shipHeight - mastHeight);

  // Layar
  fill(255);  // Warna putih layar
  noStroke();
  float sailHeight = 80 * scale;  // Tinggi layar
  float sailWidth = 60 * scale;  // Lebar layar
  triangle(x - shipWidth / 2, y - shipHeight - mastHeight,  // Titik bawah segitiga
           x - shipWidth / 2 - sailWidth, y - shipHeight - mastHeight + sailHeight,  // Titik kiri segitiga
           x - shipWidth / 2, y - shipHeight - mastHeight + sailHeight);  // Titik kanan segitiga
           
  // Draw male and female characters on the ship
  MaleCharacter male = new MaleCharacter(x + shipWidth / 15 - 180, y - shipHeight, 0.8); // Position more to the left
  male.drawCharacter();
  
  FemaleCharacter female = new FemaleCharacter(x + shipWidth / 8 - 60, y - shipHeight, 0.8); // Position more to the left
  female.drawCharacter();
}


// Fungsi untuk menggambar ombak
void drawWaves() {
  stroke(255);  // Warna putih untuk ombak
  strokeWeight(2);
  noFill();
  for (int i = 0; i < waveCount; i++) {
    beginShape();
    for (float t = 0; t < TWO_PI; t += 0.1) {
      float x = waveX[i] + 20 * t;
      float y = waveY[i] + 10 * sin(t + frameCount * 0.1);
      vertex(x, y);
    }
    endShape();
  }
}

// Fungsi untuk menggerakkan ombak
void moveWaves() {
  for (int i = 0; i < waveCount; i++) {
    waveX[i] += waveSpeed;

    // Jika ombak mencapai tepi kanan layar, reset ke posisi awal
    if (waveX[i] > width) {
      waveX[i] = -20;
      waveY[i] = height * 0.5 + random(height * 0.5);
    }
  }
}

// Fungsi untuk menggerakkan awan
void moveClouds() {
  cloud1X += cloudSpeed1;
  cloud2X += cloudSpeed2;
  cloud3X += cloudSpeed3;

  // Jika awan mencapai tepi kanan layar, reset ke posisi awal
  if (cloud1X > width) {
    cloud1X = -120;
  }
  if (cloud2X > width) {
    cloud2X = -120;
  }
  if (cloud3X > width) {
    cloud3X = -120;
  }
}

// Fungsi untuk menggerakkan kapal
void moveShip() {
  // Hentikan kapal jika mencapai tepi kiri layar
  if (shipX + 200 * 1.0 < 0) {
    shipSpeed = 0;
  } else {
    shipSpeed = 2;
    shipX -= shipSpeed;  // Bergerak ke kiri dengan mengurangi posisi X
  }

  // Jika kapal melewati tepi kiri layar, reset ke posisi awal di sebelah kanan
  if (shipX < -500) {
    shipX = width - 300;
  }
}

// Fungsi untuk menggambar matahari
void drawSun() {
  float sunSize = 120;  // Ukuran matahari
  
  // Posisi matahari di pojok kanan atas dengan semakin oranye
  float sunX = width - sunSize - 1700;
  float sunY = sunSize + 50;
  
  // Warna kuning-oranye untuk matahari
  fill(255, 69, 0);  
  noStroke();
  ellipse(sunX, sunY, sunSize, sunSize);
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
    rect(x - 20 * s, y - 50 * s, 40 * s, 50 * s);
    
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
