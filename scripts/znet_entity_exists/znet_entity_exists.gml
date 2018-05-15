/// @description znet_entity_exists(entity_name);
/// @param entity_name

/*

    Checks if the specified entity exists.
    
    entity_name = Name of the entity.
    
    Returns: "true" if the entity exists, or "false" if not.

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
            
            return (ind != -1);
        
        }
    
    }

}

return false;
