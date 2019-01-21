class MenuPause implements Fenetre{
  int vie, tMLG, tDouble, tAqua, temps; 
  float score, xnyan, ynyan;
  boolean mlg, nyancat;
  ArrayList<Patate> patates;
  ArrayList<Frite> frites;
  PImage b_resume, b_retour;
  

  public MenuPause(ArrayList<Patate> patates, ArrayList<Frite> frites, float score, int vie, int temps, boolean mlg, int tMLG, int tDouble, int tAqua, boolean nyancat, float xnyan, float ynyan){
    this.patates =  new ArrayList<Patate>(patates);
    this.frites = new ArrayList<Frite>(frites);
    this.score = score;
    this.vie = vie;
    this.temps = temps;
    this.tMLG = tMLG;
    this.tDouble = tDouble;
    this.tAqua = tAqua;
    this.mlg = mlg;
    this.nyancat = nyancat;
    this.xnyan = xnyan;
    this.ynyan = ynyan;
    b_resume = loadImage("images/boutons/bouton-12.png");    //charger les images qui apparaitront dan sle menu pause
    b_retour = loadImage("images/boutons/bouton-9.png");
    textSize(60);
    fill(255);
    imageMode(CENTER);
    musique.amp(0.1);                                        //diminuer le son de la musique quand le jeu est en pause
    if(this.mlg)                                             //arrêter la musique mlg si le bonus est activé 
      musique_mlg.stop();
  }
  
  void drow() {
    image(b_resume, displayWidth-94, 72);                    //afficher les images chargées auparavant ainsi qu'un texte au milieu de l'écran
    image(b_retour, displayWidth-94, displayHeight-72);
    text("|| PAUSE ||", displayWidth/2-150,displayHeight/2);
  }
  
  void mousePress(){}
  
  void mouseClick(){
    if(this.mlg){                                            //relancerla musique mlg là où elle s'est arreté lorsqu'on reprend la partie (si le bonus est activé)
      musique_mlg.jump(this.tMLG/framerate);
      musique_mlg.play();}
      
    if (mouseX > displayWidth - 188 && mouseY < 143){
      if(tAqua<0)
        fenetre = new JeuGeo(this.patates, this.frites, this.score, this.vie, this.temps, true, this.mlg, this.tMLG, this.tDouble, this.nyancat, this.xnyan, this.ynyan);                //retourner au bon mode de jeu une fois sorti du menu pause
      else
        fenetre = new JeuTerre(this.patates, this.frites, this.score, this.vie, this.temps, true, this.mlg, this.tMLG, this.tDouble, this.tAqua);  //l'absence de bonus aqua dans le jeu géo permet d'éviter la crétion d'une nouvelle variable
    }
    else if(mouseX > displayWidth - 188 && mouseY > displayHeight-143){    //quitter la partie en cliquant sur le bouton retour
      musique.stop();
      musique_menu();
      fenetre = new Menu();
    }
  }
  void keyPress(){}
}
