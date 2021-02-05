-- Scraped by chicken
-- Author: Squiddler
-- Title [Release] Hide Menu
-- Forum link https://aimware.net/forum/thread/110640

callbacks.Register('Draw', function()
  gui.SetValue('vis_antiobs', gui.Reference("MENU"):IsActive() and 1 or 0);
end)

