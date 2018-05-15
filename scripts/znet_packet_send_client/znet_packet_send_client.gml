/// @description znet_packet_send_client(server_id, client_socket);
/// @param server_id
/// @param  client_socket

/*

    Sends a packet from the specified server to the specified client socket.
    
    server_id     = Id of server object to send the packet from.
    client_socket = Id of client socket to send the packet to.
    
    Returns: "true" if the packet vas successfully sent, or "false" if it failed.

*/

var _id = argument0;
var client_socket = argument1;

if(instance_exists(_id)){

    if(_id.object_index == obj_znet_server){
    
        with(_id){
        
            network_send_packet(client_socket, znet_server_buffer, buffer_tell(znet_server_buffer));
        
        }
        
        return true;
    
    }

}

return false;
