if(znet_client_socket >= 0)
    network_destroy(znet_client_socket);
    
if(buffer_exists(znet_client_buffer))
    buffer_delete(znet_client_buffer);
    
if(ds_exists(znet_entity_type_list, ds_type_list))
    ds_list_destroy(znet_entity_type_list);
    
if(ds_exists(znet_entity_list, ds_type_list)){

    for(var i = 0; i < ds_list_size(znet_entity_list); i++){
    
        var entity_type = znet_entity_list[| i];
        
        var entity_name = entity_type[| 0];
        var entity_map = entity_type[| 1];
        
        for(var j = 0; j < ds_list_size(entity_map); j++){
        
            ds_map_destroy(entity_map[| j]);
            
        }
        
        ds_list_destroy(entity_name);
        ds_list_destroy(entity_map);
        ds_list_destroy(entity_type);
    
    }

    ds_list_destroy(znet_entity_list);
    
}

