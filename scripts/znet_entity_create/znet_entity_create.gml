/// @description znet_entity_create([entity_type], [entity_name], [entity_keys,...]);
/// @param [entity_type]
/// @param  [entity_name]
/// @param  [entity_keys
/// @param ...]

/*

    Creates a new entity.
    
    entity_type(optional) = What type of entity it is. (e.g "player", "npc", "enemy", etc...)
    entity_name(optional) = Name of the entity. Used as an identifier.
    entity_keys(optional) = Set keys for the entity. (e.g znet_entity_create("player", "player_0", "x", 0, "y", 0, "hp", 100))
    
    Returns: "true" if the entity was successfully created, or "false" if it failed.

*/

var entity_type = "";
var entity_name = "";

if(argument_count > 0)
    entity_type = argument[0];

if(argument_count > 1)
    entity_name = argument[1];
    
var keys = ds_list_create();
for(var i = 2; i < argument_count; i += 2){

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
    
        __znet_server_entity_create(entity_type, entity_name, key_string);
    
    }
    
    return true;

}else{
    
    var client_id = instance_find(obj_znet_client, 0);
    if(client_id != noone){
    
        with(client_id){
        
            buffer_seek(znet_client_buffer, buffer_seek_start, 0);
            buffer_write(znet_client_buffer, buffer_bool, true);
            buffer_write(znet_client_buffer, buffer_bool, true);
            buffer_write(znet_client_buffer, buffer_string, "entity_create");
            buffer_write(znet_client_buffer, buffer_string, entity_type);
            buffer_write(znet_client_buffer, buffer_string, entity_name);
            buffer_write(znet_client_buffer, buffer_string, key_string);
            
            network_send_packet(znet_client_socket, znet_client_buffer, buffer_tell(znet_client_buffer));
        
        }
        
        return true;
    
    }

}

return false;
