/// @description znet_server_get_sockets(server_id);
/// @param server_id

/*
    
    Returns an array of all the sockets that are connected.
    
    server_id = Id of the server object.
    
    Returns: Array of all connected client sockets, or "undefined" if it failed.

*/

var _id = argument0;

if(instance_exists(_id)){

    if(_id.object_index == obj_znet_server){
    
        with(_id){
        
            var size = ds_list_size(znet_socket_list);
            
            if(size <= 0)
                return undefined;
                
            var list;
            for(var i = 0; i < size; i++)
                list[i] = znet_socket_list[| i];
                
            return list;
        
        }
    
    }

}

return undefined;
