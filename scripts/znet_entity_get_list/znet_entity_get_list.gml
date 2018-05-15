/// @description znet_entity_get_list(entity_type);
/// @param entity_type

/*

    Returns an array of all the entities with the specified type.
    
    entity_type = The entity type to get the entities from.
    
    Returns: Array of all the entities with the specified type, or "undefined" if there are no entities.

*/

var entity_type = argument0;

var inst = noone;

if(instance_exists(obj_znet_server)){

    inst = obj_znet_server;

}else{
    
    inst = instance_find(obj_znet_client, 0);

}
        
if(inst != noone){

    with(inst){
 
        var ind = ds_list_find_index(znet_entity_type_list, entity_type);
        
        if(ind != -1){
        
            var entity_type_list = znet_entity_list[| ind];
            var entity_type_name = entity_type_list[| 0];
            
            var entities;
            if(ds_list_size(entity_type_name) > 0){
            
                for(var i = 0; i < ds_list_size(entity_type_name); i++)
                    entities[i] = entity_type_name[| i];
                
            }else{
            
                entities = undefined;
            
            }
                
            return entities;
        
        }
       
    }
    
}

return undefined;
