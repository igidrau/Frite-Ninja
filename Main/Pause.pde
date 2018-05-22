class MenuPause implements Fenetre{
  int vie, tMLG, tDouble, tAqua, temps; 
  float score;
  ArrayList<Patate> patates;
  ArrayList<Frite> frites;
  PImage b_resume, b_retour;

  public MenuPause(ArrayList<Patate> patates, ArrayList<Frite> frites, float score, int vie, int temps, int tMLG, int tDouble, int tAqua){
    this.patates =  new ArrayList<Patate>(patates);
    this.frites = new ArrayList<Frite>(frites);
    this.score = score;
    this.vie = vie;
    this.temps = temps;
    this.tMLG = tMLG;
    this.tDouble = tDouble;
    this.tAqua = tAqua;
    b_resume = loadImage("images/boutons/bouton-12.png");
    b_retour = loadImage("images/boutons/bouton-9.png");
    textSize(60);
    fill(255);
    imageMode(CENTER);
    musique.amp(0.1);
  }
  
  void drow() {
    image(b_resume, displayWidth-94, 72);
    image(b_retour, displayWidth-94, displayHeight-72);
    text("|| PAUSE ||", displayWidth/2-150,displayHeight/2);
  }
  
  void mousePress(){}
  
  void mouseClick(){
    if (mouseX > displayWidth - 188 && mouseY < 143){
      if(tAqua<0)
        fenetre = new JeuGeo(this.patates, this.frites, this.score, this.vie, this.temps, true, this.tMLG, this.tDouble);
      else
        fenetre = new JeuTerre(this.patates, this.frites, this.score, this.vie, this.temps, true, this.tMLG, this.tDouble, this.tAqua);
    }
    else if(mouseX > displayWidth - 188 && mouseY > displayHeight-143){
      musique.stop();
      musique_menu();
      fenetre = new Menu();
  }
}
}