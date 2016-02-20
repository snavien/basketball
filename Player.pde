//https://processing.org/examples/arrayobjects.html
class Player{
   ArrayList<Float> posxs, posys;
   float px, py;
   int moment, playerid, offx, offy;
   String fname, lname, name;
   int r, g, b;
   
   boolean over;
   int jersey_num; String position;
   
   Player(){
     moment = 0;
     posxs = new ArrayList<Float>();
     posys = new ArrayList<Float>();
     
   }
   
   Player(ArrayList<Float> pxs, ArrayList<Float> pys, int m, 
   int red, int green, int blue, int id){
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
     playerid = id;
   }
   // Custom method for updating the variables
    void update(int m_p[]) {
      println("mx: " + mouseX);
     if(m_p[1] == 0)
     {
      if(posxs.size() > 1)
      {
        if(moment < 1011)
        {

          
          px = posxs.get(moment);
          println("x " + px);
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
      
      if (overEvent()) {
        over = true;
      } else {
        over = false;
      }
      if(mousePressed && over)
      {
        println("you junkface");
        r = 100;
        g = 100;
        b = 100;
        PFont font;
        font = loadFont("Gadugi-Bold-48.vlw");
        textFont(font, 20);
      
        text(name, width/2 - 50, height/2 + 70);
 
      }


    }
    
    void set_player_info(String f, String l, int jnum, String pos)
    {
       fname = f;
       lname = l;
       name = f + " " + l; 
       jersey_num = jnum;
       position = pos;
    }
    

    
   boolean overEvent() {
    if (mouseX > offx + (px * (752/94.0)) && mouseX < offy + (px * (752/94.0))+ 12 &&
       mouseY > (py * (394/50.0)) && mouseY < offy + (py * (394/50.0))+12) {
      return true;
    } else {
      return false;
    }
  }
   
    
   void display()
   {
     beginShape();
     stroke(255);
     strokeWeight(1);
     fill(r,g,b);
     

     ellipse(offx + (px * (752/94.0)), offy + (py * (394/50.0)), 12, 12);  
                   
     endShape();
   }


    
}