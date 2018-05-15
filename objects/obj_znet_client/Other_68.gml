if(async_load[? "type"] == network_type_data){

    var buffer = async_load[? "buffer"];
    buffer_seek(buffer, buffer_seek_start, 0);
    
    if(!buffer_read(buffer, buffer_bool)){
        
        if(buffer_read(buffer, buffer_bool)){
        
            switch(buffer_read(buffer, buffer_string)){
            
                case "client_timeout":
                
                    znet_timeout_check = false;
                    znet_timeout_wait = true;
                    znet_timeout_wait_timer = znet_timeout_wait_timer_max;
                    
                break;
                
                case "client_ping":
                
                    var time = buffer_read(buffer, buffer_u16);
                    znet_client_ping = (current_time - time);
                
                break;
                
                case "client_init":
                
                    var version = buffer_read(buffer, buffer_string);
                    if(version == znet_client_version){
                
                        znet_client_id = buffer_read(buffer, buffer_u16);
                        znet_client_state = "client_connected";
                    
                        repeat(buffer_read(buffer, buffer_u16)){
                        
                            var entity_type = buffer_read(buffer, buffer_string);
                            var entity_name = buffer_read(buffer, buffer_string);
                            var entity_key = buffer_read(buffer, buffer_string);
                            
                            __znet_client_entity_create(entity_type, entity_name, "", entity_key);
                        
                        }
                    
                    }else{
                    
                        znet_client_state = "client_wrong_version";
                        
                        network_destroy(znet_client_socket);
                        znet_client_socket = -1;
                    
                    }
                
                break;
                
                case "client_full":
                
                    znet_client_state = "client_server_full";
                    
                    network_destroy(znet_client_socket);
                    znet_client_socket = -1;
                
                break;
                
                case "entity_create":
                
                    var entity_type = buffer_read(buffer, buffer_string);
                    var entity_name = buffer_read(buffer, buffer_string);
                    var entity_keys = buffer_read(buffer, buffer_string);
                    
                    __znet_client_entity_create(entity_type, entity_name, entity_keys);
                
                break;
                
                case "entity_destroy":
                
                    var entity_name = buffer_read(buffer, buffer_string);
                    
                    __znet_client_entity_destroy(entity_name);
                
                break;
                
                case "entity_set_keys":
                
                    var entity_type = buffer_read(buffer, buffer_string);
                    var entity_name = buffer_read(buffer, buffer_string);
                    var entity_keys = buffer_read(buffer, buffer_string);
                    
                    __znet_client_entity_set_keys(entity_type, entity_name, entity_keys);
                
                break;
            
            }
        
        }else{
        
        }
    
    }

}

