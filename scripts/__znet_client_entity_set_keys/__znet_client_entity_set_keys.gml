/// @description __znet_client_entity_set_keys(type, name, keys);
/// @param type
/// @param  name
/// @param  keys

var entity_type = argument0;
var entity_name = argument1;
var entity_keys = argument2;

var ind = ds_list_find_index(znet_entity_type_list, entity_type);

if(ind != -1){

    var entity_type_list = znet_entity_list[| ind];
    var entity_type_name = entity_type_list[| 0];
    var entity_type_map = entity_type_list[| 1];
    
    ind = ds_list_find_index(entity_type_name, entity_name);
    
    if(ind != -1){
    
        var entity_map = entity_type_map[| ind];
        
        var keys = ds_list_create();
        ds_list_read(keys, entity_keys);
        
        for(var j = 0; j < ds_list_size(keys); j += 2)
            entity_map[? keys[| j]] = keys[| j + 1];
        
        ds_list_destroy(keys);
    
    }

}
