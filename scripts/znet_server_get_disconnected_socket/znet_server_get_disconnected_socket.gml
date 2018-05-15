/// @description znet_server_get_disconnected_socket(server_id);
/// @param server_id

/*

    Checks if a socket has disconnected and returns the id of it. Used in the networking event.
    
    server_id = Id of the server object.
    
    Returns: Id of socket, or "undefined" if no socket has disconnected or if something failed.

*/

if(async_load[? "type"] == network_type_disconnect){

    var server_id = argument0;
    if(instance_exists(server_id)){
    
        if(server_id.object_index == obj_znet_server){
    
            with(server_id){
        
                var socket = async_load[? "socket"];
                if(ds_list_find_index(znet_socket_list, socket) != -1 || znet_last_disconnected == socket)
                    return socket;
            
            }
        
        }
    
    }

}

return undefined;
