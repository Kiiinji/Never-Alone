/// @description znet_packet_check(server_id/client_id);
/// @param server_id/client_id

/*

    Checks for incoming packets. Used in the networking event.
    
    server_id/client_id = What server/client object to check for incoming packets.
    
    Returns: Id of the socket who sent the packet, or "undefined" if something failed.

*/

var _id = argument0;

if(async_load[? "type"] == network_type_data){
    
    var buffer = async_load[? "buffer"];
    buffer_seek(buffer, buffer_seek_start, 0);
    
    if(instance_exists(_id)){
        
        if(_id.object_index == obj_znet_server){
        
            with(_id){
            
                if(buffer_read(buffer, buffer_bool) && !buffer_read(buffer, buffer_bool))
                    return async_load[? "id"];
        
            }
        
        }else if(_id.object_index == obj_znet_client){
        
            with(_id){
        
                if(!buffer_read(buffer, buffer_bool) && !buffer_read(buffer, buffer_bool))
                    return znet_client_socket;
        
            }
        
        }
    
    }
    
    buffer_seek(buffer, buffer_seek_start, 0);

}

return undefined;
