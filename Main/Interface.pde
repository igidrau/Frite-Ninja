// Une interface qui permet notamment de séparer les fonctions draw(), mouseClick() etc. pour chaque affichage.
float parsec; // le nombre d'images par seconde
final float echelleTerre = 300; // pxl/m
final float echelleGeopw = 4.5; //(10^)pxl/m

static interface Fenetre {
  
  void drow();
  void mousePress();
  void mouseClick();
}



class Menu implements Fenetre {
  
  PImage jouer, boutique, parametre, m_score, quitter, instruct;
  public Menu() {
    jouer = loadImage("bouton-0.png");
    boutique = loadImage("bouton-1.png");
    parametre = loadImage("bouton-3.png");
    m_score = loadImage("bouton-2.png");
    quitter = loadImage("bouton-4.png");
    instruct = loadImage("bouton-5.png");

  }
  
  void drow(){
    imageMode(CENTER);
    image(this.jouer,displayWidth/2, displayHeight/3);
    image(this.boutique,displayWidth/2, 2*displayHeight/3);
    image(this.parametre, displayWidth - 188/2, displayHeight-(displayHeight - 143/2));
    image(this.m_score, 188/2, displayHeight - 143/2);
    image(this.quitter, displayWidth - 188/2, displayHeight - 143/2);
    image(this.instruct, displayWidth/2, displayHeight - 140/2);
  }
  
  void mousePress(){}
  
  void mouseClick(){
    if ((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && (mouseY < displayHeight/3 + 131/2) && (mouseY > displayHeight/3 - 131/2))
      fenetre = new JeuTerre();
  }
}

class JeuTerre implements Fenetre {
  
  public JeuTerre() {
    parsec = 200;
  }
  

  
  void drow(){
    clear();
    translate(displayWidth, displayHeight);
    rotate(PI);
    for(Patate i : test){
      image(i.img, i.position.x*echelleTerre, i.position.y*echelleTerre, (int)displayWidth/10, (int)displayWidth/7);
      i.mouvementTerrestre();
    }
    for(int i=test.size()-1; i>=0; i--)
      if(test.get(i).position.y<-0.5){
        test.remove(i);
        creerPatate();
      }
  }
  
  void mousePress(){
    this.creerPatate();
  }
  
  void mouseClick(){}
  
  void creerPatate(){
    Patate test1 = new Patate(random(displayWidth/echelleTerre), 0, random(-3, 3), random(4, 7), random(0.05,0.2), 0);
    test.add(test1);
  }
}

class JeuGeo implements Fenetre {
  
  public JeuGeo() {
    parsec = 0.2;
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
  
  void mouseClick(){}
  
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
