// Variabel untuk posisi kapal
float shipX;
float shipY;
float shipSpeed = 1.4;  // Kecepatan pergerakan kapal

// Variabel untuk awan
float cloud1X, cloud2X, cloud3X;
float cloudSpeed1 = 0.3;
float cloudSpeed2 = 0.4;
float cloudSpeed3 = 0.5;

// Variabel untuk pegunungan
float mountainX;
float mountainSpeed = 0.2;

// Variabel untuk ikan
float[] fishX = new float[3];
float[] fishY = new float[3];
float[] fishSpeed = {1.5, 2.0, 1.8};

void setup() {
  size(1920, 1080);  // ukuran canvas
  shipX = -500;  // posisi kapal di luar layar di sebelah kiri
  shipY = height * 0.75;  // posisi kapal di dekat bagian bawah canvas
  fullScreen();

  // Inisialisasi posisi awan
  cloud1X = 0;
  cloud2X = width / 2;
  cloud3X = width;

  // Inisialisasi posisi pegunungan
  mountainX = -300;  // posisi awal di luar layar sebelah kiri

  // Inisialisasi posisi ikan di bawah kapal dengan sumbu y yang berbeda
  for (int i = 0; i < fishX.length; i++) {
    fishX[i] = shipX + 100 * i;  // Posisi ikan berdekatan di bawah kapal
    fishY[i] = shipY + 100 + 30 * i; // Posisi ikan berbeda di dalam laut di bawah kapal
  }
}

void draw() {
  background(135, 206, 235);  // Warna biru langit

  // Menggambar lautan
  drawOcean();
  
  drawSunWithRays();
  // Menggambar pegunungan yang bergerak
  moveMountain();
  drawMountain(mountainX);

  // Menggambar awan yang bergerak
  moveClouds();
  drawCloud(cloud1X, 200);
  drawCloud(cloud2X, 250);
  drawCloud(cloud3X, 220);

  // Menggambar kapal dan menggerakkannya
  moveShip();
  drawShip(shipX, shipY, 1);  // Skala kapal diperbesar menjadi 1

  // Menggambar ikan dan menggerakkannya
  for (int i = 0; i < fishX.length; i++) {
    drawFish(fishX[i], fishY[i], 0.5);
    fishX[i] += fishSpeed[i];
    if (fishX[i] > width) {
      fishX[i] = -50; // Reset posisi ikan jika keluar dari layar
    }
  }
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
  fill(255);  // Warna putih awan
  ellipse(x, y, 120, 90);
  ellipse(x + 45, y - 22.5, 105, 75);
  ellipse(x + 90, y, 120, 90);
}

// Fungsi untuk menggambar pegunungan
void drawMountain(float x) {
  fill(34, 139, 34);  // Warna hijau tua untuk pegunungan
  noStroke();

  beginShape();
  vertex(x, height * 0.5);  // Sudut kiri bawah, di atas laut
  vertex(x + 300, height * 0.5);  // Sudut kanan bawah, di atas laut
  vertex(x + 150, height * 0.1);  // Puncak pegunungan
  endShape(CLOSE);
}

// Fungsi untuk menggambar kapal dan menggerakkannya
void drawShip(float x, float y, float scale) {
  // Mengatur dimensi berdasarkan skala
  float shipWidth = 300 * scale;
  float shipHeight = 150 * scale;

  fill(139, 69, 19);  // Warna coklat kapal
  noStroke();

  // Badan kapal
  beginShape();
  vertex(x, y);  // Sudut kiri bawah
  vertex(x + shipWidth, y);  // Sudut kanan bawah
  vertex(x + shipWidth + 45 * scale, y - shipHeight);  // Sudut kanan atas
  vertex(x - 45 * scale, y - shipHeight);  // Sudut kiri atas
  endShape(CLOSE);

  // Kabin
  fill(160, 82, 45);  // Warna coklat tua kabin
  rect(x + 45 * scale, y - shipHeight + 30 * scale, 90 * scale, 60 * scale);
  rect(x + 150 * scale, y - shipHeight + 30 * scale, 90 * scale, 60 * scale);

  // Tiang
  stroke(0);  // Warna hitam tiang
  strokeWeight(3);  // Ketebalan garis
  float mastHeight = 180 * scale;  // Tinggi tiang
  line(x + shipWidth / 2, y - shipHeight, x + shipWidth / 2, y - shipHeight - mastHeight);

  // Layar
  fill(255);  // Warna putih layar
  noStroke();
  float sailHeight = 120 * scale;  // Tinggi layar
  float sailWidth = 90 * scale;  // Lebar layar
  triangle(x + shipWidth / 2, y - shipHeight - mastHeight,  // Titik bawah segitiga
           x + shipWidth / 2 + sailWidth, y - shipHeight - mastHeight + sailHeight,  // Titik kanan segitiga
           x + shipWidth / 2, y - shipHeight - mastHeight + sailHeight);  // Titik kiri segitiga

  // Menggambar karakter laki-laki dan perempuan di atas kapal
  MaleCharacter male = new MaleCharacter(x + shipWidth / 4, y - shipHeight, 1.0);
  male.drawCharacter();
  
  FemaleCharacter female = new FemaleCharacter(x + 3 * shipWidth / 4, y - shipHeight, 1.0);
  female.drawCharacter();
}

// Fungsi untuk menggambar ikan
void drawFish(float x, float y, float scale) {
  float fishWidth = 100 * scale;
  float fishHeight = 50 * scale;
  
  fill(255, 165, 0); // Warna ikan
  noStroke();
  
  // Badan ikan
  ellipse(x, y, fishWidth, fishHeight);
  
  // Ekor ikan
  triangle(x - fishWidth / 2, y,
           x - fishWidth / 2 - 20 * scale, y - 20 * scale,
           x - fishWidth / 2 - 20 * scale, y + 20 * scale);
  
  // Mata ikan
  fill(255);
  ellipse(x + fishWidth / 4, y - fishHeight / 4, 10 * scale, 10 * scale);
  fill(0);
  ellipse(x + fishWidth / 4, y - fishHeight / 4, 5 * scale, 5 * scale);
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

// Fungsi untuk menggerakkan pegunungan
void moveMountain() {
  mountainX += mountainSpeed;

  // Jika pegunungan mencapai tepi kanan layar, reset ke posisi awal
  if (mountainX > width) {
    mountainX = -500;
  }
}

// Fungsi untuk menggerakkan kapal
void moveShip() {
  shipX += shipSpeed;

  // Jika kapal mencapai tepi kanan layar, reset ke posisi awal
  if (shipX > width + 400) {
    shipX = -500;
  }
}

// Fungsi untuk menggambar matahari
void drawSunWithRays() {
  float sunSize = 80;  // Ukuran matahari
  float sunX = width - sunSize - 20;  // Posisi matahari di pojok kanan atas
  float sunY = sunSize + 20;
  int rayCount = 12;  // Jumlah sinar matahari
  float rayLength = 60;  // Panjang sinar matahari

  // Warna kuning untuk matahari
  fill(255, 255, 0);  
  noStroke();
  ellipse(sunX, sunY, sunSize, sunSize);

  // Menggambar sinar matahari
  stroke(255, 255, 0);
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
