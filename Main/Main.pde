Fenetre fenetre;
//Patate test = new Patate(0, 0, 2, 6, 10, 0);
ArrayList<Patate> test = new ArrayList<Patate>();
int nbpatates = 30

void setup() {
  fullScreen();
  frameRate(1000);
  Patate test1;
  for(int i=0; i<nbpatates; i++){
    test1 = new Patate((int)random(1000), 0, random(-3, 3), random(4, 7), random(0.2), 0);
    test.add(test1);
  }
}

void draw() {
  println(test.size());
  clear();
  if (fenetre != null)
    fenetre.drow();
  translate(displayWidth, displayHeight);
  rotate(PI);
  for(Patate i : test){
    ellipse(i.position.x, i.position.y, 10, 10);
    i.mouvementTerrestre();
  }
  for(int i=test.size()-1; i>=0; i--)
    if(test.get(i).position.y<=0)
      test.remove(i);
  //ellipse(test.position.x, test.position.y, 10, 10);
  //test.mouvementTerrestre();
}

void mousePressed() {
  if(fenetre != null){
    fenetre.mousePress();
  }
}
