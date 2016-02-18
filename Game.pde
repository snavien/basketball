class Game
{
  int gameid = 0, hometeamid = 0, visitorteamid = 0;
  
  String  ht_name,
           ht_abbr,
           vt_name,
           vt_abbr;
  void set_game(int gid, int htid, int vtid, String htn, String hta, String vtn,String vta)
  {
    gameid = gid;
    hometeamid = htid;
    visitorteamid = vtid;
  
    ht_name = htn;
    ht_abbr = hta;
    vt_name = vtn;
    vt_abbr  = vta;
    
    
  }

}  