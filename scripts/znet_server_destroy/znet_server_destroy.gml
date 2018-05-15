/// @description znet_server_destroy(server_id);
/// @param server_id

/*

    Stops the specified server and frees it from memory.
    
    server_id = Id of the server object.
        
    Returns: "true" if the server was successfully destroyed, or "false" if it failed.

*/

var server_id = argument0;
if(instance_exists(server_id)){

    if(server_id.object_index == obj_znet_server){

        with(server_id)
            instance_destroy();
            
        return true;
        
    }

}

return false;
