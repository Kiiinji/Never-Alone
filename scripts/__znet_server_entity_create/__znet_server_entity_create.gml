/// @description __znet_server_entity_create(type, name, keys);
/// @param type
/// @param  name
/// @param  keys

var entity_type = argument0;
var entity_name = argument1;
var entity_keys = argument2;

if(entity_type == "") entity_type = "znet_entity_default";
                    
var ind = ds_list_find_index(znet_entity_type_list, entity_type);

var entity_type_list, entity_type_name, entity_type_map;
if(ind == -1){

    entity_type_list = ds_list_create();
    
    entity_type_name = ds_list_create();
    entity_type_map = ds_list_create();

    ds_list_add(znet_entity_type_list, entity_type);
    ds_list_add(znet_entity_list, entity_type_list);
    
    ds_list_add(entity_type_list, entity_type_name);
    ds_list_add(entity_type_list, entity_type_map);

}else{

    entity_type_list = znet_entity_list[| ind];
    
    entity_type_name = entity_type_list[| 0];
    entity_type_map = entity_type_list[| 1];

}

ds_list_add(entity_type_name, entity_name);

var entity_map = ds_map_create();
ds_list_add(entity_type_map, entity_map);

entity_map[? "znet_entity_name"] = entity_name;
entity_map[? "znet_entity_client"] = -1;

if(entity_keys != ""){
    
    var keys = ds_list_create();
    ds_list_read(keys, entity_keys);
    
    for(var i = 0; i < ds_list_size(keys); i += 2){
    
        entity_map[? keys[| i]] = keys[| i + 1];
        
    }
    
    ds_list_destroy(keys);

}

buffer_seek(znet_server_buffer, buffer_seek_start, 0);
buffer_write(znet_server_buffer, buffer_bool, false);
buffer_write(znet_server_buffer, buffer_bool, true);
buffer_write(znet_server_buffer, buffer_string, "entity_create");
buffer_write(znet_server_buffer, buffer_string, entity_type);
buffer_write(znet_server_buffer, buffer_string, entity_name);
buffer_write(znet_server_buffer, buffer_string, entity_keys);

for(var i = 0; i < ds_list_size(znet_socket_list); i++){

    network_send_packet(znet_socket_list[| i], znet_server_buffer, buffer_tell(znet_server_buffer));

}
