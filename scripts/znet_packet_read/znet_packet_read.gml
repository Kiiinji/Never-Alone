/// @description znet_packet_read(type);
/// @param type

/*

    Reads a value from the current packet. Used in the networking event.
    
    type = What type of value to read. (e.g buffer_u8, buffer_f32, buffer_string, etc...)
    
    Returns: Value from packet.

*/

var type = argument0;

var buffer = async_load[? "buffer"];
return buffer_read(buffer, type);
