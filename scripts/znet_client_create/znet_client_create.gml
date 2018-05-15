/// @description znet_client_create(ip, port, version);
/// @param ip
/// @param  port
/// @param  version

/*

    Creates a new client and connects it to the specified ip and port.
    
    ip      = What ip to connect to.
    port    = What port to connect to.
    version = Version of the client. Used for checking if the client and the server are using the same version.
    
    Returns: Id of the client if it was created successfully.
         -1 if it was unable to create a socket.
         -2 if it was unable to connect to the server.

*/

with(instance_create(0, 0, obj_znet_client)){

    znet_ip = argument0;
    znet_port = argument1;
    znet_client_version = argument2;
    
    znet_client_socket = network_create_socket(network_socket_tcp);
    if(znet_client_socket < 0){
    
        instance_destroy();
        return -1;
    
    }
    
    var connection = network_connect(znet_client_socket, znet_ip, znet_port);
    if(connection < 0){
    
        instance_destroy();
        return -2;
    
    }

    znet_client_buffer = buffer_create(1, buffer_grow, 1);
    
    znet_entity_type_list = ds_list_create();
    znet_entity_list = ds_list_create();
    
    ds_list_add(znet_entity_type_list, "znet_entity_default");
    
    var entity_type_list = ds_list_create();
    ds_list_add(znet_entity_list, entity_type_list);
    
    ds_list_add(entity_type_list, ds_list_create());
    ds_list_add(entity_type_list, ds_list_create());
    
    return id;

}
