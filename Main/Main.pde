Fenetre fenetre;
//Patate test = new Patate(0, 0, 2, 6, 10, 0);
ArrayList<Patate> test = new ArrayList<Patate>();
int nbpatates = 30;

void setup() {
  fullScreen();
  frameRate(1000);
  fenetre = new JeuGeo(createGraphics(displayWidth, displayHeight));
}

void draw() {
  if(fenetre!=null)
    fenetre.drow();
}

void mousePressed() {
  if(fenetre != null){
    fenetre.mousePress();
  }
}
