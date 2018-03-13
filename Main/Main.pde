Fenetre fenetre;
Patate test = new Patate(300, 300, 4, 4, 5, 10, 0);


void setup() {
  fullScreen();
  frameRate(1000);
}

void draw() {
  if (fenetre != null)
    fenetre.drow();
  translate(displayWidth, displayHeight);
  rotate(PI);
  ellipse(test.position.x, test.position.y, 10, 10);
  test.mouvementTerrestre();
}

void mousePressed() {
  if(fenetre != null){
    fenetre.mousePress();
  }
}
