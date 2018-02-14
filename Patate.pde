final float g = 9.86;
final float G = 6.67*(10^(-11));

class Patate{
  int x, y;
  float vx, vy, masse;
  public Patate(int x, int y, int vx, int vy, int masse){
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.masse = masse;
  }
  
  void mouvementTerrestre(){
    this.x += this.vx/20;
    this.y += this.vy/20;
    this.vy -= g;  
  }
  
  void mouvementGeo(){
    int d = (int)sqrt((this.x)^2+(this.x)^2);
    float alpha = atan(x/y);
  }
}