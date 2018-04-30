class Instructions implements Fenetre {
  
  PFont policeinstructions;
  String[] instructions;
  PImage fond, b_retour;
  public Instructions() {
    fond = loadImage("images/fonds/fond-menu.png");
    fond.resize(displayWidth,displayHeight);
    background(fond);
    b_retour = loadImage("images/boutons/bouton-9.png");
    image(b_retour,displayWidth - 188/2, displayHeight - 143/2);
    textSize(20);
    fill(#ffff00);
    policeinstructions = loadFont("TrebuchetMS-30.vlw");
    textFont(policeinstructions);
    instructions = loadStrings("data/instructions-1.txt");
    for(int i=0; i< instructions.length; i = i+1){
      text(instructions[i], 100, (i+1)*displayHeight/18);}
    
  }
  void drow(){}
  void mousePress(){}
  void mouseClick(){
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143)
      fenetre = new Menu();
  }
}



class Records implements Fenetre {
  
  PImage fond, b_retour;
  public Records() {
    textSize(50);
    fill(255,255,0);
    fond = loadImage("images/fonds/fond-menu.png");
    fond.resize(displayWidth,displayHeight);
    background(fond);
    b_retour = loadImage("images/boutons/bouton-9.png");
    image(b_retour,displayWidth - 188/2, displayHeight - 143/2);
    for(int i=0; i<meilleurs_scores.size(); i = i+1)
      text("#"+str(i+1)+":  "+str(meilleurs_scores.get(i)), displayWidth/10, (i+1)*displayHeight/6);
    }
  
  
  void drow(){}
  void mousePress(){}
 
  void mouseClick(){
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143)
      fenetre = new Menu();
  }
}