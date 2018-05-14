final PVector g = new PVector(0, -9.86); //Intensité de la gravité à la surface de la Terre (SI)
final float Gnb = 6.67E-11; //Constante gravitationnelle (SI)
final int Gpw = 1;
float viscosite = 0.000017; //Viscosité du milieu (air : 0.000017, eau : 0.001002 (remonté à 0.002002 pour accentuer l'effet)) (SI)
float densite = 0; //Densité du milieu (air : 0, eau : 1) (kg/L)
final float mvpatate = 1.1; //Densité d'une patate (à ajuster) (kg/L)
final float mTerrenb = 5.9722; //Masse de la Terre (kg)
final int mTerrepw = 24;
final float rTerrenb = 3.1855; //Rayon de la Terre (m)
final int rTerrepw = 6;
ArrayList<Frite> frites;


class Patate{
  int type;
  float masse, taille, tourne, rotation;
  PImage img;
  PVector position, v;
  public Patate(float x, float y, float vx, float vy, float taille, int type, float rotation){
    this.position = new PVector(x, y); //Vecteur position (m)
    this.v = new PVector(vx, vy); //Vecteur vitesse (m/s)
    this.masse = 4*PI/3*pow(taille,3)*mvpatate; //Calcul de la masse en fonction du diamètre et de la densité
    this.taille = taille; //Taille de la patate (m)
    this.type = type; //Type de la patate (normale, non épluchée,...)
    
    this.rotation = rotation; //Vitesse de rotation de la patate (rad/s)
    this.tourne = 0; //Angle d'origine de la patate (évolue à chaque itération de la boucle en fonction de la vitesse de rotation) (rad)
    
    String nom =""; //importation de l'image de la patate en fonction de son type
    if (type == 0){
      nom = "images/patates/patate-" +type + "-" + int(random(3)) + ".png";
    }else{
      nom = "images/patates/patate-" + type + ".png";
    }
    this.img = loadImage(nom);
  }
  
  void mouvementTerrestre(){ //simule le déplacement d'une patate dans un référentiel terrestre (fonctionnel)
    PVector grav = PVector.mult(g, masse); //Vecteur représentant le poids (N)
    PVector frottement = PVector.mult(v, -6*PI*taille*viscosite); //Vecteur représentant la force de friction (N)
    PVector archimede = PVector.mult(g, -densite*4*PI/3*pow(taille,3)); //Vecteur représentant la poussée d'Archimède (N)
    PVector a = grav.add(frottement).add(archimede).div(this.masse); //Vecteur représentant l'accélération (m/s²)
    this.v = PVector.add(v, PVector.div(a, parsec * framerate)); //Vecteur représentant la vitesse (m/s)
    this.position = PVector.add(this.position, PVector.div(this.v, parsec * framerate)); //Vecteur représentant la position de la patate par rapport à l'origine du repère (en bas à gauche)(m)
    this.tourne+=this.rotation/(parsec*framerate); //Incrémentation de l'angle de la patate
  }
  
  void mouvementGeo(){ //simule le déplacement d'une patate dans un référentiel géocentrique (fonctionnel)
    float d = sqrt(pow(this.position.x,2)+pow(this.position.y,2)); //Distance entre la Terre et la patate (m)
    float pds = Gnb*mTerrenb*this.masse/pow(d,2) * pow(10, Gpw+mTerrepw); //Valeur du poids (N)
    PVector a = PVector.div(this.position, d).mult(-pds/this.masse); //Vecteur représentant l'accélération (m/s²)
    this.v.add(PVector.div(a,parsec)); //Vecteur représentant la vitesse (m/s)
    this.position.add(PVector.div(this.v, parsec)); //Vecteur représentant la position de la patate par rapport à l'origine du repère (la planète) (m)
    this.tourne+=this.rotation/(parsec*framerate); //Incrémentation de l'angle de la patate
  }
  
  void creerFrite(){
    Frite frite = new Frite(random(this.position.x-0.1, this.position.x+0.1),random(this.position.y-0.1, this.position.y+0.1), random(this.v.x-1, this.v.x+1), random(this.v.y-1, this.v.y+1), this.taille/3, int(random(0, 5.99)), this.rotation);
    frites.add(frite);
  }
}