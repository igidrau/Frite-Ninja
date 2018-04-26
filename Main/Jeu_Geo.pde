class JeuGeo implements Fenetre {
  PImage doigt, terre, fond;
  int score, vie, frequence, multiple, tMLG, tAqua, tDouble;
  boolean mlg;
  ArrayList<Patate> patates;
  
  public JeuGeo() {
    tMLG = tAqua = tDouble = 20*framerate;
    patates = new ArrayList<Patate>();
    textSize(25);
    parsec = 0.05;
    score = 0;
    vie = 5;
    frequence = 60;
    multiple = 1;
    doigt = loadImage("images/raquettes/RACKET-"+str(racket_activ+1)+"-OMBRE.png");
    terre = loadImage("images/fonds/Terre.png");
    fond = loadImage("images/fonds/fond-geo.png");
    fond.resize(displayWidth,displayHeight);
    musique_space();
  }
  
  void drow(){
    clear();
    background(fond);
    fill(255,255,0);
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
    
    if(tMLG<10*framerate){
      tMLG++;
    }else if(tMLG==10*framerate){
      musique.stop();
      musique_cuisine();
      mlg = false;
      tMLG++;
    }
    if(tDouble<10*framerate){
      tDouble++;
    }else if(tDouble==10*framerate){
      multiple = 1;
      tDouble++;
    }
    if(tAqua<10*framerate){
      tAqua++;
    }else if(tAqua==10*framerate){
      densite = 0;
      viscosite = 0.000017;
      tAqua++;
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
    if(coupe.type == 0){
     soncoupe1.play();
    }else if(coupe.type == 1 && mlg==false){
      vie-=1;
      score-=1*multiple;
    }
    
    else if(coupe.type == 2){
     viscosite = 0.002;
     densite = 1;
     tAqua = 0;
    }
    
    else if(coupe.type == 3){
      multiple *= 2;
      tDouble = 0;
    }
   
    else if(coupe.type == 4){
      tMLG = 0;
      if(!mlg){
        musique.stop();
        musique_mlg();
        mlg = true;
      }
    }
  }
}