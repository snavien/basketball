//TODO: Map moment to players and ball
//PSUDO ENUMS FOR EVENT COLUMNS
static final int GAMEID    = 0; 
static final int TEAMID    = 1;
static final int PLAYERID  = 2;
static final int XPOS      = 3;
static final int YPOS      = 4;
static final int HEIGHT    = 5;
static final int MOMENT    = 6;
static final int GAMECLOCK = 7;
static final int SHOTCLOCK = 8; 
static final int PERIOD    = 9;


Game curr_game;
Event curr_event;
int game_index,
    event_index;
int state;
import java.util.*;
Table   gamestable, 
        eventstable, 
        playerstable, 
        teamstable;
HScrollbar hs1;  // Two scrollbars      
        
Clock  clock;
Court  court;

ArrayList<Game> games;

void setup()
{
  size(800, 650);      // always go first

  surface.setResizable(true);
  smooth();

  court = new Court();
  clock = new Clock();
  game_index = 0;
  event_index = 0;
  state = 0;
  games = new ArrayList<Game>();
  load_games();
  all_players = new HashMap<Integer, Player>();

  surface.setResizable(true);

  curr_event = new Event();
  hs1 = new HScrollbar(0, height - 30, width, 16, 16);
}

HashMap<Integer, Player> all_players;
void get_info(int pid)
{
 Table playerstable = new Table();
 playerstable = loadTable("players.csv", "header");   //load an event
  
 for(TableRow row : playerstable.rows())
 {
   if(row.getInt("playerid") == pid)
   {
     Player p = new Player();
 
     p.set_player_info(row.getString("firstname"), 
                         row.getString("lastname"),
                         row.getInt("jerseynumber"),
                         row.getString("position"));
   
     all_players.put(row.getInt("playerid"), p);
   }
 }
}
void load_games()
{
  //PROCESS DATA
  gamestable = loadTable("games.csv", "header"); // list of games
  String game_date = new String();
  int gameid = 0, hometeamid = 0, visitorteamid = 0;
  for (TableRow row : gamestable.rows()) 
  {        
    gameid = row.getInt("gameid");                    // load gameid
    hometeamid = row.getInt("hometeamid");           // load home team id
    visitorteamid = row.getInt("visitorteamid");     // load visitor team id
    game_date = row.getString("gamedate");
    
    teamstable = loadTable("team.csv", "header");           // list of teams

    String  ht_name = new String(), 
      ht_abbr = new String(), 
      vt_name = new String(), 
      vt_abbr = new String();
  
    for (TableRow trow : teamstable.rows()) 
    {        
      if (trow.getInt("teamid") == hometeamid)
      {
        ht_name = trow.getString("name");
        ht_abbr = trow.getString("abbreviation");
      }
      if (trow.getInt("teamid") == visitorteamid)
      {
        vt_name = trow.getString("name");
        vt_abbr = trow.getString("abbreviation");
      }
    }
    
    Game game = new Game(gameid,hometeamid,visitorteamid,ht_name,ht_abbr,vt_name,vt_abbr, game_date);
    games.add(game);
  }

}

void populate_events(Game game)
{  
  File dir = new File(dataPath("") + "/games/00" + game.gameid+"/");
  //println(dir);
  String eventid;
  File[] filesList = dir.listFiles();
  Arrays.sort(filesList, 
    new Comparator<File>()
    {
      public int compare(File a, File b)
      {
         int len = a.getName().length() - b.getName().length();
         if(len == 0)
         {
           return a.getName().compareTo(b.getName());
         }
         else 
         {
            return len; 
         }
      }
    });
  
  for(File file: filesList)
  {
     if(file.isFile())
     {
        eventid = file.getName();
        String str = eventid.substring(0, eventid.lastIndexOf('.'));
        game.add_event(str);   
     }
  }

  
}

void initialize_event(Game game, String eventid, Event event)
{
  
  Ball ball;
  ArrayList<Double> bpx,
                    bpy,
                    ball_heights;           
  //println("eventid: " + eventid);
  eventstable = loadTable("/games/00" + game.gameid + "/" + eventid + ".csv");   //load an event


  ball_heights = new ArrayList<Double>();
  bpx = new ArrayList<Double>();
  bpy = new ArrayList<Double>();


  int moment_cnt = 0;
 
  
  for (TableRow row : eventstable.rows()) 
  {     
    if (row.getInt(6) != moment_cnt)                             // iterate through moments
    {
      if (row.getInt(1) == -1 && row.getInt(2) == -1)            //check if this point has ball update
      {
        ball_heights.add(moment_cnt, (double)row.getInt(5));
        bpx.add(moment_cnt, (double)row.getInt(3));
        bpy.add(moment_cnt, (double)row.getInt(4));
      } 
      else 
      {
        ball_heights.add(moment_cnt, (double)-1.0);
        bpx.add(moment_cnt, (double)-1.0);
        bpy.add(moment_cnt, (double)-1.0);
      }
      moment_cnt++;
    }
    if (row.getInt(1) != -1 && row.getInt(PLAYERID) != -1)            //ball is not there, want moment toast be -1
    {
        if(row.getInt(TEAMID) == game.hometeamid)
        {
          if(event.home.get(row.getInt(PLAYERID)) == null)
          {
            Player h = new Player();
           // println(row.getInt(PLAYERID));
           
            h.playerid = row.getInt(PLAYERID);
            //println(h.playerid);
            get_info(h.playerid);
            h.set_player_info((all_players.get(h.playerid)).fname, 
                               (all_players.get(h.playerid)).lname, 
                               (all_players.get(h.playerid)).jersey_num,
                               (all_players.get(h.playerid)).position);
                               
                               
            event.home.put(row.getInt(PLAYERID), h);
          } 
          //println(event.home.get(row.getInt(PLAYERID)).fname);
          
          //println(row.getFloat(XPOS));
          
          event.home.get(row.getInt(PLAYERID)).posxs.add(row.getFloat(XPOS));
          //println(event.home.get(row.getInt(PLAYERID)).fname);

          //for(Object o: event.home.get(row.getInt(PLAYERID)).posxs)
          //{
          //  println("!" + o); 
          //}
          event.home.get(row.getInt(PLAYERID)).posys.add(row.getFloat(YPOS));
        }
        else
        {
          if(row.getInt(TEAMID) == game.visitorteamid)
          {
            if(event.visitor.get(row.getInt(PLAYERID)) == null)
            {
              Player v = new Player();
            //  println(row.getInt(PLAYERID));
             
              v.playerid = row.getInt(PLAYERID);
              //println(v.playerid);
              get_info(v.playerid);
              v.set_player_info((all_players.get(v.playerid)).fname, 
                                 (all_players.get(v.playerid)).lname, 
                                 (all_players.get(v.playerid)).jersey_num,
                                 (all_players.get(v.playerid)).position);
                                 
                                 
              event.visitor.put(row.getInt(PLAYERID), v);
            } 

            //println("player id: " + row.getInt(PLAYERID));
            event.visitor.get(row.getInt(PLAYERID)).posxs.add(row.getFloat(XPOS));
            event.visitor.get(row.getInt(PLAYERID)).posys.add(row.getFloat(YPOS));

          }
        }
    }
  }

  println("went through");
  
  double max_height = Collections.max(ball_heights);

  ball = new Ball(bpx, bpy, ball_heights, 0, max_height);

  event.set_ball(ball);
}



void keyPressed()
{
 if(keyCode == RIGHT)
 {
   game_index++; 
 }
 if(keyCode == LEFT) 
 {
    game_index--;
 }
 if(game_index >= 0 && game_index <= 81)
 {
   curr_game = games.get(game_index);
   //print(curr_game.ht_abbr);

 }
 if(keyCode == ENTER && state == 0)
 {
    state = 1;
   
    //print("!");
 }
 if(keyCode == UP)
 {
    event_index--;
 }
 if(keyCode == DOWN)
 {
    event_index++; 
 } 
 
 if(keyCode == ' ')
 {
     
     println("POOP");
     println("meep");
     state = 2;
 }
}

String curr_id;
void draw() 
{
  if(game_index >= 0 && game_index <= 81)
  {
    PFont font;
    font = loadFont("Gadugi-Bold-48.vlw");
    switch(state)
    {
       case 0:
         fill(200,200,200);
         rect(0,0,width,height);
         curr_game = new Game();
         curr_game = games.get(game_index);
         PImage img, h_logo, v_logo, basketball;
         img = loadImage(sketchPath() + "/images/splash.png");
         h_logo = loadImage(sketchPath() +"/images/teams/"+curr_game.ht_abbr +".png");
         v_logo = loadImage(sketchPath() +"/images/teams/"+curr_game.vt_abbr +".png");
         basketball = loadImage(sketchPath() +"/images/basketball.png");
         image(img, 0, 0, width, height);
         noStroke();
         
         tint(225,127);
         image(basketball, 45,35, 200, 200);
         image(basketball, 550, 400, 200, 200);
         tint(225,255);
         image(h_logo, 45, 45, 200, 200);
         image(v_logo, 550, 400, 200, 200);
         fill(255);
         textFont(font, 50);
         text(curr_game.gamedate, width/2- 150, height/2 + 20);
         
         populate_events(curr_game);
         
         curr_id = curr_game.eventlist.get(event_index);
         break;
         
       case 1:
         state = 1;
         if(event_index >=0 && event_index < 82)
         {
           curr_id = curr_game.eventlist.get(event_index);
  
           textFont(font, 20);
      
           text("Event #" + curr_id, width/2 - 50, height/2 + 70);
         }

         break;
       case 2:
         int [] m_p = {0,0};
         hs1.update(m_p);
         hs1.display();
         curr_game.draw_game();
         //println("h players " + curr_event.home.size());
         //println("v players " + curr_event.visitor.size());
         
          draw_event(m_p);
    }
  }
}

void draw_event(int[] m_p)
{
    println("1"); 
    initialize_event(curr_game, curr_id, curr_event);
    println("2");
    curr_event.draw_game_event(m_p);         
}