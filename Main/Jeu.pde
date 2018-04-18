class JeuTerre implements Fenetre {
  
  PFont police;
  PImage doigt, fond_cuisine;
  int score, vie, frequence, multiple;
  boolean mlg;
  ArrayList<Patate> patates;
  public JeuTerre() {
    patates = new ArrayList<Patate>();
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
  }
  

  
  void drow(){
    clear();
    background(fond_cuisine);
    text("score: "+str(score), displayWidth/10, 50);
    text("vie: "+str(vie),9*displayWidth/10, 50);
    
    for(Patate i : patates){
      translate(displayWidth-i.position.x*echelleTerre, displayHeight-i.position.y*echelleTerre);
      rotate(i.tourne);
      image(i.img, 0, 0, (int)displayWidth/10, (int)displayWidth/7);
      rotate(-i.tourne);
      translate(i.position.x*echelleTerre-displayWidth, i.position.y*echelleTerre-displayHeight);
      i.mouvementTerrestre();
    }
    for(int i=patates.size()-1; i>=0; i--){
      if(patates.get(i).position.y<-0.5){
        if(patates.get(i).type!=1 && mlg==false)
          vie -= 1;        
        patates.remove(i);
      }
    }
    
    if(mousePressed){
      image(doigt,mouseX, mouseY, 100, 100);
      for(int i=patates.size()-1; i>=0; i--){
        if(abs(patates.get(i).position.y*echelleTerre+(mouseY-displayHeight))<70 && abs(patates.get(i).position.x*echelleTerre+(mouseX-displayWidth))<50){
          coupePatate(patates.get(i));
          patates.remove(i);
        }
      }
    }
    if(score >= 10)
      frequence = 40;
    else if(score >= 50)
      frequence = 20;
    else if (score >= 100)
      frequence = 10;
    else if (score < 0)
      vie = 0;
    else
      frequence = 80;
    if(mlg)
      frequence = (int) frequence/2;
      
    if((int)random(frequence)==1)
      creerPatate();
      
    if(vie <= 0){
      musique.stop();
      background(fond_cuisine);
      fenetre = new EcranScore(score);
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
    patates.add(test1);
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




class JeuGeo implements Fenetre {
  
  PImage doigt, terre, fond;
  int score, vie, frequence, multiple;
  boolean mlg;
  ArrayList<Patate> patates;
  public JeuGeo() {
    patates = new ArrayList<Patate>();
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
  }
  
  void drow(){
    clear();
    background(fond);
    text("score: "+str(score), displayWidth/10, 50);
    text("vie: "+str(vie),9*displayWidth/10, 50);
    translate(displayWidth/2, displayHeight/2);
    image(terre, 0, 0, 2*rTerrenb*pow(10, rTerrepw-echelleGeopw), 2*rTerrenb*pow(10, rTerrepw-echelleGeopw));
    for(Patate i : patates){
      translate(i.position.x*pow(10,-echelleGeopw), i.position.y*pow(10,-echelleGeopw));
      rotate(i.tourne);
      image(i.img, 0, 0, (int)displayWidth/20, (int)displayWidth/14);
      rotate(-i.tourne);
      translate(-i.position.x*pow(10,-echelleGeopw), -i.position.y*pow(10,-echelleGeopw));
      i.mouvementGeo();
    }
    for(int i=patates.size()-1; i>=0; i--)
      if(sqrt(pow(patates.get(i).position.x,2)+pow(patates.get(i).position.y,2))<rTerrenb*pow(10,rTerrepw)){
        patates.remove(i);
        vie -= 1;
        this.creerPatate();
      }
    if(mousePressed){
      image(doigt,mouseX-displayWidth/2 , mouseY-displayHeight/2, 100, 100);
      for(int i=patates.size()-1; i>=0; i--){
        if(abs(patates.get(i).position.y*pow(10,-echelleGeopw)-(mouseY-displayHeight/2))<70 && abs(patates.get(i).position.x*pow(10,-echelleGeopw)-(mouseX-displayWidth/2))<50){
          coupePatate(patates.get(i));
          patates.remove(i);
        }
      }
    }
    
    if(score >= 10)
      frequence = 40;
    else if(score >= 50)
      frequence = 20;
    else if (score >= 100)
      frequence = 10;
    else if (score < 0)
      vie = 0;
    else
      frequence = 80;
      
    if((int)random(frequence)==1)
      creerPatate();
      
    if(vie <= 0){
      musique.stop();
      background(fond);
      translate(-displayWidth/2, -displayHeight/2);
      fenetre = new EcranScore(score);
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
    patates.add(test1);
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
  
  
  public EcranScore(int score){
    fill(255, 255, 0);
    textSize(50);
    if (score < 0)
      text("Tricheur !", displayWidth/3, displayHeight/2);
    else
      text("Score: "+str(score), displayWidth/3, displayHeight/2);
    meilleurs_scores.append(score);
    meilleurs_scores.sortReverse();
    meilleurs_scores.remove(meilleurs_scores.size()-1);
  }
  
  void drow(){
  }
  
  void mousePress(){
    musique_menu();
    fenetre = new Menu();
  }
  
  void mouseClick() {}
  
}