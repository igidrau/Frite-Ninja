// Une interface qui permet notamment de séparer les fonctions draw(), mouseClick() etc. pour chaque affichage.
float parsec; // le nombre d'images par seconde
final float echelleTerre = 300; // pxl/m
final float echelleGeopw = 4.5; //(10^)pxl/m

static interface Fenetre {
  PGraphics getContenu() ;
  
  void mousePress();
  void drow();
}



class Menu implements Fenetre {
  
  private PGraphics contenu;
  public Menu(PGraphics contenu) {
    contenu.beginDraw();
    contenu.endDraw();
    this.contenu = contenu;
  }
  
  PGraphics getContenu() {
    return contenu;
  }
  
  void drow(){}
  
  void mousePress(){}
}

class JeuTerre implements Fenetre {
  
  private PGraphics contenu;
  public JeuTerre(PGraphics contenu) {
    contenu.beginDraw();
    parsec = 500;
    contenu.endDraw();
    this.contenu = contenu;
  }
  
  PGraphics getContenu() {
    return contenu;
  }
  
  void drow(){
    clear();
    translate(displayWidth, displayHeight);
    rotate(PI);
    for(Patate i : test){
      image(i.img, i.position.x*echelleTerre, i.position.y*echelleTerre, (int)displayWidth/40, (int)displayWidth/30);
      i.mouvementTerrestre();
    }
    for(int i=test.size()-1; i>=0; i--)
      if(test.get(i).position.y<0){
        test.remove(i);
        creerPatate();
      }
  }
  
  void mousePress(){
    this.creerPatate();
  }
  
  void creerPatate(){
    Patate test1 = new Patate(random(displayWidth/echelleTerre), 0, random(-3, 3), random(4, 7), random(0.2), 0);
    test.add(test1);
  }
}

class JeuGeo implements Fenetre {
  
  private PGraphics contenu;
  public JeuGeo(PGraphics contenu) {
    contenu.beginDraw();
    parsec = 0.2;
    contenu.endDraw();
    this.contenu = contenu;
  }
  
  PGraphics getContenu() {
    return contenu;
  }
  
  void drow(){
    clear();
    translate(displayWidth/2, displayHeight/2);
    rotate(PI);
    ellipse(0, 0, 2*rTerrenb*pow(10, rTerrepw-echelleGeopw), 2*rTerrenb*pow(10, rTerrepw-echelleGeopw));
    for(Patate i : test){
      ellipse(i.position.x*pow(10, -echelleGeopw), i.position.y*pow(10, -echelleGeopw), 10, 10);
      i.mouvementGeo();
    }
    for(int i=test.size()-1; i>=0; i--)
      if(sqrt(pow(test.get(i).position.x,2)+pow(test.get(i).position.y,2))<rTerrenb*pow(10,rTerrepw)){
        test.remove(i);
        this.creerPatate();
      }
  }
  
  void mousePress(){
    creerPatate();
  }
  
  void creerPatate(){
    float angle = random(2*PI);//random(2*PI);
    PVector depart;
    Patate test1;
    depart = PVector.fromAngle(angle);
    depart.mult((rTerrenb) * pow(10,rTerrepw));
    PVector vitesse = PVector.fromAngle(angle+random(-PI/2,PI/2)).mult(random(10000,14500));
    test1 = new Patate(depart.x, depart.y, vitesse.x, vitesse.y, 0.2, 0);
    test.add(test1);
  }
}
