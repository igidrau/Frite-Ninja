class JeuTerre implements Fenetre {
  PImage doigt, fond, fondaqua, pause;
  int vie, tMLG, tAqua, tDouble, temps;
  float score, frequence, t_depart, xArgent, xScore, multiple;
  boolean mlg, commence;
  ArrayList<Patate> patates;
  ArrayList<Frite> frites;
  XML[] raquettes;
  
  public JeuTerre(ArrayList<Patate> patates, ArrayList<Frite> frites, float score, int vie, int temps, boolean commence, boolean mlg, int tMLG, int tDouble, int tAqua) {
    raquettes = loadXML("data/raquettes.data").getChildren("raquette");
    this.patates =  new ArrayList<Patate>(patates);
    this.frites = new ArrayList<Frite>(frites);
    this.score = score;
    this.vie = vie;
    this.temps = temps;
    this.commence = commence;
    this.tMLG = tMLG;
    this.tDouble = tDouble;
    this.tAqua = tAqua;
    this.mlg = mlg;
    t_depart = millis();
    textSize(25);
    xArgent = float(raquettes[racket_activ].getString("argent"));
    xScore = float(raquettes[racket_activ].getString("score"));
    multiple = 1 * xScore;
    pause = loadImage("images/boutons/bouton-6.png");
    doigt = loadImage("images/raquettes/RACKET-"+str(racket_activ+1)+"-OMBRE.png");
    fond = loadImage("images/fonds/fond_cuisine.png");
    fond.resize(displayWidth, displayHeight);
    fondaqua = loadImage("images/fonds/fond_cuisine-aqua.png");
    fondaqua.resize(displayWidth,displayHeight);
    imageMode(CENTER);
    if(this.commence == false){
      sonstart.play();                  //joue le son de début de partie quand elle vient d'être lancée
      parsec = 2.7;
      frequence = 60;
      viscosite =  0.000017;
      densite = 0;}
    musique.amp(1);
  }
  

  
  void drow(){
    this.temps++;
    clear();
    if(tAqua<8*framerate)
      background(fondaqua);
    else
      background(fond);
    fill(255);
    text("score: "+str(int(this.score)), 50, 50);
    text("vie: "+str(vie),50, 100);

    if(millis() >= t_depart+3900 && millis() <= t_depart+3931 && this.commence == false){
      musique_cuisine();                                                                      //joue la musique de la partie une fois que le son d'intro est terminé
      creerPatate();
    }
    
    else if(millis() >= t_depart + 3694 || this.commence){    
    for(Frite i : this.frites){
      translate(displayWidth-i.position.x*echelleTerre, displayHeight-i.position.y*echelleTerre);
      rotate(i.tourne);
      image(i.img, 0, 0);
      rotate(-i.tourne);
      translate(i.position.x*echelleTerre-displayWidth, i.position.y*echelleTerre-displayHeight);
      i.mouvementTerrestre();
    }
    for(int i=this.frites.size()-1; i>=0; i--){
      if(this.frites.get(i).position.y<-0.5){      
        this.frites.remove(i);
      }
    }
    

    for(Patate i : this.patates){
      translate(displayWidth-i.position.x*echelleTerre, displayHeight-i.position.y*echelleTerre);
      rotate(i.tourne);
      image(i.img, 0, 0, (int)displayWidth/10, (int)displayWidth/7);
      rotate(-i.tourne);
      translate(i.position.x*echelleTerre-displayWidth, i.position.y*echelleTerre-displayHeight);
      i.mouvementTerrestre();
    }
    for(int i=this.patates.size()-1; i>=0; i--){
      if(this.patates.get(i).position.y<-0.5){
        if(this.patates.get(i).type!=1 && this.mlg==false)
          this.vie -= 1;
        this.patates.remove(i);
      }
    }
    
    image(pause, displayWidth - 188/2, displayHeight-(displayHeight - 143/2));
    
    
    if(mousePressed){
      image(doigt,mouseX, mouseY, displayWidth/17, displayWidth/17);
      for(int i=this.patates.size()-1; i>=0; i--){
        if(abs(this.patates.get(i).position.y*echelleTerre+(mouseY-displayHeight))<70 && abs(this.patates.get(i).position.x*echelleTerre+(mouseX-displayWidth))<50){
          coupePatate(this.patates.get(i));
          this.patates.remove(i);
        }
      }
    }
    
    
    frequence = 52*exp(-score/400)+8;
    
    if(this.mlg){
      frequence = frequence/5;}
      
    if((int)random(frequence)==1 && this.patates.size() <= 10)
      creerPatate();
    
    
    if(this.tMLG<8*framerate){
      this.tMLG++;
    }else if(this.tMLG==8*framerate){
      musique.amp(1);
      this.mlg = false;
      this.tMLG++;
    }
    
    if(this.tDouble<10*framerate){
      this.tDouble++;
      fill(255,255,0);
      text("x"+str(int(multiple/xScore)), 200, 50);
    }else if(this.tDouble==10*framerate){
      multiple = xScore;
      this.tDouble++;
    }
    if(this.tAqua<8*framerate){
      musique.rate(0.8);
      this.tAqua++;
    }else if(this.tAqua==8*framerate){
      musique.rate(1);
      densite = 0;
      viscosite = 0.000017;
      this.tAqua++;
    }
    
    if(this.vie <= 0){
      musique.amp(1);
      musique.stop();
      background(fond);
      fenetre = new EcranScore(this.score, this.temps, 1, xArgent);
    }
    }
    else{
    if(mousePressed)
      image(doigt,mouseX, mouseY, displayWidth/17, displayWidth/17);}
  }
  
  void mousePress(){}
  
  
  void mouseClick(){
    if (mouseX > displayWidth - 188 && mouseY < 143 && millis() >= t_depart + 4200){
      fenetre = new MenuPause(this.patates, this.frites, this.score, this.vie, this.temps, this.mlg, this.tMLG, this.tDouble, this.tAqua);}
  }
  
  
  void creerFrite(Patate patate){

    if(patate.type==1){
      potato = true;}
    else{
      potato = false;}
    Frite frite = new Frite(random(patate.position.x-0.1, patate.position.x+0.1),random(patate.position.y-0.1, patate.position.y+0.1), random(patate.v.x-1, patate.v.x+1), random(patate.v.y-1, patate.v.y+1), patate.taille/6, potato, patate.rotation);
    frite.img.resize(0, patate.img.height-20);
    this.frites.add(frite);
  }
  
  
  
  void creerPatate(){
    int type = (int)random(30);
    if(type>4 && type<25 || this.mlg && type==1 || type>=25 && this.mlg)            //La majorité des patates générées sont des patates normales
      type = 0;
    if(type>=25 && this.mlg==false)
      type = 1;
    if(type == 4 && this.mlg)
      type = 0;
      
    float tourne;
    if(type == 4){                          //La patate MLG ne tourne pas
      tourne = 0;
    }else{
      tourne = random(-2*PI, 2*PI);
    }
    
    Patate test1 = new Patate(random(displayWidth/echelleTerre), 0, random(-3, 3), random(4, 7), random(0.025,0.1), type, tourne);
    this.patates.add(test1);
  }
  
  
  
  void coupePatate(Patate coupe){
    for(int i=0; i<6; i++){
      creerFrite(coupe);}
    this.score += 1*multiple;
    if(coupe.type == 0){
      aleat = (int) random(1,2.99);
      son_coupe();
    }else if(coupe.type == 1 && this.mlg==false){
      this.vie-=1;
      this.score-=1*multiple;
      sonrate.play();
    }
    
    else if(coupe.type == 2){
      soneau.play();
      viscosite = 0.002;
      densite = 1;
      this.tAqua = 0;
    }
    
    else if(coupe.type == 3){
      multiple *= 2;
      this.tDouble = 0;
      sonx2.play();
    }
   
    else if(coupe.type == 4 && this.mlg == false){
      musique.amp(0.5);
      this.tMLG = 0;
      musique_mlg();
      this.mlg = true;
    }
  }
}



class EcranScore implements Fenetre{
  
  public EcranScore(float score, float temps, int mode, float xArgent){
    fill(255, 255, 0);
    textSize(60);
    if (score < 0)
      text("Tricheur !", displayWidth/3, displayHeight/2);
    else
      text("Score: "+str(int(score)), displayWidth/3, displayHeight/2);
    argent += score/temps*25000*xArgent;
    argent_total += score/temps*25000*xArgent;
    if(mode == 1){
      meilleurs_scoresT.append(int(score));
      meilleurs_scoresT.sortReverse();
      meilleurs_scoresT.remove(meilleurs_scoresT.size()-1);
    }else if(mode==2){
      meilleurs_scoresG.append(int(score));
      meilleurs_scoresG.sortReverse();
      meilleurs_scoresG.remove(meilleurs_scoresT.size()-1);
    }
    defaite();
  }
  
  void drow(){}
  
  void mousePress(){}
  
  void mouseClick() {
    sauvegarde();
    musique_menu();
    sad.stop();
    fenetre = new Menu();
  }
  
}