class JeuTerre implements Fenetre {
  PFont police;
  PImage doigt, fond;
  int score, vie, frequence, multiple, tMLG, tAqua, tDouble;
  boolean mlg;
  ArrayList<Patate> patates;
  
  public JeuTerre() {
    tMLG = tAqua = tDouble = 20*framerate;
    patates = new ArrayList<Patate>();
    textSize(25);
    parsec = 80;
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
    imageMode(CENTER);
    //police = loadFont("French_Fries.tff");
    //textFont(police, 32);
    fill(255);
    musique_cuisine();
  }
  

  
  void drow(){
    clear();
    background(fond);
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
      background(fond);
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
    int type = (int)random(15);
    if(type>4 || mlg && type==1)            //La majorité des patates générées sont des patates normales
      type = 0;
      
    float tourne;
    if(type == 4){                          //La patate MLG ne tourne pas
      tourne = 0;
    }else{
      tourne = random(-PI/16, PI/16);
    }
    
    Patate test1 = new Patate(random(displayWidth/echelleTerre), 0, random(-3, 3), random(4, 7), random(0.025,0.1), type, tourne);
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



class EcranScore implements Fenetre{
  public EcranScore(int score){
    argent += score;
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
  
  void drow(){}
  
  void mousePress(){}
  
  void mouseClick() {
    musique_menu();
    fenetre = new Menu();
  }
  
}