ArrayList<Boolean> raquettesAchetees;
int racket_activ = 0;


class MenuBoutique implements Fenetre {
  
  PImage racket_visuel, racket_bad,racket_ten,racket_laser,racket_ping,racket_gold;
  PImage b_retour, b_achat, b_equip, b_active;
  int racket_visu = 1;
  
  public MenuBoutique() {
    racket_visuel = loadImage("images/raquettes/RACKET-"+str(racket_visu)+".png");
    racket_bad = loadImage("images/raquettes/RACKET-1-OMBRE.png");
    racket_ten = loadImage("images/raquettes/RACKET-2-OMBRE.png");
    racket_laser = loadImage("images/raquettes/RACKET-3-OMBRE.png");
    racket_ping = loadImage("images/raquettes/RACKET-4-OMBRE.png");
    racket_gold = loadImage("images/raquettes/RACKET-5-OMBRE.png");
    b_retour = loadImage("images/boutons/bouton-9.png");
    b_achat = loadImage("images/boutons/bouton-10.png");
    b_equip = loadImage("images/boutons/bouton-11.png");
    b_active = loadImage("images/boutons/équipée.png");
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
    fill(100);
    image(b_retour,displayWidth - 188/2, displayHeight - 143/2);
    rect(displayWidth/4,displayHeight/2, racket_visuel.width+40,racket_visuel.height+40);
    image(racket_visuel, displayWidth/4 ,displayHeight/2);
    textSize(40);
    fill(255);
    
    
    if(racket_visu == 1){                          //bouton du menu item raquette de base (badminton)
      if(racket_activ == 0)
        image(b_active, 2*displayWidth/5+145,displayHeight/5+70);
      else
        image(b_equip, 2*displayWidth/5+145,displayHeight/5+70);
      text("Raquette de Badminton",2*displayWidth/5,displayHeight/5);
      fill(#FFC100);}
    else{fill(#a3a3a3);}
    rect(displayWidth/2, 3*displayHeight/5,racket_bad.width+10,racket_bad.height+10);
    
    
    
    if(raquettesAchetees.get(1)){                          //bouton du menu item raquette de tennis
      fill(#a3a3a3);}
    else{fill(#494949);}
    if(racket_visu == 2){
      if(raquettesAchetees.get(1)){
        if(racket_activ == 1)
          image(b_active, 2*displayWidth/5+145,displayHeight/5+70);
        else
          image(b_equip, 2*displayWidth/5+145,displayHeight/5+70);
      }
      else
        image(b_achat, 2*displayWidth/5+145,displayHeight/5+70);
      fill(255);
      text("Raquette de Tennis",2*displayWidth/5,displayHeight/5);
      fill(#FFC100);}
    rect(4*displayWidth/6, 3*displayHeight/5,110,racket_bad.height+10);
    
    
    
    if(raquettesAchetees.get(2)){                          //bouton du menu item raquette sabre laser
      fill(#a3a3a3);}
    else{fill(#494949);}
    if(racket_visu == 3){
      if(raquettesAchetees.get(2)){
        if(racket_activ == 2)
          image(b_active, 2*displayWidth/5+145,displayHeight/5+70);
        else
          image(b_equip, 2*displayWidth/5+145,displayHeight/5+70);
      }
      else
        image(b_achat, 2*displayWidth/5+145,displayHeight/5+70);
      fill(255);
      text("Raquette Laser",2*displayWidth/5,displayHeight/5);
      fill(#FFC100);}
    rect(5*displayWidth/6, 3*displayHeight/5,110,racket_bad.height+10);
    
    
    
    if(raquettesAchetees.get(3)){                          //bouton du menu item raquette de ping pong
      fill(#a3a3a3);}
    else{fill(#494949);}
    if(racket_visu == 4){
      if(raquettesAchetees.get(3)){
        if(racket_activ == 3)
          image(b_active, 2*displayWidth/5+145,displayHeight/5+70);
        else
          image(b_equip, 2*displayWidth/5+145,displayHeight/5+70);
      }
      else
        image(b_achat, 2*displayWidth/5+145,displayHeight/5+70);
      fill(255);
      text("Raquette de Ping-Pong",2*displayWidth/5,displayHeight/5);
      fill(#FFC100);}
    rect(3.5*displayWidth/6, 4*displayHeight/5,110,racket_bad.height+10);
    
    
    
    if(raquettesAchetees.get(4)){                          //bouton du menu item raquette d'or
      fill(#a3a3a3);}
    else{fill(#494949);}
    if(racket_visu == 5){
      if(raquettesAchetees.get(4)){
      if(racket_activ == 4)
        image(b_active, 2*displayWidth/5+145,displayHeight/5+70);
      else
        image(b_equip, 2*displayWidth/5+145,displayHeight/5+70);
      }
      else
        image(b_achat, 2*displayWidth/5+145,displayHeight/5+70);
      fill(255);
      text("RAQUETTE DELUXE",2*displayWidth/5,displayHeight/5);
      fill(#FFC100);}
    rect(4.5*displayWidth/6, 4*displayHeight/5,110,racket_bad.height+10);
    
    
    image(racket_bad,displayWidth/2, 3*displayHeight/5);      //charge icône des raquettes pour menu item
    image(racket_ten,4*displayWidth/6, 3*displayHeight/5);
    image(racket_laser,5*displayWidth/6, 3*displayHeight/5);
    image(racket_ping,3.5*displayWidth/6, 4*displayHeight/5);
    image(racket_gold,4.5*displayWidth/6, 4*displayHeight/5);

  }
  
  
  void mousePress(){
    if(mouseX>displayWidth/2-55 && mouseX<displayWidth/2+55 && mouseY>3*displayHeight/5-55 && mouseY<3*displayHeight/5+55)    //si bouton raquette badminton est cliqué
        racket_visu = 1;
    if(mouseX>4*displayWidth/6-55 && mouseX<4*displayWidth/6+55 && mouseY>3*displayHeight/5-55 && mouseY<3*displayHeight/5+55)    //si bouton raquette tennis est cliqué
        racket_visu = 2;
    if(mouseX>5*displayWidth/6-55 && mouseX<5*displayWidth/6+55 && mouseY>3*displayHeight/5-55 && mouseY<3*displayHeight/5+55)    //si bouton raquette laser est cliqué
        racket_visu = 3;
    if(mouseX>3.5*displayWidth/6-55 && mouseX<3.5*displayWidth/6+55 && mouseY>4*displayHeight/5-55 && mouseY<4*displayHeight/5+55)    //si bouton raquette ping-pong est cliqué
        racket_visu = 4;
    if(mouseX>4.5*displayWidth/6-55 && mouseX<4.5*displayWidth/6+55 && mouseY>4*displayHeight/5-55 && mouseY<4*displayHeight/5+55)    //si bouton raquette d'or est cliqué
        racket_visu = 5;
    racket_visuel = loadImage("images/raquettes/RACKET-"+str(racket_visu)+".png");
  }
  
  void mouseClick(){
    if(mouseX > 2*displayWidth/5 && mouseX < 2*displayWidth/5+290 && mouseY > displayHeight/5+39 && mouseY < displayHeight/5+102){
      
      if(racket_visu == 1){      //activer la raquette badminton
        if(racket_activ != 0)
          racket_activ = 0;}
          
      else if(racket_visu == 2){      //acheter ou activer raquette tennis
        if(raquettesAchetees.get(1)){
          if(racket_activ != 1)
            racket_activ = 1;}
        else
          raquettesAchetees.set(1,true);}
          
      else if(racket_visu == 3){      //acheter ou activer raquette laser
        if(raquettesAchetees.get(2)){
          if(racket_activ != 2)
            racket_activ = 2;}
        else
          raquettesAchetees.set(2,true);}
          
      else if(racket_visu == 4){      //acheter ou activer raquette ping-pong
        if(raquettesAchetees.get(3)){
          if(racket_activ != 3)
            racket_activ = 3;}
        else
          raquettesAchetees.set(3,true);}
          
     else if(racket_visu == 5){      //acheter ou activer raquette deluxe
        if(raquettesAchetees.get(4)){
          if(racket_activ != 4)
            racket_activ = 4;}
        else
          raquettesAchetees.set(4,true);}
    }
     
    else if (mouseX > displayWidth-188 && mouseY > displayHeight-143)      //bouton retour
      fenetre = new Menu();
    
  }
  
}