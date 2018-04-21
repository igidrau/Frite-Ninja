SoundFile musique, soncoupe1, soncoupe2, sonrate, musique_mlg;


void musique_menu(){
  musique = new SoundFile(this, "son/musique-menu.mp3");
  musique.loop();
}

void musique_cuisine(){
  musique = new SoundFile(this, "son/musique-partie(boucle).mp3");
  musique.loop();  
}

void musique_space(){
  musique = new SoundFile(this, "son/musique-space.mp3");
  musique.loop();
}

void musique_mlg(){
  musique = new SoundFile(this, "son/musique-MLG.mp3");
  musique.loop();
}