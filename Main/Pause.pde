class MenuPause implements Fenetre{
  int score, vie, tMLG, tDouble, tAqua;  
  ArrayList<Patate> patates;
  ArrayList<Frite> frites;
  PImage b_resume;

  public MenuPause(ArrayList<Patate> patates, ArrayList<Frite> frites, int score, int vie, int tMLG, int tDouble, int tAqua){
    this.patates =  new ArrayList<Patate>(patates);
    this.frites = new ArrayList<Frite>(frites);
    this.score = score;
    this.vie = vie;
    this.tMLG = tMLG;
    this.tDouble = tDouble;
    this.tAqua = tAqua;
    b_resume = loadImage("images/boutons/bouton-12.png");
    textSize(50);
    fill(255);
    imageMode(CORNER);
    musique.amp(0.1);
    ;
  
  }
  
  void drow() {
    image(b_resume, displayWidth-188, 0);
    text("|| PAUSE ||", displayWidth/2-150,displayHeight/2);
  }
  
  void mousePress(){}
  
  void mouseClick(){
    if (mouseX > displayWidth - 188 && mouseY < 143)
      fenetre = new JeuTerre(this.patates, this.frites, this.score, this.vie, millis(), true, this.tMLG, this.tDouble, this.tAqua);
  }
}