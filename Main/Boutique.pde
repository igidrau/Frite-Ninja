ArrayList<Boolean> raquettesAchetees;
int racket_activ = 0;


class MenuBoutique implements Fenetre {
  
  PImage racket_active, racket_bad,racket_ten,racket_laser,racket_ping,racket_gold;
  int racket_visu = 1;
  
  public MenuBoutique() {
    racket_active = loadImage("images/raquettes/RACKET-"+str(racket_visu)+".png");
    racket_bad = loadImage("images/raquettes/RACKET-1-OMBRE.png");
    racket_ten = loadImage("images/raquettes/RACKET-2-OMBRE.png");
    racket_laser = loadImage("images/raquettes/RACKET-3-OMBRE.png");
    racket_ping = loadImage("images/raquettes/RACKET-4-OMBRE.png");
    racket_gold = loadImage("images/raquettes/RACKET-5-OMBRE.png");
    racket_bad.resize(100,0);
    racket_ten.resize(100,0);
    racket_laser.resize(100,0);
    racket_ping.resize(100,0);
    racket_gold.resize(100,0);
    rectMode(CENTER);
    imageMode(CENTER);
  }

  void drow() {
    background(180);
    fill(100);
    rect(displayWidth/4,displayHeight/2, racket_active.width+40,racket_active.height+40);
    image(racket_active, displayWidth/4 ,displayHeight/2);
    textSize(40);
    fill(255);
    
    if(racket_visu == 1){                          //bouton du menu item raquette de base (badminton)
      text("Raquette de Badminton",2*displayWidth/5,displayHeight/5);
      fill(#FFC100);}
    else{fill(#a3a3a3);}
    rect(displayWidth/2, 3*displayHeight/5,racket_bad.width+10,racket_bad.height+10);
    
    if(raquettesAchetees.get(1)){                          //bouton du menu item raquette de tennis
      if(racket_visu == 2){
        fill(255);
        text("Raquette de Tennis",2*displayWidth/5,displayHeight/5);
        fill(#FFC100);}
      else{fill(#a3a3a3);}
    }
    else{fill(#494949);}
    rect(4*displayWidth/6, 3*displayHeight/5,110,racket_bad.height+10);
    
    if(raquettesAchetees.get(2)){                          //bouton du menu item raquette sabre laser
      if(racket_visu == 3){
        fill(255);
        text("Raquette Laser",2*displayWidth/5,displayHeight/5);
        fill(#FFC100);}
      else{fill(#a3a3a3);}
    }
    else{fill(#494949);}
    rect(5*displayWidth/6, 3*displayHeight/5,110,racket_bad.height+10);
    
    if(raquettesAchetees.get(3)){                          //bouton du menu item raquette de ping pong
      if(racket_visu == 4){
        fill(255);
        text("Raquette de Ping-Pong",2*displayWidth/5,displayHeight/5);
        fill(#FFC100);}
      else{fill(#a3a3a3);}
    }
    else{fill(#494949);}
    rect(3.5*displayWidth/6, 4*displayHeight/5,110,racket_bad.height+10);
    
    if(raquettesAchetees.get(4)){                          //bouton du menu item raquette d'or
      if(racket_visu == 5){
        fill(255);
        text("RAQUETTE DELUXE",2*displayWidth/5,displayHeight/5);
        fill(#FFC100);}
      else{fill(#a3a3a3);}
    }
    else{fill(#494949);}
    rect(4.5*displayWidth/6, 4*displayHeight/5,110,racket_bad.height+10);
    
    image(racket_bad,displayWidth/2, 3*displayHeight/5);      //charge icône des raquettes pour menu item
    image(racket_ten,4*displayWidth/6, 3*displayHeight/5);
    image(racket_laser,5*displayWidth/6, 3*displayHeight/5);
    image(racket_ping,3.5*displayWidth/6, 4*displayHeight/5);
    image(racket_gold,4.5*displayWidth/6, 4*displayHeight/5);

  }
  
  
  void mousePress(){
    if(mouseX>displayWidth/2-55 && mouseX<displayWidth/2+55 && mouseY>3*displayHeight/5-55 && mouseY<3*displayHeight/5+55){    //si bouton raquette badminton est cliqué
      if(raquettesAchetees.get(0))
        racket_visu = 1;
    }
    else if(mouseX>4*displayWidth/6-55 && mouseX<4*displayWidth/6+55 && mouseY>3*displayHeight/5-55 && mouseY<3*displayHeight/5+55){    //si bouton raquette tennis est cliqué
      if(raquettesAchetees.get(1))
        racket_visu = 2;
    }
    else if(mouseX>5*displayWidth/6-55 && mouseX<5*displayWidth/6+55 && mouseY>3*displayHeight/5-55 && mouseY<3*displayHeight/5+55){    //si bouton raquette laser est cliqué
      if(raquettesAchetees.get(2))
        racket_visu = 3;
    }
    else if(mouseX>3.5*displayWidth/6-55 && mouseX<3.5*displayWidth/6+55 && mouseY>4*displayHeight/5-55 && mouseY<4*displayHeight/5+55){    //si bouton raquette ping-pong est cliqué
      if(raquettesAchetees.get(3))
        racket_visu = 4;
    }
    else if(mouseX>4.5*displayWidth/6-55 && mouseX<4.5*displayWidth/6+55 && mouseY>4*displayHeight/5-55 && mouseY<4*displayHeight/5+55){    //si bouton raquette d'or est cliqué
      if(raquettesAchetees.get(4))
        racket_visu = 5;
    }
    racket_active = loadImage("images/raquettes/RACKET-"+str(racket_visu)+".png");
    

  }
  
  void mouseClick(){}
  
}