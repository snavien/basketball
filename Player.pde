//https://processing.org/examples/arrayobjects.html
class Player{
   ArrayList<Float> posxs, posys;
   float px, py;
   int moment, playerid, offx, offy;
   String name;
   int r, g, b;
   Player(ArrayList<Float> pxs, ArrayList<Float> pys, int m, int red, int green, int blue){
     moment = m;
     posxs = pxs;
     posys = pys;
     px = pxs.get(0);
     py = pys.get(0);
     offx = 20;
     offy = 10;
     r = red;
     g = green;
     b = blue;
   }
   // Custom method for updating the variables
    void update(int m_p[]) {

     if(m_p[1] == 0)
     {
      if(moment < 1011)
      {// && moment_list.get(moment) != -1){
        px = posxs.get(moment);
        py = posys.get(moment);
        moment++;  
      }
     }
     else
     {
        px = posxs.get(m_p[0]);
        py = posys.get(m_p[0]);
        moment = m_p[0];   
     }  
    }
   void display(){

     beginShape();
     stroke(255);
     strokeWeight(1);
     fill(r,g,b);
     

     ellipse(offx + (px * (752/94.0)), offy + (py * (394/50.0)), 9, 9);  
                   
     endShape();
   }


    
}