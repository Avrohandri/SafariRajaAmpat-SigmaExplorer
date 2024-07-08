float cloud1X, cloud2X, cloud3X;
float cloudSpeed = 1.5;

void setup() {
  size(1920, 1080);
  background(135, 206, 235); // biru langit
  fullScreen();

  drawMountains();
  drawSea();
  drawBeach();
  drawRocks();
  drawTrees();
  
  // posisi awan
  cloud1X = -200;
  cloud2X = -600;
  cloud3X = -1000;
}

void draw() {
  background(135, 206, 235);
  
  drawMountains();
  drawSea();
  drawBeach();
  drawRocks();
  drawTrees();
  
  // gambar awan
  drawCloud(cloud1X, height/4);
  drawCloud(cloud2X, height/3);
  drawCloud(cloud3X, height/5);
  
  cloud1X += cloudSpeed;
  cloud2X += cloudSpeed;
  cloud3X += cloudSpeed;
  
  // reset posisi awan
  if (cloud1X > width + 200) {
    cloud1X = -200;
  }
  if (cloud2X > width + 200) {
    cloud2X = -200;
  }
  if (cloud3X > width + 200) {
    cloud3X = -200;
  }

  // gambar matahari
  drawSun(width - 150, 150);
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

void drawSun(float x, float y) {
  noStroke();
  fill(255, 223, 0); // warna kuning matahari
  
  // gambar lingkaran matahari
  ellipse(x, y, 100, 100);
}

void drawMountains() {
  fill(119, 136, 153); 
  noStroke();
  
  // gunung pertama
  beginShape();
  vertex(0, height/2);        
  vertex(300, height/2 - 300); 
  vertex(600, height/2);      
  endShape(CLOSE);
  
  // gunung kedua
  beginShape();
  vertex(200, height/2);       
  vertex(500, height/2 - 250); 
  vertex(800, height/2);       
  endShape(CLOSE);
}

void drawSea() {
  fill(30, 144, 255); 
  noStroke();
  rect(0, height/2, width, height/2);
}

void drawBeach() {
  fill(255, 255, 224); 
  noStroke();
  rect(0, height/2 + 175, width, height/2 - 50);
}

void drawRocks() {
  fill(120, 120, 120); 
  noStroke();
  
  // gambar batu
  ellipse(200, height - 200, 160, 100);
  ellipse(300, height - 240, 200, 120);
  ellipse(400, height - 180, 180, 110);
  ellipse(260, height - 160, 120, 80);
}

void drawTrees() {
  fill(139, 69, 19); 
  noStroke();

  // batang kayu 1
  rect(width - 300, height/2 + 50, 40, 270);
  
  // batang kayu 2
  rect(width - 200, height/2 + 30, 40, 240);

  fill(34, 139, 34); 
  // daun pohon 1
  ellipse(width - 280, height/2 + 30, 160, 160);
  ellipse(width - 320, height/2 - 10, 160, 160);
  ellipse(width - 240, height/2 - 10, 160, 160);
  
  // daun pohon 2
  ellipse(width - 180, height/2 + 10, 160, 160);
  ellipse(width - 220, height/2 - 30, 160, 160);
  ellipse(width - 140, height/2 - 30, 160, 160);
}
