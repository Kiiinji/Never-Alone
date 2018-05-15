/// @description znet_packet_clear(server_id/client_id);
/// @param server_id/client_id

/*

    Clears any previous sent packets.
    
    server_id/client_id = What server/client object to clear.
    
    Returns: "true" if the server/client object exists, or "false" if not.

*/

var _id = argument0;

if(instance_exists(_id)){

    if(_id.object_index == obj_znet_server){
    
        with(_id){
        
            buffer_seek(znet_server_buffer, buffer_seek_start, 0);
            buffer_write(znet_server_buffer, buffer_bool, false);
            buffer_write(znet_server_buffer, buffer_bool, false);
    
        }
            
        return true;
    
    }else if(_id.object_index == obj_znet_client){
    
        with(_id){
    
            buffer_seek(znet_client_buffer, buffer_seek_start, 0);
            buffer_write(znet_client_buffer, buffer_bool, true);
            buffer_write(znet_client_buffer, buffer_bool, false);
    
        }
            
        return true;
    
    }

}

return false;
