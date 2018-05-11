class JeuTerre implements Fenetre {
  PImage doigt, fond, fondaqua;
  int score, vie, frequence, multiple, tMLG, tAqua, tDouble;
  float t_depart, t_fin;
  boolean mlg;
  ArrayList<Patate> patates;
  ArrayList<Frite> frites;
  
  public JeuTerre() {
    t_depart = millis();
    tMLG = tAqua = tDouble = 20*framerate;
    patates = new ArrayList<Patate>();
    frites = new ArrayList<Frite>();
    textSize(25);
    parsec = 2.7;
    score = 0;
    vie = 5;
    frequence = 60;
    multiple = 1;
    viscosite =  0.000017;
    densite = 0;
    mlg = false;
    doigt = loadImage("images/raquettes/RACKET-"+str(racket_activ+1)+"-OMBRE.png");
    fond = loadImage("images/fonds/fond_cuisine.png");
    fond.resize(displayWidth, displayHeight);
    fondaqua = loadImage("images/fonds/fond_cuisine-aqua.png");
    fondaqua.resize(displayWidth,displayHeight);
    imageMode(CENTER);
    sonstart.play();
  }
  

  
  void drow(){
    clear();
    if(tAqua<10*framerate)
      background(fondaqua);
    else
      background(fond);
    fill(255);
    text("score: "+str(score), 50, 50);
    text("vie: "+str(vie),9*displayWidth/10, 50);

    if(millis() >= t_depart+4249 && millis() <= t_depart+4280){
      musique_cuisine();
      creerPatate();
    }
    
    else if(millis() >= t_depart + 3694){    
    for(Frite i : frites){
      translate(displayWidth-i.position.x*echelleTerre, displayHeight-i.position.y*echelleTerre);
      rotate(i.tourne);
      i.img.resize(0, displayHeight/5);
      image(i.img, 0, 0);
      rotate(-i.tourne);
      translate(i.position.x*echelleTerre-displayWidth, i.position.y*echelleTerre-displayHeight);
      i.mouvementTerrestre();
    }
    for(int i=frites.size()-1; i>=0; i--){
      if(frites.get(i).position.y<-0.5){      
        frites.remove(i);
      }
    }
    

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
      frequence = (int) frequence/5;
      
    if((int)random(frequence)==1)
      creerPatate();
      
    if(vie <= 0){
      t_fin = millis()-t_depart-3694;
      musique.stop();
      background(fond);
      argent += t_fin*score/5000;
      if(argent>99999)
        argent = 99999;
      fenetre = new EcranScore(score);
    }
    
    if(tMLG<10*framerate){
      tMLG++;
    }else if(tMLG==10*framerate){
      mlg = false;
      tMLG++;
    }
    
    if(tDouble<10*framerate){
      tDouble++;
      fill(255,255,0);
      text("x"+str(multiple), 200, 50);
    }else if(tDouble==10*framerate){
      multiple = 1;
      tDouble++;
    }
    if(tAqua<10*framerate){
      musique.rate(0.8);
      tAqua++;
    }else if(tAqua==10*framerate){
      musique.rate(1);
      densite = 0;
      viscosite = 0.000017;
      tAqua++;
    }
    }
    else{
    if(mousePressed)
      image(doigt,mouseX, mouseY, 100, 100);}
  }
  
  void mousePress(){}
  
  void mouseClick(){}
  
  void creerPatate(){
    int type = (int)random(30);
    if(type>4 || mlg && type==1)            //La majorité des patates générées sont des patates normales
      type = 0;
      
    float tourne;
    if(type == 4){                          //La patate MLG ne tourne pas
      tourne = 0;
    }else{
      tourne = random(-2*PI, 2*PI);
    }
    
    Patate test1 = new Patate(random(displayWidth/echelleTerre), 0, random(-3, 3), random(4, 7), random(0.025,0.1), type, tourne);
    patates.add(test1);
  }
  
  
  void creerFrite(Patate patate){
    Frite frite = new Frite(random(patate.position.x-0.1, patate.position.x+0.1),random(patate.position.y-0.1, patate.position.y+0.1), random(patate.v.x-0.1, patate.v.x+0.1), random(patate.v.y-0.1, patate.v.y+0.1), random(patate.taille-0.25,patate.taille+0.25), int(random(0, 5.99)), patate.rotation);
    frites.add(frite);
  }
  
  void coupePatate(Patate coupe){
    creerFrite(coupe);
    creerFrite(coupe);
    creerFrite(coupe);
    score += 1*multiple;
    if(coupe.type == 0){
      aleat = (int) random(1,2.99);
      son_coupe();
    }else if(coupe.type == 1 && mlg==false){
      vie-=1;
      score-=1*multiple;
      sonrate.play();
    }
    
    else if(coupe.type == 2){
      soneau.play();
      viscosite = 0.002;
      densite = 1;
      tAqua = 0;
    }
    
    else if(coupe.type == 3){
      multiple *= 2;
      tDouble = 0;
      sonx2.play();
    }
   
    else if(coupe.type == 4 && mlg == false){
      tMLG = 0;
      musique_mlg();
      mlg = true;
    }
  }
}



class EcranScore implements Fenetre{
  public EcranScore(int score){
    fill(255, 255, 0);
    textSize(60);
    if (score < 0)
      text("Tricheur !", displayWidth/3, displayHeight/2);
    else
      text("Score: "+str(score), displayWidth/3, displayHeight/2);
    meilleurs_scores.append(score);
    meilleurs_scores.sortReverse();
    meilleurs_scores.remove(meilleurs_scores.size()-1);
  }
  
  void drow(){}
  
  void mousePress(){}
  
  void mouseClick() {
    sauvegarde();
    musique_menu();
    fenetre = new Menu();
  }
  
}