/// @description znet_server_get_connected_socket(server_id);
/// @param server_id

/*

    Checks if a new socket has connected and returns the id of it. Used in the networking event.
    
    server_id = Id of the server object.
    
    Returns: Id of socket, or "undefined" if no new socket has connected or if something failed.

*/

if(async_load[? "type"] == network_type_connect){

    var server_id = argument0;
    if(instance_exists(server_id)){
    
        if(server_id.object_index == obj_znet_server){
    
            with(server_id){
        
                if(ds_list_size(znet_socket_list) < znet_max_clients)
                    return async_load[? "socket"];
            
            }
        
        }
    
    }

}

return undefined;
