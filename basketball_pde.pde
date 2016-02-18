//TODO: Map moment to players and ball


import java.util.*;
Table   gamestable, 
  eventstable, 
  playerstable, 
  teamstable;
Court  court;
Ball   ball;
Clock  clock;
Player []  home, 
  visitor;
ArrayList<Integer> moments;
HScrollbar hs1;  // Two scrollbars      
ArrayList<Double> ball_heights, 
  bpx, 
  bpy, 
  posx, 
  posy;


void setup()
{
  size(800, 800);      // always go first

  surface.setResizable(true);
  home = new Player[5];
  visitor = new Player[5];

  smooth();

  court = new Court();

  clock = new Clock();
  home = new Player[5];
  visitor = new Player[5];

  Game game = new Game();
  load_games(game);
  
  println(dataPath(""));
  File dir = new File(dataPath("") + "/games/00" + game.gameid+"/");
  println(dir);
  File[] filesList = dir.listFiles();
  Arrays.sort(filesList, 
    new Comparator<File>(){
      public int compare(File a, File b){
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
        load_event(game, file.getName());
     }
  }
  
  playerstable = loadTable("players.csv", "header");       // list of teams

  surface.setResizable(true);

  hs1 = new HScrollbar(0, height - 30, width, 16, 16);
}

void load_games(Game game)
{
  //PROCESS DATA
  gamestable = loadTable("games.csv", "header"); // list of games

  int gameid = 0, hometeamid = 0, visitorteamid = 0;
  for (TableRow row : gamestable.rows()) 
  {        
    gameid = row.getInt("gameid");                    // load gameid
    hometeamid = row.getInt("hometeamid");           // load home team id
    visitorteamid = row.getInt("visitorteamid");     // load visitor team id

    println("This game has an ID of " + gameid);
    break;
  }
  teamstable = loadTable("team.csv", "header");           // list of teams

  String  ht_name = new String(), 
    ht_abbr = new String(), 
    vt_name = new String(), 
    vt_abbr = new String();
  for (TableRow row : teamstable.rows()) 
  {        
    if (row.getInt("teamid") == hometeamid)
    {
      ht_name = row.getString("name");
      ht_abbr = row.getString("abbreviation");
    }
    if (row.getInt("teamid") == visitorteamid)
    {
      vt_name = row.getString("name");
      vt_abbr = row.getString("abbreviation");
    }
  }

  println("The home team: " + ht_name + ", "+  ht_abbr);
  println("The visitor team: " + vt_name + ", "+  vt_abbr);

  game.set_game(gameid,hometeamid,visitorteamid,ht_name,ht_abbr,vt_name,ht_abbr);
}

void load_event(Game game, String eventid)
{
  eventstable = loadTable("/games/00" + game.gameid + "/" + eventid);   //load an event

  int h_cnt = 0, v_cnt = 0, pid; 

  ball_heights = new ArrayList<Double>();
  bpx = new ArrayList<Double>();
  bpy = new ArrayList<Double>();
  int moment_cnt = 0;
  Set pids = new HashSet<Integer>();
  for (TableRow row : eventstable.rows()) 
  {     
    if (row.getInt(6) != moment_cnt)                             // iterate through moments
    {
      if (row.getInt(1) == -1 && row.getInt(2) == -1)            //check if this point has ball update
      {
        ball_heights.add(moment_cnt, (double)row.getInt(5));
        bpx.add(moment_cnt, (double)row.getInt(3));
        bpy.add(moment_cnt, (double)row.getInt(4));
      } else {
        ball_heights.add(moment_cnt, (double)-1.0);
        bpx.add(moment_cnt, (double)-1.0);
        bpy.add(moment_cnt, (double)-1.0);
      }
      moment_cnt++;
    }
    if (row.getInt(1) != -1 && row.getInt(2) != -1)            //ball is not there, want moment to be -1
    {
      pids.add(row.getInt(2)); // add player ids
    }
  }
  Iterator<Integer> it = pids.iterator();

  int curr = it.next();
  int tid = 0, hct = 0, vct = 0;
  do
  {
    ArrayList playerx = new ArrayList<Float>(), playery = new ArrayList<Float>();
    for (TableRow row : eventstable.rows()) 
    {        
      if (row.getInt(2) == curr && row.getInt(2) != -1) {
        //println(row.getFloat(3));
        playerx.add(row.getFloat(3));
        playery.add(row.getFloat(4));
        tid = row.getInt(1);
      }
    }
    if (tid == game.hometeamid) {
      home[hct] = new Player(playerx, playery, 0, 255, 0, 0);
      hct++;
    } else 
    {
      visitor[vct] = new Player(playerx, playery, 0, 0, 0, 255);
      vct++;
    }

    curr = it.next();
  }
  while (it.hasNext());
  ArrayList playerx = new ArrayList<Float>(), playery = new ArrayList<Float>();

  for (TableRow row : eventstable.rows()) 
  {        
    if (row.getInt(2) == curr && row.getInt(3) != -1) {
      playerx.add(row.getFloat(3));
      playery.add(row.getFloat(4));
      tid = row.getInt(1);
    }
  }


  if (tid == game.hometeamid) {
    home[hct] = new Player(playerx, playery, 0, 255, 0, 0);
    hct++;
  } else {
    visitor[vct] = new Player(playerx, playery, 0, 0, 0, 255);
    vct++;
  }
  double max_height = Collections.max(ball_heights);

  println(Arrays.toString(pids.toArray()));

  ball = new Ball(bpx, bpy, ball_heights, 0, max_height);///, moments);

  println("max ball height: " + max_height);
 
}

int [] m_p= {0, 0};
void draw() 
{
}

void draw_game_event()
{
  clear();
  court.display();

  //clock.display();

  hs1.update(m_p);
  hs1.display();

  for (int i = 0; i < 5; i++)
  {
    home[i].update(m_p);
    home[i].display();
    visitor[i].update(m_p);
    visitor[i].display();
  }

  ball.update(m_p);
  ball.display();

  stroke(0);
  line(0, height - 30, width, height - 30);
}