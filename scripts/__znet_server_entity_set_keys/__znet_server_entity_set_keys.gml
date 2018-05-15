/// @description __znet_server_entity_set_keys(name, keys);
/// @param name
/// @param  keys

var entity_name = argument0;
var entity_keys = argument1;

var entity_type = "";

var ret = false;

for(var i = 0; i < ds_list_size(znet_entity_list); i++){

    var entity_type_list = znet_entity_list[| i];
    var entity_type_name = entity_type_list[| 0];
    var entity_type_map = entity_type_list[| 1];
    
    var ind = ds_list_find_index(entity_type_name, entity_name);
    
    if(ind != -1){
    
        entity_type = znet_entity_type_list[| i];
        var entity_map = entity_type_map[| ind];
        
        var keys = ds_list_create();
        ds_list_read(keys, entity_keys);
        
        for(var j = 0; j < ds_list_size(keys); j += 2)
            entity_map[? keys[| j]] = keys[| j + 1];
        
        ds_list_destroy(keys);
        
        ret = true;
        break;
    
    }

}

if(ret){

    buffer_seek(znet_server_buffer, buffer_seek_start, 0);
    buffer_write(znet_server_buffer, buffer_bool, false);
    buffer_write(znet_server_buffer, buffer_bool, true);
    buffer_write(znet_server_buffer, buffer_string, "entity_set_keys");
    buffer_write(znet_server_buffer, buffer_string, entity_type);
    buffer_write(znet_server_buffer, buffer_string, entity_name);
    buffer_write(znet_server_buffer, buffer_string, entity_keys);
    
    for(var i = 0; i < ds_list_size(znet_socket_list); i++){
    
        network_send_packet(znet_socket_list[| i], znet_server_buffer, buffer_tell(znet_server_buffer));
    
    }

}

return ret;
