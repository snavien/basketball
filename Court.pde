class Court{
   void display(){
      //beginShape();
     
      //strokeWeight(1);
      //fill(255);
      //rect(40,145, 420, 235);
      //fill(40,40,40);
      //stroke(0);
      //rect (50, 150, 400, 225);                 // court
      //arc (435, 263, 190, 190, HALF_PI, PI+HALF_PI);      // right 3 point
      //arc (65, 263, 190, 190, radians(270), radians(450));   // left 3 point
      //fill (12, 129, 200);                  // center circle
      //ellipse (246, 256, 50, 50);            
      //line (246, 150, 246, 375);
      //fill (12, 129, 200);                  // half-court
      //rect (50, 238, 75, 50);                  // left rectangle/key
      //rect (375, 238, 75, 50);                // right rectangle/key
      //fill (0);                                // net  
      //ellipse (57, 263, 10, 10);                // left net
      //ellipse (443, 263, 10, 10);                // right net
      //rect (52, 135, 10, 10);                  // left player1
      //rect (65, 135, 10, 10);                  // left player2
      //rect (78, 135, 10, 10);                  // left player3
      //rect (91, 135, 10, 10);                  // left player4
      //rect (104, 135, 10, 10);                // left player5
      //rect (214, 126, 65, 20);                // subbing area
      //rect (438, 135, 10, 10);                // right player1
      //rect (425, 135, 10, 10);                // right player2
      //rect (412, 135, 10, 10);                // right player3
      //rect (399, 135, 10, 10);                // right player4
      //rect (386, 135, 10, 10);                // right player5
      //fill (255);                        // white fill
      //arc (375, 263, 50, 50, HALF_PI, PI+HALF_PI);      // tipoff  free throw right
      //arc (125, 263, 50, 50, radians(270), radians(450));    // tipoff free throw area left
      //endShape();
      beginShape();
    
      strokeWeight(1);
      fill(255);
      rect(10,10, 772, 404);
      fill(40,40,40);
      stroke(0);
      rect (10, 10, 752, 394);                 // court
      arc (435, 263, 190, 190, HALF_PI, PI+HALF_PI);      // right 3 point
      arc (65, 263, 190, 190, radians(270), radians(450));   // left 3 point
      fill (12, 129, 200);                  // center circle
      ellipse (280, 197, 96, 96);            
      line (246, 150, 246, 375);
      fill (12, 129, 200);                  // half-court
      rect (10, 149, 152, 96);                  // left rectangle/key
      rect (358, 149, 152, 96);                // right rectangle/key
      fill (0);                                // net  
      ellipse (57, 263, 10, 10);                // left net
      ellipse (443, 263, 10, 10);                // right net
      rect (52, 135, 10, 10);                  // left player1
      rect (65, 135, 10, 10);                  // left player2
      rect (78, 135, 10, 10);                  // left player3
      rect (91, 135, 10, 10);                  // left player4
      rect (104, 135, 10, 10);                // left player5
      rect (214, 126, 65, 20);                // subbing area
      rect (438, 135, 10, 10);                // right player1
      rect (425, 135, 10, 10);                // right player2
      rect (412, 135, 10, 10);                // right player3
      rect (399, 135, 10, 10);                // right player4
      rect (386, 135, 10, 10);                // right player5
      fill (255);                        // white fill
      arc (375, 263, 50, 50, HALF_PI, PI+HALF_PI);      // tipoff  free throw right
      arc (125, 263, 50, 50, radians(270), radians(450));    // tipoff free throw area left
      endShape();
    }
}