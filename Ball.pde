class Ball{
  
      double  x,
              y,
              h;
              
      ArrayList<Double> ball_px,
                        ball_py,
                        ball_height;
      int moment;
      Boolean to_update;
      float offx, offy;
      double max_height;
      ArrayList<Integer> moment_list;
     Ball(ArrayList<Double> bpx, ArrayList<Double> bpy, ArrayList<Double> hgt,
        int m, double mx){//, ArrayList<Integer> ml){
     
       moment = 0;
       ball_px = new ArrayList<Double>();
       ball_px = bpx;
       ball_py = new ArrayList<Double>();
       ball_py = bpy;
       ball_height = new ArrayList<Double>();
       ball_height = hgt;
       x = bpx.get(m);
       y = bpy.get(m);
       h = hgt.get(m);
       offx = 20;
       offy = 10;
       max_height = mx;
       //moment_list = ml;
   }
   // Custom method for updating the variables
   void update(int m_p[]) {
     if(m_p[1] == 0)
     {
      if(moment < 1011)
      {// && moment_list.get(moment) != -1){
        if(ball_px.get(moment) != (double)(-1.0))
        {
          x = ball_px.get(moment);
          y = ball_py.get(moment);
          h = ball_height.get(moment);
        }
        moment++;  
      }
     }
     else{
        if(ball_px.get(m_p[0]) != (double)(-1.0))
        {
          x = ball_px.get(m_p[0]);
          y = ball_py.get(m_p[0]);
          h = ball_height.get(m_p[0]);
          moment = m_p[0];
        }
     }
    }
   void display(){
     beginShape();
     noStroke();
     fill(255, 151, 2);
     ellipse(offx + (float)(x * (752/94.0)), offy + (float)(y * (394/50.0)), (float)(40 * (h/max_height)), (float)(40 *(h/max_height)));  
     endShape();
   }
}