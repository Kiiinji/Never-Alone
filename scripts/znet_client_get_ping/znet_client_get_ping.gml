/// @description znet_client_get_ping(client_id);
/// @param client_id

/*

    Gets the ping of the specified client.
    
    client_id = Id of the client object.
    
    Returns: Ping of client, or -1 if something failed.

*/

var client_id = argument0;
if(instance_exists(client_id)){

    if(client_id.object_index = obj_znet_client){
    
        if(client_id.znet_client_state == "client_connected")
            return client_id.znet_client_ping;
        
    }

}

return -1;
