/// @description znet_client_destroy(client_id);
/// @param client_id

/*

    Disconnects the specified client from the server and frees it from memory.
    
    client_id = Id of the client object.
        
    Returns: "true" if the client was successfully destroyed, or "false" if it failed.

*/

var client_id = argument0;
if(instance_exists(client_id)){

    if(client_id.object_index = obj_znet_client){

        with(client_id)
            instance_destroy();
            
        return true;
        
    }

}

return false;
