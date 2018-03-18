// Une interface qui permet notamment de séparer les fonctions draw(), mouseClick() etc. pour chaque affichage.
final float parsec = 1; // le nombre d'images par seconde
final float echelleTerre = 300; // pxl/m
final float echelleGeopw = 4.5; //(10^)pxl/m

interface Fenetre {
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
    for(int i=0; i<nbpatates; i++){
      this.creerPatate();
    }
    contenu.endDraw();
    this.contenu = contenu;
  }
  
  PGraphics getContenu() {
    return contenu;
  }
  
  void drow(){
    //clear();
    translate(displayWidth, displayHeight);
    rotate(PI);
    for(Patate i : test){
      ellipse(i.position.x*echelleTerre, i.position.y*echelleTerre, 10, 10);
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
    /*for(int i=0; i<nbpatates; i++){
      this.creerPatate();
    }*/
    contenu.endDraw();
    this.contenu = contenu;
  }
  
  PGraphics getContenu() {
    return contenu;
  }
  
  void drow(){
    //println(test.size());
    //clear();
    translate(displayWidth/2, displayHeight/2);
    rotate(PI);
    ellipse(0, 0, 2*rTerrenb*pow(10, rTerrepw-echelleGeopw), 2*rTerrenb*pow(10, rTerrepw-echelleGeopw));
    for(Patate i : test){
      ellipse(i.position.x*pow(10, -echelleGeopw), i.position.y*pow(10, -echelleGeopw), 10, 10);
      i.mouvementGeo();
    }
    for(int i=test.size()-1; i>=0; i--)
      if(sqrt(pow(test.get(i).position.x,2)+pow(test.get(i).position.y,2))<rTerrenb*pow(10,rTerrepw))
        test.remove(i);
  }
  
  void mousePress(){
    creerPatate();
  }
  
  void creerPatate(){
    float angle = 0.0;//random(2*PI);
    PVector depart;
    Patate test1;
    depart = PVector.fromAngle(angle);
    depart.mult((rTerrenb+0.1) * pow(10,rTerrepw));
    test1 = new Patate(depart.x, depart.y, 0, 14000, 0.2, 0);
    test.add(test1);
  }
}
