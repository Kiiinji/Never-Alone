/// @description __znet_server_entity_attach_client(entity_name, client_id);
/// @param entity_name
/// @param  client_id

var entity_name = argument0;
var client_id = argument1;

for(var i = 0; i < ds_list_size(znet_entity_list); i++){

    var entity_type_list = znet_entity_list[| i];
    var entity_type_name = entity_type_list[| 0];
    var entity_type_map = entity_type_list[| 1];
    
    var ind = ds_list_find_index(entity_type_name, entity_name);
    
    if(ind != -1){
    
        entity_type = znet_entity_type_list[| i];
        var entity_map = entity_type_map[| ind];
        
        entity_map[? "znet_entity_client"] = client_id;
        
        return true;
    
    }

}

return false;
