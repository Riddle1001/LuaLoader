-- Scraped by chicken
-- Author: BaumFX
-- Title [Release] Trashtalk (with p talk skills)
-- Forum link https://aimware.net/forum/thread/86327

local Kill_String = {

 [1] = 'The only thing lower than your k/d ratio is your I.Q.'
 [2] = 'Your aim is so poor that people held a fundraiser for it'
 [3] = 'The only thing more unreliable than you is the condom your dad used.'
 [4] = 'Calling you a retard is a compliment in comparison to how stupid you actually are.'
 [5] = 'I didnt know dying was a special ability.'
 [6] = 'How many tries did it take for you to click the install button?'
 [7] = 'If I jumped from your ego to your intelligence, Id die of starvation half-way down.'
 [8] = 'When I die I want you to to lower me in my grave so you can let me down one more time.'
 [9] = 'I would kill myself to get away from you, but you would probably follow me.'
 [10] = 'Studies show that aiming gives you better chances of hitting your target.'
 [11] = 'You should let your chair play, at least it knows how to support.'
 [12] = 'There are about 37 trillion cells working together in your body right now, and you are disappointing every single one of them.'
 [13] = 'Id call you a tool, but that would imply you were useful in at least one way.'
 [14] = 'Youre the human equivalent of a participation award.'
 [15] = 'Id love to see things from your perspective, but I dont think I could shove my head that far up my ass.'
 [16] = 'Im not trash talking, Im talking to trash'
 [17] = 'Stephen Hawking has better hand-eye coordination than you.'
 [18] = 'Legend has it that the number 0 was first invented after scientists calculated your chance of doing something useful.'
 [19] = 'Youre the type of player to get 3rd place in a 1v1 match'
 [20] = 'Im not saying I hate you, but I would unplug your life support to charge my phone.'
 [21] = 'Youre an inspiration for birth control.'
 [22] = 'Does your ass ever get jealous of the amount of shit that comes out of your mouth'
 [23] = 'You should turn the game off. Just walk outside and find the nearest tree, then apologise to it for wasting so much oxygen.'
 [24] = 'Id tell you to shoot yourself, but I bet youd miss'
 [25] = 'Did you know sharks only kill 5 people each year? Looks like you got some competition'
 [26] = 'Some babies were dropped on their heads but you were clearly thrown at a wall'
 [27] = 'To which foundation do I need to donate to help you?'
 [28] = 'Im sure your bodypillow is very proud of you.'
 [29] = 'Calling you a retard is a compliment in comparison to how stupid you actually are.'
 [30] = 'Two wrongs dont make a right, take your parents as an example.'
 [31] = 'I bet the last time u felt a breast was in a kfc bucket'
 [32] = 'Maybe God made you a bit too special.'
 [33] = 'I bet your brain feels as good as new, seeing that you never use it.'
 [34] = 'If it wasnt for gravity you couldnt even hit the fucking ground'
 [35] = 'It must be difficult for you, exhausting your entire vocabulary in one sentence.'
 [36] = 'You could be the only person in the game and still manage to die.'
 [37] = 'You have some big balls on you. Too bad they belong to the guy fucking you from behind.'
 [38] = 'If only you could hit an enemy as much as your dad hits you.'
 [39] = 'Christopher Columbus has better map awareness than you'
 [40] = 'Your aim is proof that excessive masturbation causes blindness'
 [41] = 'You could shoot at the ground and still miss'
 [42] = 'Im jealous of people that dont know you.'
 [43] = 'Im surprised that you were able hit the Install button'
 [44] = 'Some people get paid to suck, you do it for free.'
 [45] = 'I would ask you how old you are but I know you cant count that high.'
 [46] = 'Friendly fire was invented because of you'
 [47] = 'Im okay with this team. I work in the city as a garbage collector. Im used to carrying trash.'
 [48] = 'Your as dense as a brick, but honestly a less useful one.'
 [49] = 'Id call you cancer, but at least cancer gets kills.'
 [50] = 'You said you were gonna go have sex, so why do you smell like rotten flesh?'
 [51] = 'Who set the bots to passive?'
 [52] = 'Youre the reason abortion was legalized'
}
local Death_String = 'nice luck';

function CHAT_KillSay( Event )

  if ( Event:GetName() == 'player_death' ) then

    local ME = client.GetLocalPlayerIndex();

    local INT_UID = Event:GetInt( 'userid' );
    local INT_ATTACKER = Event:GetInt( 'attacker' );

    local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
    local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

    local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
    local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

    if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then

     random = math.random (0, 50)
      client.ChatSay( ' ' .. NAME_Victim .. ' ' .. tostring( Kill_String[random] ) );


    elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME ) then

      client.ChatSay( ' ' .. tostring( Death_String ) .. ' ' .. NAME_Attacker );

    end
  
  end

end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );