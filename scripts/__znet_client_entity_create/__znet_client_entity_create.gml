/// @description __znet_client_entity_create(type, name, keys, [map_keys]);
/// @param type
/// @param  name
/// @param  keys
/// @param  [map_keys]

var entity_type = argument[0];
var entity_name = argument[1];
var entity_keys = argument[2];

var entity_key = "";
if(argument_count > 3)
    entity_key = argument[3];

if(entity_type == "") entity_type = "znet_entity_default";
                    
var ind = ds_list_find_index(znet_entity_type_list, entity_type);

var entity_type_list, entity_type_name, entity_type_map;
if(ind == -1){

    entity_type_list = ds_list_create();
    
    entity_type_name = ds_list_create();
    entity_type_map = ds_list_create();

    ds_list_add(znet_entity_type_list, entity_type);
    ds_list_add(znet_entity_list, entity_type_list);
    
    ds_list_add(entity_type_list, entity_type_name);
    ds_list_add(entity_type_list, entity_type_map);

}else{

    entity_type_list = znet_entity_list[| ind];
    
    entity_type_name = entity_type_list[| 0];
    entity_type_map = entity_type_list[| 1];

}

ds_list_add(entity_type_name, entity_name);

var entity_map = ds_map_create();
ds_list_add(entity_type_map, entity_map);

if(entity_key != "")
    ds_map_read(entity_map, entity_key);
else{

    entity_map[? "znet_entity_name"] = entity_name;
    entity_map[? "znet_entity_client"] = -1;
    
}
    
if(entity_keys != ""){

    var keys = ds_list_create();
    ds_list_read(keys, entity_keys);
    
    for(var i = 0; i < ds_list_size(keys); i += 2){
    
        entity_map[? keys[| i]] = keys[| i + 1];
        
    }
    
    ds_list_destroy(keys);

}
