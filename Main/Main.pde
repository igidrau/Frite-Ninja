import processing.sound.*;


Fenetre fenetre;
ArrayList<Patate> test = new ArrayList<Patate>();

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