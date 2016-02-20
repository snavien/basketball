//https://processing.org/examples/arrayobjects.html
class Player{
   ArrayList<Float> posxs, posys;
   float px, py;
   int moment, playerid, offx, offy;
   String fname, lname, name;
   int r, g, b;
   int avg_left;
   
   boolean over, select;
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
     avg_left = 0;
   }
   // Custom method for updating the variables
    void update(int m_p[]) {

     if(m_p[1] == 0)
     {
      if(posxs.size() > 1)
      {
        if(moment < 1011)
        {
          px = posxs.get(moment);
          if(offx + px * (752/94.0) < 752)
          {
            avg_left++;
          }
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

        select = true;

      }
      if(select)
      {
        int or = r, og = g, ob = b;
        r = 100;
        g = 100;
        b = 100;
        PFont font;

        font = loadFont("Gadugi-Bold-48.vlw");
        fill(0);
        rect(width/2 - 60, height/2 + 150, 200, 100);
        fill(255);
        
        textFont(font, 20);
      
        text(name, width/2 - 50, height/2 + 200);
        text(position, width/2 - 50, height/2 + 220);
        text("Times left of half-court: " + avg_left, width/2 - 50, height/2 + 240);
        
        //r = or;
        //g = og;
        //b = ob;
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

      PFont font;
      
      font = loadFont("Gadugi-Bold-48.vlw");
      fill(0);
      textFont(font, 10);

      text(jersey_num, offx + (px * (752/94.0)), offy + (py * (394/50.0)));

                   
     endShape();
   }


    
}