/// @description __znet_client_entity_destroy(name);
/// @param name

var entity_name = argument0;

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
        
        return true;
    
    }

}

return false;
