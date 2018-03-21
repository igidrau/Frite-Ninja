Fenetre fenetre;
//Patate test = new Patate(0, 0, 2, 6, 10, 0);
ArrayList<Patate> test = new ArrayList<Patate>();
int nbpatates = 30;

void setup() {
  fullScreen();
  frameRate(60);
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
