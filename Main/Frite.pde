//cette classe est en majorité identique à la classe patate


class Frite{
  float masse, taille, tourne, rotation;
  boolean potato;
  PVector position, v;
  int img;
  public Frite(float x, float y, float vx, float vy, float taille, boolean potato, float rotation){
    this.position = new PVector(x, y); //Vecteur position (m)
    this.v = new PVector(vx, vy); //Vecteur vitesse (m/s)
    this.masse = 4*PI/3*pow(taille,3)*mvpatate; //Calcul de la masse en fonction du diamètre et de la densité
    this.taille = taille; //Taille de la frite (m)
    this.potato = potato;
    
    this.rotation = rotation;
    this.tourne = 0;
    
    if(potato)                                                      //si cette frite est issu d'une patate non épluchée, c'est une potato
      this.img = int(random(14,18));
    else
      this.img = int(random(8,14));

  }
  
  void mouvementTerrestre(){ //simule le déplacement d'une patate dans un référentiel terrestre (fonctionnel)
    PVector grav = PVector.mult(g, masse); //Vecteur représentant le poids (N)
    PVector frottement = PVector.mult(v, 0.41*PI*taille*taille*viscosite); //Vecteur représentant la force de friction (N)
    PVector archimede = PVector.mult(g, -densite*4*PI/3*pow(taille,3)); //Vecteur représentant la poussée d'Archimède (N)
    PVector a = grav.add(frottement).add(archimede).div(this.masse); //Vecteur représentant l'accélération (m/s²)
    this.v = PVector.add(v, PVector.div(a, parsec*framerate)); //Vecteur représentant la vitesse (m/s)
    this.position = PVector.add(this.position, PVector.div(this.v, parsec*framerate)); //Vecteur représentant la position de la patate par rapport à l'origine du reprère (en bas à gauche)(m)
    this.tourne+=this.rotation/(parsec*framerate); //Incrémentation de l'angle de la patate
  }
  
  void mouvementGeo(){ //simule le déplacement d'une patate dans un référentiel géocentrique (fonctionnel)
    float d = sqrt(pow(this.position.x,2)+pow(this.position.y,2)); //Distance entre la Terre et la patate (m)
    float pds = Gnb*mTerrenb*this.masse/pow(d,2) * pow(10, Gpw+mTerrepw); //Valeur du poids (N)
    PVector a = PVector.div(this.position, d).mult(-pds/this.masse); //Vecteur représentant l'accélération (m/s²)
    this.v.add(PVector.div(a,parsec*framerate)); //Vecteur représentant la vitesse (m/s)
    this.position.add(PVector.div(this.v, parsec*framerate)); //Vecteur représentant la position de la patate par rapport à l'origine du repère (la planète) (m)
    this.tourne+=this.rotation/(parsec*framerate); //Incrémentation de l'angle de la patate
  }
}