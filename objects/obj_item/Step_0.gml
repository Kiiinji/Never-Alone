if(drop_move){
	x = lerp(x, goal_x, 0.1);
	y = lerp(y, goal_y, 0.1);
	if( abs(x - goal_x) < 1 and abs(y - goal_y) < 1) { drop_move = false; }
} else {
	if(!keyboard_check(ord("R"))) exit;



var px = joueurtest.x
var py = joueurtest.y
var r = 32;

if(point_in_rectangle(px, py, x-r, y-r, x+r, y+r)){
	
	// On est au dessus du joueur ?
	r = 2;
	if(! point_in_rectangle(px, py, x-r, y-r, x+r, y+r)){
			// Va vers le joueur
	x = lerp(x, px, 0.1);
	y = lerp(y, py, 0.1);
	
	
	} else { // Récupérer l'item
		var in = item_num;
		
		with(o_Inventaire){
			var ds_inv = ds_inventory;
			var picked_up = false;
			
			
			// Vérifier si l'item existe déjà dans l'inventaire
			var yy = 0; repeat(inv_slots){
				if(ds_inv[# 0, yy] == in){
					ds_inv[# 1, yy] += 1;
					picked_up = true;
					break;
				} else {
					yy += 1;
				}
			}
			
			// Sinon, ajouter l'item à un emplacement vide s'il y en a un
			if (!picked_up) {
					yy = 0; repeat(inv_slots){
					if(ds_inv[# 0, yy] == item.none){
						ds_inv[# 0, yy] = in;
						ds_inv[# 1, yy] += 1;
						picked_up = true;
						break;
					} else {
						yy += 1;
					}
			}
				
		}
		
		
	}
	
	// Détruire l'item si récupéré
		if(picked_up){
			instance_destroy();
			
		}
}
}
}