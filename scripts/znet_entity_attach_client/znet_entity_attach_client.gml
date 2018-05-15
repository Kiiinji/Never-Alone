/// @description znet_entity_attach_client(entity_name, client_id);
/// @param entity_name
/// @param  client_id

/*

    Attaches a client to an entity, meaning that when the client disconnects, the entity gets destroyed.
    This can be useful as trying to destroy an entity at the "Game End" event won't work.
    
    NOTE: Make sure that the state of the client is "client_connected" before attaching an entity.
    
    entity_name = Name of the entity to attach to the client.
    client_id   = Id of the client object.
    
    Returns: "true" if the entity was successfully attached to the client, or "false" if it failed.

*/

var entity_name = argument0;
var _id = argument1;

if(instance_exists(obj_znet_server)){

    with(obj_znet_server){
    
        return __znet_server_entity_attach_client(entity_name, _id.znet_client_id);
    
    }

}else{
    
    var client_id = instance_find(obj_znet_client, 0);
    if(client_id != noone){
    
        with(client_id){
        
            buffer_seek(znet_client_buffer, buffer_seek_start, 0);
            buffer_write(znet_client_buffer, buffer_bool, true);
            buffer_write(znet_client_buffer, buffer_bool, true);
            buffer_write(znet_client_buffer, buffer_string, "entity_attach_client");
            buffer_write(znet_client_buffer, buffer_string, entity_name);
            buffer_write(znet_client_buffer, buffer_u16, _id.znet_client_id);
            
            network_send_packet(znet_client_socket, znet_client_buffer, buffer_tell(znet_client_buffer));
        
        }
        
        return true;
    
    }

}

return false;
