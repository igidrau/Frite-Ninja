SoundFile musique;


void musique_menu(){
  musique = new SoundFile(this, "son/musique-menu.mp3");
}

void musique_cuisine(){
  musique = new SoundFile(this, "son/musique-partie(boucle).mp3");
}

void musique_space(){
  musique = new SoundFile(this, "son/musique-space.mp3");
}