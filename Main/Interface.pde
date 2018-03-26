// Une interface qui permet notamment de séparer les fonctions draw(), mouseClick() etc. pour chaque affichage.
float parsec; // le nombre d'images par seconde
final int echelleTerre = 300; // pxl/m
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
      fenetre = new JeuGeo();
  }
}

class JeuTerre implements Fenetre {
  
  PImage doigt;
  public JeuTerre() {
    parsec = 100;
    creerPatate();
    imageMode(CENTER);
    doigt = loadImage("RACKET-1-OMBRE.png");
  }
  

  
  void drow(){
    clear();
    background(255);
    for(Patate i : test){
      translate(displayWidth-i.position.x*echelleTerre, displayHeight-i.position.y*echelleTerre);
      image(i.img, 0, 0, (int)displayWidth/10, (int)displayWidth/7);
      i.mouvementTerrestre();
      translate(i.position.x*echelleTerre-displayWidth, i.position.y*echelleTerre-displayHeight);
    }
    for(int i=test.size()-1; i>=0; i--){
      if(test.get(i).position.y<-0.5){
        test.remove(i);
      }
    }
    
    if(mousePressed){
      //rotate(PI);
      image(doigt,mouseX, mouseY, 100, 100);
      for(int i=test.size()-1; i>=0; i--){
        if(abs(test.get(i).position.y*echelleTerre+(mouseY-displayHeight))<70 && abs(test.get(i).position.x*echelleTerre+(mouseX-displayWidth))<50){
          test.remove(i);
        }
      }
    }
    if((int)random(100)==1)
      creerPatate();
      
  }
  
  void mousePress(){
    //this.creerPatate();
  }
  
  void mouseClick(){}
  
  void creerPatate(){
    int type = (int)random(10);
    if(type>4)
      type = 0;
    Patate test1 = new Patate(random(displayWidth/echelleTerre), 0, random(-3, 3), random(4, 7), random(0.025,0.1), type);
    test.add(test1);
  }
}

class JeuGeo implements Fenetre {
  
  PImage doigt;
  public JeuGeo() {
    parsec = 0.05;
    creerPatate();
    doigt = loadImage("RACKET-1-OMBRE.png");
  }
  
  void drow(){
    clear();
    background(255);
    translate(displayWidth/2, displayHeight/2);
    ellipse(0, 0, 2*rTerrenb*pow(10, rTerrepw-echelleGeopw), 2*rTerrenb*pow(10, rTerrepw-echelleGeopw));
    for(Patate i : test){
      image(i.img, i.position.x*pow(10, -echelleGeopw), i.position.y*pow(10, -echelleGeopw), (int)displayWidth/20, (int)displayWidth/14);
      i.mouvementGeo();
    }
    for(int i=test.size()-1; i>=0; i--)
      if(sqrt(pow(test.get(i).position.x,2)+pow(test.get(i).position.y,2))<rTerrenb*pow(10,rTerrepw)){
        test.remove(i);
        this.creerPatate();
      }
    if(mousePressed){
      image(doigt,mouseX-displayWidth/2 , mouseY-displayHeight/2, 100, 100);
      for(int i=test.size()-1; i>=0; i--){
        if(abs(test.get(i).position.y*pow(10,-echelleGeopw)-(mouseY-displayHeight/2))<70 && abs(test.get(i).position.x*pow(10,-echelleGeopw)-(mouseX-displayWidth/2))<50){
          test.remove(i);
        }
      }
    }
    if((int)random(50)==1)
      creerPatate();
  }
  
  void mousePress(){
    //creerPatate();
  }
  
  void mouseClick(){}
  
  void creerPatate(){
    int type = (int)random(10);
    if(type>4)
      type = 0;
    float angle = random(2*PI);//random(2*PI);
    PVector depart;
    Patate test1;
    depart = PVector.fromAngle(angle);
    depart.mult((rTerrenb) * pow(10,rTerrepw));
    PVector vitesse = PVector.fromAngle(angle+random(-PI/2,PI/2)).mult(random(12000,15000));
    test1 = new Patate(depart.x, depart.y, vitesse.x, vitesse.y, random(0.05,0.1), type);
    test.add(test1);
  }
}
