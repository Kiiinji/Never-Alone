with (obj_znet_server) {
switch(async_load[? "type"]){

    case network_type_connect:    
        
        var socket_id = async_load[? "socket"];
    
        if(ds_list_size(znet_socket_list) >= znet_max_clients){
        
            buffer_seek(znet_server_buffer, buffer_seek_start, 0);
            buffer_write(znet_server_buffer, buffer_bool, false);
            buffer_write(znet_server_buffer, buffer_bool, true);
            buffer_write(znet_server_buffer, buffer_string, "client_full");

            network_send_packet(socket_id, znet_server_buffer, buffer_tell(znet_server_buffer));
        
        }else{
        
            var _id = znet_socket_id_counter++;
            
            ds_list_add(znet_socket_list, socket_id);
            ds_list_add(znet_socket_id_list, _id);
            
            buffer_seek(znet_server_buffer, buffer_seek_start, 0);
            buffer_write(znet_server_buffer, buffer_bool, false);
            buffer_write(znet_server_buffer, buffer_bool, true);
            buffer_write(znet_server_buffer, buffer_string, "client_init");
            buffer_write(znet_server_buffer, buffer_string, znet_server_version);
            buffer_write(znet_server_buffer, buffer_u16, _id);
            
            var temp = ds_list_create();
            for(var i = 0; i < ds_list_size(znet_entity_list); i++){
            
                var entity_type_list = znet_entity_list[| i];
                var entity_type_name = entity_type_list[| 0];
                var entity_type_map = entity_type_list[| 1];
                
                for(var j = 0; j < ds_list_size(entity_type_map); j++){
                
                    ds_list_add(temp, znet_entity_type_list[| i], entity_type_name[| j], ds_map_write(entity_type_map[| j]));
                
                }
            
            }
            
            buffer_write(znet_server_buffer, buffer_u16, ds_list_size(temp) / 3);
            for(var i = 0; i < ds_list_size(temp); i++){
            
                buffer_write(znet_server_buffer, buffer_string, temp[| i]);
            
            }
            
            ds_list_destroy(temp);
            
            network_send_packet(socket_id, znet_server_buffer, buffer_tell(znet_server_buffer));
        
        }
    
    break;
    
    case network_type_disconnect:
    
        var socket_id = async_load[? "socket"];
    
        var ind = ds_list_find_index(znet_socket_list, socket_id);
        
        if(ind != -1){
            
            znet_last_disconnected = socket_id;    
        
            var _id = znet_socket_id_list[| ind];
            
            ds_list_delete(znet_socket_list, ind);
            ds_list_delete(znet_socket_id_list, ind);
            
            for(var i = 0; i < ds_list_size(znet_entity_list); i++){
        
                var entity_type = znet_entity_list[| i];
                var entity_type_map = entity_type[| 1];
                
                for(var j = ds_list_size(entity_type_map) - 1; j >= 0; j--){
                
                    var entity_map = entity_type_map[| j];
                    if(entity_map[? "znet_entity_client"] == _id)
                        znet_entity_destroy(entity_map[? "znet_entity_name"]);
                    
                }
            
            }
        
        }
    
    break;
    
    case network_type_data:
    
        var socket_id = async_load[? "id"];
    
        var buffer = async_load[? "buffer"];
        buffer_seek(buffer, buffer_seek_start, 0);
        
        if(buffer_read(buffer, buffer_bool)){
        
            if(buffer_read(buffer, buffer_bool)){
            
                var msg_id = buffer_read(buffer, buffer_string);
                
                if(msg_id == "client_timeout"){
                    
                    var _id = buffer_read(buffer, buffer_u16);
                
                    buffer_seek(znet_server_buffer, buffer_seek_start, 0);
                    buffer_write(znet_server_buffer, buffer_bool, false);
                    buffer_write(znet_server_buffer, buffer_bool, true);
                    buffer_write(znet_server_buffer, buffer_string, "client_timeout");
                    network_send_packet(znet_socket_list[| ds_list_find_index(znet_socket_id_list, _id)], znet_server_buffer, buffer_tell(znet_server_buffer));
                
                }else if(msg_id == "client_ping"){
                
                    var _id = buffer_read(buffer, buffer_u16);
                    var time = buffer_read(buffer, buffer_u32);
                
                    buffer_seek(znet_server_buffer, buffer_seek_start, 0);
                    buffer_write(znet_server_buffer, buffer_bool, false);
                    buffer_write(znet_server_buffer, buffer_bool, true);
                    buffer_write(znet_server_buffer, buffer_string, "client_ping");
                    buffer_write(znet_server_buffer, buffer_u32, time);
                    network_send_packet(znet_socket_list[| ds_list_find_index(znet_socket_id_list, _id)], znet_server_buffer, buffer_tell(znet_server_buffer));
                
                }else if(msg_id == "entity_create"){
                
                    var entity_type = buffer_read(buffer, buffer_string);
                    var entity_name = buffer_read(buffer, buffer_string);
                    var entity_keys = buffer_read(buffer, buffer_string);
                    
                    __znet_server_entity_create(entity_type, entity_name, entity_keys);
                
                }else if(msg_id == "entity_destroy"){
                
                    var entity_name = buffer_read(buffer, buffer_string);
                    
                    __znet_server_entity_destroy(entity_name);
                
                }else if(msg_id == "entity_set_keys"){
                
                    var entity_name = buffer_read(buffer, buffer_string);
                    var entity_keys = buffer_read(buffer, buffer_string);
                    
                    __znet_server_entity_set_keys(entity_name, entity_keys);
                
                }else if(msg_id == "entity_attach_client"){
                
                    var entity_name = buffer_read(buffer, buffer_string);
                    var client_id = buffer_read(buffer, buffer_u16);
                    
                    __znet_server_entity_attach_client(entity_name, client_id);
                
                }
            
            }else{
            
            }
        
        }
    
    break;

}

}
