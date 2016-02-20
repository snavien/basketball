class Game
{
  int gameid = 0, hometeamid = 0, visitorteamid = 0;
  
  String  ht_name,
           ht_abbr,
           vt_name,
           vt_abbr,
           gamedate;
  int e_cnt;
  //LinkedHashMap<String, Event> events;
  ArrayList<String> eventlist;
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
    vt_abbr = vta;
    //events = new LinkedHashMap<String, Event>();
    eventlist = new ArrayList<String>();
    gamedate = gd;
  }
  void add_event(String k)
  {
    eventlist.add(k);
    //events.put(k, new Event(k));
  }
  void draw_game()
  {
    clear();
    court.display();
  }
  

}  