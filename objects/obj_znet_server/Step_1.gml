if(znet_server_state == "server_open"){

    if(!os_is_network_connected()){
    
        znet_server_state = "server_error";
        
        network_destroy(znet_server_socket);
        znet_server_socket = -1;
        
    }
    
}

