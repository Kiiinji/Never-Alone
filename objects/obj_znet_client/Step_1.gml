var delta = (room_speed / 1000000 * delta_time);

if(znet_client_state == "client_connecting"){

    if(!os_is_network_connected()){
    
        znet_client_state = "client_timeout";
        
        network_destroy(znet_client_socket);
        znet_client_socket = -1;
        
        exit;
        
    }
    
    

}else if(znet_client_state == "client_connected"){

    if(!os_is_network_connected()){
    
        znet_client_state = "client_timeout";
        
        network_destroy(znet_client_socket);
        znet_client_socket = -1;
        
        exit;
        
    }
    
    if(znet_timeout_wait){
    
        if(znet_timeout_wait_timer > 0)
            znet_timeout_wait_timer -= delta;
            
        if(znet_timeout_wait_timer <= 0)
            znet_timeout_wait = false;
    
    }
        
    if(!znet_timeout_check && !znet_timeout_wait){

        znet_timeout_check = true;
        znet_timeout_timer = znet_timeout_timer_max;
        
        buffer_seek(znet_client_buffer, buffer_seek_start, 0);
        buffer_write(znet_client_buffer, buffer_bool, true);
        buffer_write(znet_client_buffer, buffer_bool, true);
        buffer_write(znet_client_buffer, buffer_string, "client_timeout");
        buffer_write(znet_client_buffer, buffer_u16, znet_client_id);
        
        network_send_packet(znet_client_socket, znet_client_buffer, buffer_tell(znet_client_buffer));
        
    }
    
    if(znet_timeout_check){
    
        if(znet_timeout_timer > 0)
            znet_timeout_timer -= delta;
            
        if(znet_timeout_timer <= 0){
        
            znet_client_state = "client_timeout";
            
            network_destroy(znet_client_socket);
            znet_client_socket = -1;
        
            exit;
        
        }
    
    }
    
    if(znet_client_ping_timer > 0)
        znet_client_ping_timer--;
        
    if(znet_client_ping_timer <= 0){
    
        znet_client_ping_timer = znet_client_ping_timer_max;
        
        buffer_seek(znet_client_buffer, buffer_seek_start, 0);
        buffer_write(znet_client_buffer, buffer_bool, true);
        buffer_write(znet_client_buffer, buffer_bool, true);
        buffer_write(znet_client_buffer, buffer_string, "client_ping");
        buffer_write(znet_client_buffer, buffer_u16, znet_client_id);
        buffer_write(znet_client_buffer, buffer_u32, current_time);
        
        network_send_packet(znet_client_socket, znet_client_buffer, buffer_tell(znet_client_buffer));
    
    }
        
}

