/// @description __znet_server_entity_destroy(name);
/// @param name

var entity_name = argument0;

var ret = false;

for(var i = 0; i < ds_list_size(znet_entity_list); i++){

    var entity_type_list = znet_entity_list[| i];
    var entity_type_name = entity_type_list[| 0];
    var entity_type_map = entity_type_list[| 1];
    
    var ind = ds_list_find_index(entity_type_name, entity_name);
    
    if(ind != -1){
    
        var entity_map = entity_type_map[| ind];
        ds_map_destroy(entity_map);
    
        ds_list_delete(entity_type_name, ind);
        ds_list_delete(entity_type_map, ind);
        
        ret = true;
        break;
    
    }

}

if(ret){

    buffer_seek(znet_server_buffer, buffer_seek_start, 0);
    buffer_write(znet_server_buffer, buffer_bool, false);
    buffer_write(znet_server_buffer, buffer_bool, true);
    buffer_write(znet_server_buffer, buffer_string, "entity_destroy");
    buffer_write(znet_server_buffer, buffer_string, entity_name);
    
    for(var i = 0; i < ds_list_size(znet_socket_list); i++){
    
        network_send_packet(znet_socket_list[| i], znet_server_buffer, buffer_tell(znet_server_buffer));
    
    }

}

return ret;
