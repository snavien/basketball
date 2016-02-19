class Game
{
  int gameid = 0, hometeamid = 0, visitorteamid = 0;
  
  String  ht_name,
           ht_abbr,
           vt_name,
           vt_abbr,
           gamedate;
  int e_cnt;
  ArrayList<Event> events;
  Event currevent;
  Game(){
    
  }
  Game(int gid, int htid, int vtid, String htn, String hta, String vtn,String vta, String gd)
  {
    gameid = gid;
    hometeamid = htid;
    visitorteamid = vtid;
  
    ht_name = htn;
    ht_abbr = hta;
    vt_name = vtn;
    vt_abbr  = vta; 
    events = new ArrayList<Event>();
    gamedate = gd;
  }
  
  void set_curr(int index)
  {
    currevent = events.get(index); 
  }
  
  void add_event(Event e)
  {
    events.add(e);
  }
  void draw_game()
  {
    clear();
    court.display();
  }
  

}  