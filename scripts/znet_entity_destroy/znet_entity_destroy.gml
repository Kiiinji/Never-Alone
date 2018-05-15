/// @description znet_entity_destroy(entity_name);
/// @param entity_name

/*

    Destroyes the specified entity.
    
    entity_name = Name of the entity to destroy.
    
    Returns: "true" if the entity was found and destroyed, or "false" if it failed.

*/

var entity_name = argument0;
    
if(instance_exists(obj_znet_server)){

    with(obj_znet_server){
    
        return __znet_server_entity_destroy(entity_name);
    
    }

}else{
    
    var client_id = instance_find(obj_znet_client, 0);
    if(client_id != noone){
    
        with(client_id){
        
            buffer_seek(znet_client_buffer, buffer_seek_start, 0);
            buffer_write(znet_client_buffer, buffer_bool, true);
            buffer_write(znet_client_buffer, buffer_bool, true);
            buffer_write(znet_client_buffer, buffer_string, "entity_destroy");
            buffer_write(znet_client_buffer, buffer_string, entity_name);
            
            network_send_packet(znet_client_socket, znet_client_buffer, buffer_tell(znet_client_buffer));
        
        }
        
        return true;
    
    }

}

return false;
