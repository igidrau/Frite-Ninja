ArrayList<Boolean> raquettesAchetees;
int racket_activ;


class MenuBoutique implements Fenetre {
  
  PImage racket_visuel, racket_bad,racket_ten,racket_laser,racket_ping,racket_gold;
  PImage b_retour, b_achat, b_equip, b_active, fond;
  int racket_visu = racket_activ;
  XML[] raquettes;
  
  public MenuBoutique() {
    fond = loadImage("images/fonds/fond-menu.png");
    raquettes = loadXML("data/raquettes.data").getChildren("raquette");
    racket_visuel = loadImage(raquettes[racket_visu].getString("img"));
    racket_bad = loadImage(raquettes[0].getString("ombre"));//"images/raquettes/RACKET-1-OMBRE.png");
    racket_ten = loadImage(raquettes[1].getString("ombre"));
    racket_laser = loadImage(raquettes[2].getString("ombre"));
    racket_ping = loadImage(raquettes[3].getString("ombre"));
    racket_gold = loadImage(raquettes[4].getString("ombre"));
    b_retour = loadImage("images/boutons/bouton-9.png");
    b_achat = loadImage("images/boutons/bouton-10.png");
    b_equip = loadImage("images/boutons/bouton-11.png");
    b_active = loadImage("images/boutons/equipee.png");
    fond.resize(displayWidth, displayHeight);
    racket_bad.resize(100,0);
    racket_ten.resize(100,0);
    racket_laser.resize(100,0);
    racket_ping.resize(100,0);
    racket_gold.resize(100,0);
    rectMode(CENTER);
    imageMode(CENTER);
    noStroke();
  }

  void drow() {
    background(fond);
    textSize(50);
    fill(255,255,0);
    text(str(argent), 60,60);
    fill(100);
    image(b_retour,displayWidth - 188/2, displayHeight - 143/2);
    rect(displayWidth/4,displayHeight/2, racket_visuel.width+40,racket_visuel.height+40);
    image(racket_visuel, displayWidth/4 ,displayHeight/2);
    textSize(40);
    fill(255);
    
    if(raquettesAchetees.get(racket_visu)){
      if(racket_activ == racket_visu)
        image(b_active, 2*displayWidth/5+145, displayHeight/5+70);
      else
        image(b_equip, 2*displayWidth/5+145, displayHeight/5+70);
    }else{
      image(b_achat, 2*displayWidth/5+145, displayHeight/5+70);
      fill(#64ff64);
      text(raquettes[racket_visu].getString("prix")+" €", 2*displayWidth/5+295, displayHeight/5+90);
    }
    text(raquettes[racket_visu].getContent(), 2*displayWidth/5,displayHeight/5);
    
    if(racket_visu == 0)              //charge icône des raquettes pour menu item
      fill(#ffc100);
    else if(raquettesAchetees.get(0))
      fill(#a3a3a3);
    else
      fill(#494949);
    rect(displayWidth/2, 3*displayHeight/5, 110, 110);    
    image(racket_bad,displayWidth/2, 3*displayHeight/5);
    
    if(racket_visu == 1)
      fill(#ffc100);
    else if(raquettesAchetees.get(1))
      fill(#a3a3a3);
    else
      fill(#494949);
    rect(4*displayWidth/6, 3*displayHeight/5, 110, 110);
    image(racket_ten,4*displayWidth/6, 3*displayHeight/5);
    
    if(racket_visu == 2)
      fill(#ffc100);
    else if(raquettesAchetees.get(2))
      fill(#a3a3a3);
    else
      fill(#494949);
    rect(5*displayWidth/6, 3*displayHeight/5, 110, 110);
    image(racket_laser,5*displayWidth/6, 3*displayHeight/5);
    
    if(racket_visu == 3)
      fill(#ffc100);
    else if(raquettesAchetees.get(3))
      fill(#a3a3a3);
    else
      fill(#494949);
    rect(3.5*displayWidth/6, 4*displayHeight/5, 110, 110);
    image(racket_ping,3.5*displayWidth/6, 4*displayHeight/5);
    
    if(racket_visu == 4)
      fill(#ffc100);
    else if(raquettesAchetees.get(4))
      fill(#a3a3a3);
    else
      fill(#494949);
    rect(4.5*displayWidth/6, 4*displayHeight/5, 110, 110);
    image(racket_gold,4.5*displayWidth/6, 4*displayHeight/5);

  }
  
  
  void mousePress(){
    if(mouseX>displayWidth/2-55 && mouseX<displayWidth/2+55 && mouseY>3*displayHeight/5-55 && mouseY<3*displayHeight/5+55)    //si bouton raquette badminton est cliqué
        racket_visu = 0;
    if(mouseX>4*displayWidth/6-55 && mouseX<4*displayWidth/6+55 && mouseY>3*displayHeight/5-55 && mouseY<3*displayHeight/5+55)    //si bouton raquette tennis est cliqué
        racket_visu = 1;
    if(mouseX>5*displayWidth/6-55 && mouseX<5*displayWidth/6+55 && mouseY>3*displayHeight/5-55 && mouseY<3*displayHeight/5+55)    //si bouton raquette laser est cliqué
        racket_visu = 2;
    if(mouseX>3.5*displayWidth/6-55 && mouseX<3.5*displayWidth/6+55 && mouseY>4*displayHeight/5-55 && mouseY<4*displayHeight/5+55)    //si bouton raquette ping-pong est cliqué
        racket_visu = 3;
    if(mouseX>4.5*displayWidth/6-55 && mouseX<4.5*displayWidth/6+55 && mouseY>4*displayHeight/5-55 && mouseY<4*displayHeight/5+55)    //si bouton raquette d'or est cliqué
        racket_visu = 4;
    racket_visuel = loadImage(raquettes[racket_visu].getString("img"));
  }
  
  void mouseClick(){
    if(mouseX > 2*displayWidth/5 && mouseX < 2*displayWidth/5+290 && mouseY > displayHeight/5+39 && mouseY < displayHeight/5+102){ //Bouton acheter/equiper/equipee
      
      if(raquettesAchetees.get(racket_visu))
        racket_activ = racket_visu;
      else if(argent>=int(raquettes[racket_visu].getString("prix"))){
        argent-=int(raquettes[racket_visu].getString("prix"));
        raquettesAchetees.set(racket_visu, true);
        sonachat.play();
      } else
        sonerreur.play();
    }
     
    else if (mouseX > displayWidth-188 && mouseY > displayHeight-143)      //bouton retour
      fenetre = new Menu();
    
  }
  
}