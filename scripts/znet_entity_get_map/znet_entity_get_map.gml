/// @description znet_entity_get_map(entity_name);
/// @param entity_name

/*

    Gets the ds_map of the specified entity.
    Instead of using "znet_entity_get_key", you can retrive the map only once and read directly from it.
    This is a lot faster as it doesn't have to search for the map every time you want to read a key.
    
    NOTE: Setting values directly using the map will only update it client-side.
          Use "znet_entity_set_keys" instead.
    
    entity_name = Name of the entity to get the map from.
    
    Returns: Entity map, or "undefined" if the entity doesn't exist.

*/

var entity_name = argument0;

var inst = noone;

if(instance_exists(obj_znet_server)){

    inst = obj_znet_server;

}else{
    
    inst = instance_find(obj_znet_client, 0);

}
        
if(inst != noone){

    with(inst){
    
        for(var i = 0; i < ds_list_size(znet_entity_list); i++){

            var entity_type_list = znet_entity_list[| i];
            var entity_type_name = entity_type_list[| 0];
            var entity_type_map = entity_type_list[| 1];
            
            var ind = ds_list_find_index(entity_type_name, entity_name);
            
            if(ind != -1){
            
                entity_type = znet_entity_type_list[| i];
                var entity_map = entity_type_map[| ind];
                
                return entity_map;
            
            }
        
        }
    
    }

}

return undefined;
