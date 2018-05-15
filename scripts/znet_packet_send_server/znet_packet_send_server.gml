/// @description znet_packet_send_server(client_id);
/// @param client_id

/*

    Sends a packet from the specified client to the server.
    
    client_id = Id of client object to send the packet from.
    
    Returns: "true" if the packet vas successfully sent, or "false" if it failed.

*/

var _id = argument0;

if(instance_exists(_id)){

    if(_id.object_index == obj_znet_client){
    
        with(_id){
        
            network_send_packet(znet_client_socket, znet_client_buffer, buffer_tell(znet_client_buffer));
        
        }
        
        return true;
    
    }

}

return false;
