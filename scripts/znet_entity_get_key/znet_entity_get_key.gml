/// @description znet_entity_get_key(entity_name, entity_key);
/// @param entity_name
/// @param  entity_key

/*

    Gets the value of the specified entity key.
    
    entity_name = Name of the entity to get the key value from.
    entity_key = Name of the key.
    
    Returns: Value of the specified key, or "undefined" if it doesn't exist.

*/

var entity_name = argument0;
var entity_key = argument1;

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
                
                return entity_map[? entity_key];
            
            }
        
        }
    
    }

}

return undefined;
