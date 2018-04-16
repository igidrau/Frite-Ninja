import processing.sound.*;


Fenetre fenetre;

void setup() {
  fullScreen();
  frameRate(30);
  fenetre = new Menu();
}

void draw() {
  if(fenetre!=null)
    fenetre.drow();
}


void mouseClicked() {
  if(fenetre != null){
    fenetre.mouseClick();
  }
}

void mousePressed() {
  if(fenetre != null){
    fenetre.mousePress();
  }
}