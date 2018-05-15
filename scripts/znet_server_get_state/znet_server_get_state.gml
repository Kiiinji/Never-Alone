/// @description znet_server_get_state(server_id);
/// @param server_id

/*

    Gets current the state of the specified server.
    
    server_id = Id of the server object.
        
    Returns: Current state of the server.
        "server_open"    - Server has successfully started.
        "server_error"   - Server error occurred.
        "server_invalid" - Invalid server id specified.

*/

var server_id = argument0;
if(instance_exists(server_id)){

    if(server_id.object_index = obj_znet_server)
        return server_id.znet_server_state;

}

return "server_invalid";
