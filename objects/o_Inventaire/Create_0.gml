depth = -1;
scale = 2;
show_inventory = true;

inv_slots = 24;
inv_slots_width = 8;
inv_slots_height = 3;

selected_slot = 0;
pickup_slot = -1;
m_slotx = 0;
m_sloty = 0;


x_buffer = 2;
y_buffer = 4;

gui_width = display_get_gui_width();
gui_height = display_get_gui_height();

cell_size = 32;

inv_UI_width = 288;
inv_UI_height = 192;


spr_inv_UI = Inventaire;
spr_inv_items = spr_inventory_items;

spr_inv_items_columns = sprite_get_width(spr_inv_items)/cell_size;
spr_inv_items_rows = sprite_get_height(spr_inv_items)/cell_size;


inv_UI_x = (gui_width * 0.5) - (inv_UI_width * 0.5 * scale);
inv_UI_y = (gui_height * 0.5) - (inv_UI_height * 0.5 * scale);

info_x = inv_UI_x + (55 * scale);
info_y = inv_UI_y + (9 * scale);

slots_x = inv_UI_x + (17);
slots_y = inv_UI_y + (40 * scale);


// Infos du joueur

//0 = LOGO

ds_player_info = ds_grid_create(2, 4);
var info_grid = ds_player_info;
ds_player_info[# 0, 0] = "Inventaire";

// Inventaire
// 0 = item
// 1 = nombre

ds_inventory = ds_grid_create(2, inv_slots);

// Items

enum item {
	none		= 0, 
	tomato		= 1,
	potato		= 2,
	height		= 3,
}


var yy = 0; repeat(inv_slots) {
	ds_inventory [# 0, yy] = irandom_range(1, item.height-1);
	ds_inventory [# 1, yy] = irandom_range(1, 10);
	
	yy+= 1;
}

