/// @description znet_packet_write(server_id/client_id, type, value);
/// @param server_id/client_id
/// @param  type
/// @param  value

/*

    Writes a value to a packet.
    
    server_id/client_id = What server/client object to write the value to.
    type                = What type of value to be written. (e.g buffer_u8, buffer_f32, buffer_string, etc...)
    value               = The value to write into the packet.
    
    Returns: "true" if the value was successfully written, or "false" if it failed.

*/

var _id = argument0;
var type = argument1;
var value = argument2;

if(instance_exists(_id)){
    
    if(_id.object_index == obj_znet_server){
    
        with(_id){
        
            buffer_write(znet_server_buffer, type, value);
    
        }
            
        return true;
    
    }else if(_id.object_index == obj_znet_client){
    
        with(_id){
    
            buffer_write(znet_client_buffer, type, value);
    
        }
            
        return true;
    
    }

}

return false;
