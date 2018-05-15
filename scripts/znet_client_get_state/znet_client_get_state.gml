/// @description znet_client_get_state(client_id);
/// @param client_id

/*

    Gets the current the state of the specified client.
    
    client_id = Id of the client object.
        
    Returns: Current state of client.
        "client_connecting"    - Client is connecting to the server.
        "client_connected"     - Client is connected to the server.
        "client_timeout"       - Connection has timed out.
        "client_server_full"   - Server is full.
        "client_wrong_version" - Versions of client and server are not the same.
        "client_invalid"       - Invalid client id specified.

*/

var client_id = argument0;
if(instance_exists(client_id)){

    if(client_id.object_index = obj_znet_client)
        return client_id.znet_client_state;

}

return "client_invalid";
