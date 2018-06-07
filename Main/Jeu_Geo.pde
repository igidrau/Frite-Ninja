class JeuGeo implements Fenetre {
  PImage doigt, terre, fond, fondaqua, pause;
  int vie, tMLG, tDouble, temps;
  float score, frequence, multiple, xArgent, xScore;
  boolean mlg, commence;
  ArrayList<Patate> patates;
  ArrayList<Frite> frites;
  XML[] raquettes;
  
  public JeuGeo(ArrayList<Patate> patates, ArrayList<Frite> frites, float score, int vie, int temps, boolean commence, boolean mlg, int tMLG, int tDouble) {
    raquettes = loadXML("data/raquettes.data").getChildren("raquette");
    this.patates =  new ArrayList<Patate>(patates);
    this.frites = new ArrayList<Frite>(frites);
    this.score = score;
    this.vie = vie;
    this.temps = temps;
    this.commence = commence;
    this.tMLG = tMLG;
    this.tDouble = tDouble;
    this.mlg = mlg;
    textSize(25);
    xArgent = float(raquettes[racket_activ].getString("argent"));
    xScore = float(raquettes[racket_activ].getString("score"));
    multiple = 1 * xScore;
    doigt = loadImage("images/raquettes/RACKET-"+str(racket_activ+1)+"-OMBRE.png");
    terre = loadImage("images/fonds/Terre.png");
    pause = loadImage("images/boutons/bouton-6.png");
    fond = loadImage("images/fonds/fond-geo.png");
    fond.resize(displayWidth,displayHeight);
    if(this.commence == false){
      musique_space();
      parsec = 0.0027;
      frequence = 60;}
    musique.amp(1);
  }

  void drow(){
    this.temps++;
    clear();
    background(fond);
    fill(255, 255, 0);
    text("score: "+str(int(score)), 50, 50);
    text("vie: "+str(vie), 50, 100);
    if(multiple>xScore)
      text("x" + str(multiple/xScore), 2*displayWidth/10, 50);
      
    translate(displayWidth/2, displayHeight/2);
    image(terre, 0, 0, 2*rTerrenb*pow(10, rTerrepw-echelleGeopw), 2*rTerrenb*pow(10, rTerrepw-echelleGeopw));
    
      for(int i=this.frites.size()-1; i>=0; i--){
        translate(this.frites.get(i).position.x*pow(10,-echelleGeopw), this.frites.get(i).position.y*pow(10,-echelleGeopw));
        rotate(this.frites.get(i).tourne);
        image(this.frites.get(i).img, 0, 0);
        rotate(-this.frites.get(i).tourne);
        translate(-this.frites.get(i).position.x*pow(10,-echelleGeopw), -this.frites.get(i).position.y*pow(10,-echelleGeopw));
        this.frites.get(i).mouvementGeo();
        if(sqrt(pow(this.frites.get(i).position.x,2)+pow(this.frites.get(i).position.y,2))<rTerrenb*pow(10,rTerrepw)){
          this.frites.remove(i);
        }
      }
      
      for(int i=this.patates.size()-1; i>=0; i--){
        translate(this.patates.get(i).position.x*pow(10,-echelleGeopw), this.patates.get(i).position.y*pow(10,-echelleGeopw));
        rotate(this.patates.get(i).tourne);
        image(this.patates.get(i).img, 0, 0);
        rotate(-this.patates.get(i).tourne);
        translate(-this.patates.get(i).position.x*pow(10,-echelleGeopw), -this.patates.get(i).position.y*pow(10,-echelleGeopw));
        this.patates.get(i).mouvementGeo();
        if(sqrt(pow(this.patates.get(i).position.x,2)+pow(this.patates.get(i).position.y,2))<rTerrenb*pow(10,rTerrepw)){
          if(this.patates.get(i).type!=1 && !this.mlg) 
            this.vie -= 1;
          this.patates.remove(i);
        }
      }
    
    translate(-displayWidth/2, -displayHeight/2);
    image(this.pause, displayWidth - 188/2, displayHeight-(displayHeight - 143/2));
    
    if(mousePressed){
      image(doigt,mouseX , mouseY, displayWidth/25, displayWidth/25);
      for(int i=this.patates.size()-1; i>=0; i--){
        if(abs(this.patates.get(i).position.y*pow(10,-echelleGeopw)-(mouseY-displayHeight/2))<70 && abs(this.patates.get(i).position.x*pow(10,-echelleGeopw)-(mouseX-displayWidth/2))<50){
          coupePatate(this.patates.get(i));
          this.patates.remove(i);
        }
      }
    }
    
    frequence = 52*exp(-score/400)+8; 
    if(this.mlg)
      frequence = (int) frequence/5;
      
      
    if((int)random(frequence)==1 && this.patates.size()<= 10)
      creerPatate();
      
    if(this.vie <= 0){
      musique.amp(1);
      musique.stop();
      if(this.mlg)
        musique_mlg.stop();
      background(fond);
      fenetre = new EcranScore(this.score, this.temps, 2, xArgent);
    }
    
    if(this.tMLG<8*framerate){
      this.tMLG++;
    }else if(this.tMLG==8*framerate){
      musique.amp(1);
      this.mlg = false;
      this.tMLG++;
    }
    if(this.tDouble<10*framerate){
      this.tDouble++;
    }else if(this.tDouble==10*framerate){
      multiple = xScore;
      this.tDouble++;
    }
  }
  
  void mousePress(){}
  
  void mouseClick(){
    if (mouseX > displayWidth - 188 && mouseY < 143){
      fenetre = new MenuPause(this.patates, this.frites, this.score, this.vie, this.temps, this.mlg, this.tMLG, this.tDouble, -12000);}
  }
  
  void creerFrite(Patate patate){
    if(patate.type==1){
      potato = true;}
    else{
      potato = false;}
    Frite frite = new Frite(random(patate.position.x-5000, patate.position.x+5000),random(patate.position.y-5000, patate.position.y+5000), random(patate.v.x-5000, patate.v.x+5000), random(patate.v.y-5000, patate.v.y+5000), patate.taille/6, potato, patate.rotation);
    frite.img.resize(0, patate.img.height-20);
    this.frites.add(frite);
  }  
  
  
  void creerPatate(){
    
    int type = (int)random(25);
    if(type>4 || type==2 || type==1 && this.mlg)
      type = 0;
    if(type == 4 && this.mlg)
      type = 0;
      
    float angle = random(2*PI);//random(2*PI);
    Patate test1;
    PVector depart = PVector.fromAngle(angle).mult((rTerrenb) * pow(10,rTerrepw));
    PVector vitesse = PVector.fromAngle(angle+random(-PI/2+0.1,PI/2-0.1)).mult(random(40000,50000));
    float tourne;
    if(type == 4){
      tourne = 0;
    }else{
      tourne = random(-PI/200, PI/200);
    }
    test1 = new Patate(depart.x, depart.y, vitesse.x, vitesse.y, random(0.05,0.1), type, tourne);
    this.patates.add(test1);
    test1.img.resize((int)displayWidth/20, (int)displayWidth/14);
  }
  
  void coupePatate(Patate coupe){
    for(int i=0; i<6; i++){
      creerFrite(coupe);}
    this.score += 1*multiple;
    if(coupe.type == 0){
      aleat = (int) random(1,2);
      son_coupe();
    }else if(coupe.type == 1 && this.mlg==false){
      this.vie-=1;
      this.score-=1*multiple;
      sonrate.play();
    }
    
    else if(coupe.type == 3){
      multiple *= 2;
      this.tDouble = 0;
      sonx2.play();
    }
   
    else if(coupe.type == 4){
      musique.amp(0.5);
      this.tMLG = 0;
      if(!this.mlg){
        musique_mlg();
        this.mlg = true;
      }
    }
  }
  void keyPress(){}
}