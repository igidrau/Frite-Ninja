final PVector g = new PVector(0, -9.86);
final float Gnb = 6.67; //SI
final int Gpw = -11;
final float viscosite = 0.000017; // (air : 0.000017, eau : 0.001002 (remonté à 0.002002 pour accentuer l'effet)) SI
final float densite = 0; //1 (air : 0, eau : 1) kg/L
final float mvpatate = 1.1; // la densité d'une patate (à ajuster) kg/L
final float mTerrenb = 5.9722; //kg
final int mTerrepw = 24;
final float rTerrenb = 3.1855; //m
final int rTerrepw = 6;
final PVector terre = new PVector(0,0);


class Patate{
  int type;
  float masse, taille;
  PImage img;
  PVector position, v;
  public Patate(float x, float y, float vx, float vy, float taille, int type){
    this.position = new PVector(x, y); //vecteur position
    this.v = new PVector(vx, vy); //vecteur vitesse
    this.masse = 4*PI/3*pow(taille,3)*mvpatate; //calcul de la masse en fonction du diamètre et de la densité
    this.taille = taille;
    this.type = type;
    
    String nom =""; //importation de l'image de la patate en fonction de son type
    if (type == 0){
      nom = "patate-" +type + "-" + int(random(3)) + ".png";
    }else{
      nom = "patate-" + type + ".png";
    }
    this.img = loadImage(nom);
  }
  
  void mouvementTerrestre(){ //simule le déplacement d'une patate dans un référentiel terrestre (fonctionnel)
    PVector grav = PVector.mult(g, masse); //vecteur force gravitationnelle
    PVector frottement = PVector.mult(v, -6*PI*taille*viscosite); //vecteur force de friction
    PVector archimede = PVector.mult(g, -densite*4*PI/3*pow(taille,3)); //vecteur poussée d'Archimède
    PVector a = grav.add(frottement).add(archimede).div(this.masse); //vecteur accélération
    this.v = PVector.add(v, PVector.div(a, parsec)); //vecteur vitesse
    this.position = PVector.add(this.position, PVector.div(this.v, parsec)); //vecteur position
  }
  
  void mouvementGeo(){ //simule le déplacement d'une patate dans un référentiel géocentrique (fonctionnel)
    float d = sqrt(pow(this.position.x,2)+pow(this.position.y,2));
    float pds = Gnb*mTerrenb*this.masse/pow(d,2) * pow(10, Gpw+mTerrepw); //valeur du poids
    PVector a = PVector.div(this.position, d).mult(-pds/this.masse); //vecteur accélération
    this.v.add(PVector.div(a,parsec)); //vecteur vitesse
    this.position.add(PVector.div(this.v, parsec)); //vecteur position
  }
}
