draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//Draws the different menus.

//Host/Join menu.
if(piloy == 0){
    
    draw_text(room_width / 2, 128, string_hash_to_newline("Multijoueur Beta"));
    draw_text(room_width / 2, room_height / 2, string_hash_to_newline("Appuyez sur H pour héberger.##Appuyez sur J pour rejoindre."));

//Connecting menu.
}else if(piloy == 1){

    draw_text(room_width / 2, room_height / 2, string_hash_to_newline("Connexion..."));

//Connected menu.
}else if(piloy == 2){

    draw_text(room_width / 2, room_height / 2, string_hash_to_newline("Connecté au serveur !##Pseudo:#" + nickname));
    draw_text(room_width / 2, room_height - 64, string_hash_to_newline("Appuyez sur 'S' pour commencer."));

//Game room.
}else if(piloy == 3){

    draw_set_color(c_red);
    
    //Draws the ping.

    //Draws the players.
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);

    //Gets a list of all the player entities in the game.
    var players = znet_entity_get_list("player");
    
    //Checks if there actually are any player entities connected.
    if(players != undefined){
    
        //Loops through all the players.
        for(var i = 0; i < array_length_1d(players); i++){
        
            //Makes sure that we are only drawing the other players and not ourself.
            if(players[i] != nickname){
            
                //Gets the x and y position of the player.
                var px = znet_entity_get_key(players[i], "x");
                var py = znet_entity_get_key(players[i], "y");
				
				var touch = znet_entity_get_key(players[i], "touch");
            
                //Draws the player sprite and name.
				if(touch == 1)
					draw_sprite(sprite_testright, 0, px, py);
				if(touch == 2)
					draw_sprite(sprite_testleft, 0, px, py);
				if(touch == 3)
					draw_sprite(sprite_testup, 0, px, py);
				if(touch == 4)
					draw_sprite(sprite_testdown, 0, px, py);
                draw_text(px, py - 40, string_hash_to_newline(players[i]));
            
            }
        
        }
    
    }
    
    //Draws the name of our player.
    draw_text(obj_player.x, obj_player.y - 40, string_hash_to_newline(nickname));

}

