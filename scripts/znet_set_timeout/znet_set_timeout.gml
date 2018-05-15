/// @description znet_set_timeout(time);
/// @param time

/*

    Sets the connection timeout for connecting to the server. (In milliseconds)
    
    time = Time in milliseconds.

*/

var time = argument0;
network_set_config(network_config_connect_timeout, time);
