// Une interface qui permet notamment de séparer les fonctions draw(), mouseClick() etc. pour chaque affichage.
float parsec; // le nombre d'images par seconde
final int echelleTerre = 300; // pxl/m
final float echelleGeopw = 4.5; //(10^)pxl/m
int score, meilleur_score, vie, frequence, multiple;
boolean mlg;


static interface Fenetre {
  
  void drow();
  void mousePress();
  void mouseClick();
}


class Menu implements Fenetre {
  
  
  PImage jouer, boutique, parametre, m_score, quitter, instruct;
  public Menu() {
    jouer = loadImage("images/boutons/bouton-0.png"); //chargement des boutons du menu
    boutique = loadImage("images/boutons/bouton-1.png");
    parametre = loadImage("images/boutons/bouton-3.png");
    m_score = loadImage("images/boutons/bouton-2.png");
    quitter = loadImage("images/boutons/bouton-4.png");
    instruct = loadImage("images/boutons/bouton-5.png");
    musique_menu();
    musique.loop();

  }
  
  void drow(){
    background(180);
    imageMode(CENTER); //affichage des boutons du menu
    image(this.jouer,displayWidth/2, displayHeight/3);
    image(this.boutique,displayWidth/2, 2*displayHeight/3);
    image(this.parametre, displayWidth - 188/2, displayHeight-(displayHeight - 143/2));
    image(this.m_score, 188/2, displayHeight - 143/2);
    image(this.quitter, displayWidth - 188/2, displayHeight - 143/2);
    image(this.instruct, displayWidth/2, displayHeight - 140/2);
  }
  
  void mousePress(){}
  
  void mouseClick(){
    if ((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && (mouseY < displayHeight/3 + 131/2) && (mouseY > displayHeight/3 - 131/2)) //bouton jouer
      fenetre = new MenuJeu();
  }
}




class MenuJeu implements Fenetre {
 
  PImage b_classique, b_espace;
  
  public MenuJeu(){
  b_classique = loadImage("images/boutons/bouton-7.png"); //chargement des boutons
  b_espace = loadImage("images/boutons/bouton-8.png");
  }
  
  void drow(){
    imageMode(CENTER); //affichage des boutons
    image(this.b_classique,displayWidth/2, displayHeight/3);
    image(this.b_espace,displayWidth/2, 2*displayHeight/3);
  }
  
  void mousePress(){}
  
  void mouseClick(){
    if ((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && (mouseY < displayHeight/3 + 131/2) && (mouseY > displayHeight/3 - 131/2)){
      musique.stop();
      fenetre = new JeuTerre();
    }
    else if (((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && (mouseY < 2*displayHeight/3 + 131/2) && (mouseY > 2*displayHeight/3 - 131/2))){
      musique.stop();
      fenetre = new JeuGeo();
    }
  }
}




class JeuTerre implements Fenetre {
  
  PFont police;
  PImage doigt, fond_cuisine;
  public JeuTerre() {
    parsec = 80;
    creerPatate();
    imageMode(CENTER);
    fond_cuisine = loadImage("images/fonds/fond_cuisine.png");
    doigt = loadImage("images/raquettes/RACKET-1-OMBRE.png");
    //police = loadFont("French_Fries.tff");
    //textFont(police, 32);
    textSize(25);
    score = 0;
    vie = 5;
    frequence = 60;
    multiple = 1;
    mlg = false;
    fill(255);
    fond_cuisine.resize(displayWidth,displayHeight);
    musique_cuisine();
    musique.loop();
  }
  

  
  void drow(){
    clear();
    background(fond_cuisine);
    text("score: "+str(score), displayWidth/10, 50);
    text("vie: "+str(vie),9*displayWidth/10, 50);
    
    for(Patate i : test){
      translate(displayWidth-i.position.x*echelleTerre, displayHeight-i.position.y*echelleTerre);
      rotate(i.tourne);
      image(i.img, 0, 0, (int)displayWidth/10, (int)displayWidth/7);
      rotate(-i.tourne);
      translate(i.position.x*echelleTerre-displayWidth, i.position.y*echelleTerre-displayHeight);
      i.mouvementTerrestre();
    }
    for(int i=test.size()-1; i>=0; i--){
      if(test.get(i).position.y<-0.5){
        if(test.get(i).type!=1 && mlg==false)
          vie -= 1;        
        test.remove(i);
      }
    }
    
    if(mousePressed){
      image(doigt,mouseX, mouseY, 100, 100);
      for(int i=test.size()-1; i>=0; i--){
        if(abs(test.get(i).position.y*echelleTerre+(mouseY-displayHeight))<70 && abs(test.get(i).position.x*echelleTerre+(mouseX-displayWidth))<50){
          coupePatate(test.get(i));
          test.remove(i);
        }
      }
    }
    if(score >= 10)
      frequence = 40;
    if(score >= 50)
      frequence = 20;
    if (score >= 100)
      frequence = 10;
    if(mlg)
      frequence = (int) frequence/2;
      
    if((int)random(frequence)==1)
      creerPatate();
      
    if(vie <= 0){
      musique.stop();
      background(fond_cuisine);
      fenetre = new EcranScore();
    }
  }
  
  void mousePress(){}
  
  void mouseClick(){}
  
  void creerPatate(){
    int type = (int)random(10);
    if(type>4)
      type = 0;
    float tourne;
    if(type == 4){
      tourne = 0;
    }
    
    else{
      tourne = random(-PI/16, PI/16);
    }
    Patate test1 = new Patate(random(displayWidth/echelleTerre), 0, random(-3, 3), random(4, 7), random(0.025,0.1), type, tourne);
    test.add(test1);
  }
  
  void coupePatate(Patate coupe){
    score += 1*multiple;
    if(coupe.type == 1 && mlg==false){
      vie-=1;
      score-=1*multiple;
<<<<<<< HEAD
    }
    
    else if(coupe.type == 2){
     viscosite = 0.002;
     densite = 1;
    }
    
    else if(coupe.type == 3){
      multiple *= 2;
    }
   
    else if(coupe.type == 4){
=======
    }else if(coupe.type == 2){
      viscosite = 0.002002;
      densite = 1;
    }else if(coupe.type == 3){
      multiple *= 2;
    }else if(coupe.type == 4){
>>>>>>> 8b1fd7fe7b15ee3cad0865e301aa92750da20774
      mlg = true;
    }
  }
}




class JeuGeo implements Fenetre {
  
  PImage doigt, terre, fond;
  public JeuGeo() {
    textSize(25);
    parsec = 0.05;
    score = 0;
    vie = 5;
    frequence = 60;
    multiple = 1;
    doigt = loadImage("images/raquettes/RACKET-1-OMBRE.png");
    terre = loadImage("images/fonds/Terre.png");
    fond = loadImage("images/fonds/fond-geo.png");
    fond.resize(displayWidth,displayHeight);
    musique_space();
    musique.loop();
  }
  
  void drow(){
    clear();
    background(fond);
    text("score: "+str(score), displayWidth/10, 50);
    text("vie: "+str(vie),9*displayWidth/10, 50);
    translate(displayWidth/2, displayHeight/2);
    image(terre, 0, 0, 2*rTerrenb*pow(10, rTerrepw-echelleGeopw), 2*rTerrenb*pow(10, rTerrepw-echelleGeopw));
    for(Patate i : test){
      translate(i.position.x*pow(10,-echelleGeopw), i.position.y*pow(10,-echelleGeopw));
      rotate(i.tourne);
      image(i.img, 0, 0, (int)displayWidth/20, (int)displayWidth/14);
      rotate(-i.tourne);
      translate(-i.position.x*pow(10,-echelleGeopw), -i.position.y*pow(10,-echelleGeopw));
      i.mouvementGeo();
    }
    for(int i=test.size()-1; i>=0; i--)
      if(sqrt(pow(test.get(i).position.x,2)+pow(test.get(i).position.y,2))<rTerrenb*pow(10,rTerrepw)){
        test.remove(i);
        vie -= 1;
        this.creerPatate();
      }
    if(mousePressed){
      image(doigt,mouseX-displayWidth/2 , mouseY-displayHeight/2, 100, 100);
      for(int i=test.size()-1; i>=0; i--){
        if(abs(test.get(i).position.y*pow(10,-echelleGeopw)-(mouseY-displayHeight/2))<70 && abs(test.get(i).position.x*pow(10,-echelleGeopw)-(mouseX-displayWidth/2))<50){
          coupePatate(test.get(i));
          test.remove(i);
        }
      }
    }
    
     if(score >= 10)
      frequence = 40;
    if(score >= 50)
      frequence = 20;
    if (score >= 100)
      frequence = 10;
      
    if((int)random(frequence)==1)
      creerPatate();
      
    if(vie <= 0){
      musique.stop();
      background(fond);
      translate(-displayWidth/2, -displayHeight/2);
      fenetre = new EcranScore();
    }
    
  }
  
  void mousePress(){}
  
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
    float tourne;
    if(type == 4){
      tourne = 0;
    }else{
      tourne = random(-PI/16, PI/16);
    }
    test1 = new Patate(depart.x, depart.y, vitesse.x, vitesse.y, random(0.05,0.1), type, tourne);
    test.add(test1);
  }
  
  void coupePatate(Patate coupe){
    score += 1*multiple;
    if(coupe.type == 1 && mlg==false){
      vie-=1;
      score-=1*multiple;
    }
    
    else if(coupe.type == 2){
     viscosite = 0.002;
     densite = 1;
    }
    
    else if(coupe.type == 3){
      multiple *= 2;
    }
   
    else if(coupe.type == 4){
      mlg = true;
    }
  }
}





class EcranScore implements Fenetre{
  
  
  public EcranScore(){
    fill(255, 255, 0);
    textSize(50);
    text("Score: "+str(score), displayWidth/3, displayHeight/2);
    if(score>meilleur_score)
      meilleur_score = score;
  }
  
  void drow(){
  }
  
  void mousePress(){
    fenetre = new Menu();
  }
  
  void mouseClick() {}
  
}