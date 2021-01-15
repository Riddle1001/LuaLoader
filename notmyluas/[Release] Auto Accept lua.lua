-- Scraped by chicken
-- Author: Clipper
-- Title [Release] Auto Accept lua
-- Forum link https://aimware.net/forum/thread/128126

panorama.RunScript([[
  function autoaccept() {
    $.Schedule(1, autoaccept)

    if (!LobbyAPI.IsSessionActive() || LobbyAPI.GetReadyTimeRemainingSeconds() == 0) {
      return;
    }

    LobbyAPI.SetLocalPlayerReady('accept');
  }

  autoaccept();
]])