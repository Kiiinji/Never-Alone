/// @description znet_entity_set_keys(entity_name, entity_keys,...);
/// @param entity_name
/// @param  entity_keys
/// @param ...

/*

    Sets keys for the specified entity.
    
    entity_name = Name of the entity to set the keys for.
    entity_keys = List of keys to set. (e.g znet_entity_set_keys("player_1", "x", 320, "y", 240, "hp", 100))
    
    Returns: "true" if the entity was found and the keys were successfully set, or "false" if it failed.

*/

var entity_name = argument[0];

var keys = ds_list_create();
for(var i = 1; i < argument_count; i += 2){

    if(is_string(argument[i])){

        if(i + 1 < argument_count){
        
            ds_list_add(keys, argument[i], argument[i + 1]);
        
        }
    
    }

}

var key_string = ds_list_write(keys);
ds_list_destroy(keys);

if(instance_exists(obj_znet_server)){

    with(obj_znet_server){
    
        return __znet_server_entity_set_keys(entity_name, key_string);
    
    }

}else{
    
    var client_id = instance_find(obj_znet_client, 0);
    if(client_id != noone){
    
        with(client_id){
        
            buffer_seek(znet_client_buffer, buffer_seek_start, 0);
            buffer_write(znet_client_buffer, buffer_bool, true);
            buffer_write(znet_client_buffer, buffer_bool, true);
            buffer_write(znet_client_buffer, buffer_string, "entity_set_keys");
            buffer_write(znet_client_buffer, buffer_string, entity_name);
            buffer_write(znet_client_buffer, buffer_string, key_string);
            
            network_send_packet(znet_client_socket, znet_client_buffer, buffer_tell(znet_client_buffer));
        
        }
        
        return true;
    
    }

}

return false;
