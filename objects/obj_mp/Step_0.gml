//Host/Join menu.
if(piloy == 0){

    //Checks if we press the 'H' key for hosting.
    if(keyboard_check_pressed(ord("H"))){
    
        //Specifies an ip and a port.
        var ip = get_string("IP:", "127.0.0.1");
        var port = get_integer("Port:", 5600);
    
        //Starts a new server on the specified port with a max of 8 players.
        //We also specify a version number for the server, which will be used to check if the clients has the same version as the server. 
        server = znet_server_create(port, 2, "1.0.0");
        
        //Checks if the server was successfully created and creates a client for our player and connects it to the server.
        if(server != -1)
            client = znet_client_create(ip, port, "1.0.0");
        
        //Checks if both the server and the client was successfully created or not.
        if(server >= 0 && client >= 0){
        
            //Goes to the "connected" menu.
            piloy = 2;
        
        }else{
        
            //Displays an error message.
            show_message("Unable to create server!");
        
        }
    
    //Checks if we press the 'J' key for joining.
    }else if(keyboard_check_pressed(ord("J"))){
    
        //Goes to the "connecting" menu.
        piloy = 1;
    
    }

//Connecting menu.
}else if(piloy == 1){

    //Specifies an ip and a port.
    var ip = get_string("IP:", "127.0.0.1");
    var port = get_integer("Port:", 5600);

    //Creates a client for our player and tries to connect to the server.
    client = znet_client_create(ip, port, "1.0.0");
        
    //Checks if the client successfully connected to the server or not.
    if(client >= 0){
    
        //Goes to the "connected" menu.
        piloy = 2;
    
    }else{
    
        //Displays an error message and goes back to the "host/join" menu.
        show_message("Unable to connect to server!");
        piloy = 0;
    
    }

//Connected menu.
}else if(piloy == 2){

    //Checks if the client has lost connection to the server or not.
    if(znet_client_get_state(client) == "client_timeout"){
    
        //Displays an error message and goes back to the "host/join" menu.
        show_message("Lost connection to server!");
        piloy = 0;
        
        //Destroyes our client and frees it up from memory.
        znet_client_destroy(client);
    
    }else{
    
        //Checks if the server is already full or not.
        if(znet_client_get_state(client) == "client_server_full"){
    
            //Displays an error message and goes back to the "host/join" menu.
            show_message("Server is full!");
            piloy = 0;
            
            //Destroyes our client and frees it up from memory.
            znet_client_destroy(client);
        
        }else{
    
            //Checks if we press the 'S' key.
            if(keyboard_check_pressed(ord("S"))){
            
                //Goes to the game room.
                piloy = 3;
                room_goto(depart01);
                
                //Creates a new player entity and sets the 'x' and 'y' positions.
                znet_entity_create("player", nickname, "x", 0, "y", 0);
                
                //Attaches the player entity to our client.
                //Doing this will make sure that the client gets destroyed when the client disconnects.
                znet_entity_attach_client(nickname, client);
            
            }
        
        }
    
    }

//Game room.
}else if(piloy == 3){

    //Checks if the client has lost connection to the server or not.
    if(znet_client_get_state(client) == "client_timeout"){
    
        //Displays an error message and goes back to the "host/join" menu.
        show_message("Lost connection to server!");
        piloy = 0;
        room_goto(rm_menu);
        
        ////Destroyes our client and frees it up from memory.
        znet_client_destroy(client);
    
    }else{
    
        //Updates the 'x' and 'y' positions for our player.
        znet_entity_set_keys(nickname, "x", obj_player.x, "y", obj_player.y);
    
    }

}

