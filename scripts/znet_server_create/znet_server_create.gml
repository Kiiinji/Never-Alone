/// @description znet_server_create(port, max_clients, version);
/// @param port
/// @param  max_clients
/// @param  version

/*

    Starts a new server on the specified port.
    
    port        = What port to start the server on.
    max_clients = How many clients that can connect to the server.
    version     = Version of the server. Used for checking if a client and the server are using the same version.
    
    Returns: Id of the server if it was created successfully, or -1 if it failed.

*/

with(instance_create(0, 0, obj_znet_server)){

    znet_port = argument0;
    znet_max_clients = argument1;
    znet_server_version = argument2;
    
    znet_server_socket = network_create_server(network_socket_tcp, znet_port, znet_max_clients + 15);
    if(znet_server_socket < 0){
    
        instance_destroy();
        return -1;
    
    }
    
    znet_server_buffer = buffer_create(1, buffer_grow, 1);
    
    znet_socket_list = ds_list_create(); 
    znet_socket_id_list = ds_list_create();
    
    znet_entity_type_list = ds_list_create();
    znet_entity_list = ds_list_create();
    
    ds_list_add(znet_entity_type_list, "znet_entity_default");
    
    var entity_type_list = ds_list_create();
    ds_list_add(znet_entity_list, entity_type_list);
    
    ds_list_add(entity_type_list, ds_list_create());
    ds_list_add(entity_type_list, ds_list_create());

    return id;

}
