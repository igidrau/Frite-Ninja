final PVector g = new PVector(0, -9.86);
final float G = 6.67*(10^(-11));
final float viscosite = 0.017*(10^-3);
final float densite = 0;

class Patate{
  int type;
  float masse, taille;
  PImage img;
  PVector position, v;
  public Patate(int x, int y, int vx, int vy, int masse, float taille, int type){
    this.position = new PVector(x, y);
    this.v = new PVector(vx, vy);
    this.masse = masse;
    this.taille = taille;
    this.type = type;
    
    if (type == 0){
      this.img = loadImage("images/patate-" + type + "-" + int(random(3)));
    }else{
      this.img = loadImage("images/patate-" + type);
    }
  }
  
  void mouvementTerrestre(){
    //PVector a = v.mult(-6*PI*taille*viscosite).add(g.mult(1-densite*4*PI/3*pow(taille, 3)));
    this.v = this.v.add(g.div(100));
    this.position = this.position.add(this.v.div(100));
  }
  /*
  void mouvementGeo(){
    int d = (int)sqrt(pow(this.x,2)+(this.x)^2);
    float alpha = atan(x/y);
  }*/
}
