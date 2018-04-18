SoundFile musique;


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