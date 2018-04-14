<<<<<<< HEAD
SoundFile musique;


void musique_menu(){
  musique = new SoundFile(this, "son/musique-menu.mp3");
}

void musique_cuisine(){
  musique = new SoundFile(this, "son/musique-partie(boucle).mp3");
}

void musique_space(){
  musique = new SoundFile(this, "son/musique-space.mp3");
=======
SoundFile musicmenu, musiccuisine, musicspace, musicdub, musicwater;


void son_musique(){
  musicmenu = new SoundFile(this, "musique-menu.mp3");
  /*
  if(fenetre== new Menu())
    musicmenu.play();
  */
>>>>>>> 8b1fd7fe7b15ee3cad0865e301aa92750da20774
}