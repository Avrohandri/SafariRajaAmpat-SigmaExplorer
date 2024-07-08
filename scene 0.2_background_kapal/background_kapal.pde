float cloud1X, cloud2X, cloud3X;
float cloudSpeed = 1.5; // kecepatan awan

void setup() {
  size(1920, 1080);
  cloud1X = -200;
  cloud2X = -600;
  cloud3X = -1000;
  fullScreen(); 
}

void draw() {
  background(135, 206, 235); 
  
  drawMountains();
  drawSea();
  drawBeach();
  drawRocks();
  drawTrees();
  
  drawCloud(cloud1X, height/4);
  drawCloud(cloud2X, height/3);
  drawCloud(cloud3X, height/5);
  
  cloud1X += cloudSpeed;
  cloud2X += cloudSpeed;
  cloud3X += cloudSpeed;
  
  if (cloud1X > width + 200) {
    cloud1X = -200;
  }
  if (cloud2X > width + 200) {
    cloud2X = -200;
  }
  if (cloud3X > width + 200) {
    cloud3X = -200;
  }
  
  drawShip(width/2 - 250, height/2 + 260, 1.0); 
  drawSun();

  // karakter laki-laki
  MaleCharacter male = new MaleCharacter(width/2 - 50, height - 100);
  male.drawCharacter();
  
  // karakter perempuan
  FemaleCharacter female = new FemaleCharacter(width/2 + 50, height - 100);
  female.drawCharacter();
}

void drawSun() {
  fill(255, 223, 0); 
  noStroke();
  ellipse(width - 150, 150, 100, 100); // matahari di sebelah kanan atas
}

void drawCloud(float x, float y) {
  noStroke();
  fill(255); 
  
  // bentuk awan
  ellipse(x, y, 100, 80);
  ellipse(x + 30, y - 20, 100, 80);
  ellipse(x + 60, y, 100, 80);
  ellipse(x + 30, y + 20, 100, 80);
}

void drawMountains() {
  fill(119, 136, 153); 
  noStroke();
  
  // gunung pertama
  beginShape();
  vertex(0, height/2);        // sudut kiri bawah
  vertex(300, height/2 - 300); // puncak atas
  vertex(600, height/2);      // sudut kanan bawah
  endShape(CLOSE);
  
  // gunung kedua
  beginShape();
  vertex(200, height/2);       // sudut kiri bawah
  vertex(500, height/2 - 250); // puncak atas
  vertex(800, height/2);       // sudut kanan bawah
  endShape(CLOSE);
}

void drawSea() {
  fill(30, 144, 255); // biru laut yang lebih gelap
  noStroke();
  rect(0, height/2, width, height/2);
}

void drawBeach() {
  fill(255, 255, 224); // kuning muda untuk pasir pantai
  noStroke();
  rect(0, height/2 + 175, width, height/2 - 50); // atur area pantai di atas laut
}

void drawRocks() {
  fill(120, 120, 120); // batu abu-abu
  noStroke();
  
  // gambar beberapa batu di sebelah kiri
  ellipse(200, height - 200, 160, 100);
  ellipse(300, height - 240, 200, 120);
  ellipse(400, height - 180, 180, 110);
  ellipse(260, height - 160, 120, 80);
}

void drawTrees() {
  fill(139, 69, 19); // coklat untuk batang pohon
  noStroke();

  // batang pohon pertama
  rect(width - 300, height/2 + 50, 40, 270);
  
  // batang pohon kedua
  rect(width - 200, height/2 + 30, 40, 240);

  fill(34, 139, 34); // hijau untuk daun
  // daun pohon pertama
  ellipse(width - 280, height/2 + 30, 160, 160);
  ellipse(width - 320, height/2 - 10, 160, 160);
  ellipse(width - 240, height/2 - 10, 160, 160);
  
  // daun pohon kedua
  ellipse(width - 180, height/2 + 10, 160, 160);
  ellipse(width - 220, height/2 - 30, 160, 160);
  ellipse(width - 140, height/2 - 30, 160, 160);
}

void drawShip(float x, float y, float scale) {
  // sesuaikan dimensi berdasarkan skala
  float shipWidth = 200 * scale;
  float shipHeight = 100 * scale;
  
  fill(139, 69, 19); // warna coklat untuk kapal
  noStroke();
  
  // badan kapal
  beginShape();
  vertex(x, y); // sudut kiri bawah
  vertex(x + shipWidth, y); // sudut kanan bawah
  vertex(x + shipWidth + 50 * scale, y - shipHeight); // sudut kanan atas
  vertex(x - 50 * scale, y - shipHeight); // sudut kiri atas
  endShape(CLOSE);
  
  // kabin
  fill(160, 82, 45); // coklat tua untuk kabin
  rect(x + 30 * scale, y - shipHeight + 20 * scale, 60 * scale, 40 * scale);
  
  fill(160, 82, 45); // coklat tua untuk kabin
  rect(x + 100 * scale, y - shipHeight + 20 * scale, 60 * scale, 40 * scale);
  
  // tiang layar
  stroke(0); // warna hitam untuk tiang layar
  strokeWeight(2); // garis tipis
  float mastHeight = 120 * scale; // tinggi tiang layar
  line(x + shipWidth / 2, y - shipHeight, x + shipWidth / 2, y - shipHeight - mastHeight); // membuat tiang layar lebih tinggi
  
  // layar
  fill(255); // warna putih untuk layar
  noStroke();
  float sailHeight = 80 * scale; // tinggi layar
  float sailWidth = 60 * scale; // lebar layar
  triangle(x + shipWidth / 2, y - shipHeight - mastHeight, // titik bawah segitiga, posisi lebih rendah
           x + shipWidth / 2 + sailWidth, y - shipHeight - mastHeight + sailHeight, // titik kanan segitiga, sisi kanan
           x + shipWidth / 2, y - shipHeight - mastHeight + sailHeight); // titik kiri segitiga, sisi kiri
}

class MaleCharacter {
  float x, y;
  
  MaleCharacter(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void drawCharacter() {
    // warna kulit
    fill(255, 204, 153);
    noStroke();
    
    // kepala
    ellipse(x, y - 150, 80, 100);
    
    // baju biru
    fill(0, 0, 255);
    rect(x - 40, y - 100, 80, 100);
    
    // celana merah
    fill(255, 0, 0);
    rect(x - 40, y, 35, 100);
    rect(x + 5, y, 35, 100);
    
    // sepatu
    fill(0);
    rect(x - 40, y + 100, 35, 10);
    rect(x + 5, y + 100, 35, 10);
    
    // lengan
    fill(255, 204, 153);
    rect(x - 60, y - 100, 20, 100);
    rect(x + 40, y - 100, 20, 100);
    
    // fitur wajah (mata dan senyum)
    fill(255);
    ellipse(x - 15, y - 165, 20, 20); // mata kiri
    ellipse(x + 15, y - 165, 20, 20); // mata kanan
    fill(0);
    ellipse(x - 15, y - 165, 10, 10); // pupil kiri
    ellipse(x + 15, y - 165, 10, 10); // pupil kanan
    
    // senyum
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
    // rambut
    fill(0); // warna rambut hitam
    arc(x, y - 170, 90, 100, PI, TWO_PI); // rambut di atas kepala
    rect(x - 45, y - 170, 90, 50); // rambut yang jatuh di samping
    rect(x - 40, y - 150, 80, 30); // rambut yang menutupi dahi
    
    // warna kulit
    fill(255, 204, 153);
    noStroke();
    
    // kepala
    ellipse(x, y - 150, 80, 100);
    
    // gaun merah
    fill(255, 0, 0);
    beginShape();
    vertex(x - 40, y - 100);
    vertex(x + 40, y - 100);
    vertex(x + 60, y + 100);
    vertex(x - 60, y + 100);
    endShape(CLOSE);
    
    // sepatu
    fill(0);
    rect(x - 40, y + 100, 35, 10);
    rect(x + 5, y + 100, 35, 10);
    
    // lengan
    fill(255, 204, 153);
    rect(x - 60, y - 100, 20, 100);
    rect(x + 40, y - 100, 20, 100);
    
    // fitur wajah (mata dan senyum)
    fill(255);
    ellipse(x - 15, y - 165, 20, 20); // mata kiri
    ellipse(x + 15, y - 165, 20, 20); // mata kanan
    fill(0);
    ellipse(x - 15, y - 165, 10, 10); // pupil kiri
    ellipse(x + 15, y - 165, 10, 10); // pupil kanan
    
    // senyum
    noFill();
    stroke(0);
    strokeWeight(2);
    arc(x, y - 150, 40, 20, 0, PI);
  }
}
