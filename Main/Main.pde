Fenetre fenetre;

void setup() {

}

void draw() {
  if (fenetre != null)
    fenetre.drow();
}

void mousePressed() {
  if(fenetre != null){
    fenetre.mousePress();
  }
}
