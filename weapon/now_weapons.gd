extends Node2D

var weapon_radius = 80 
var weapon_number = 0 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var weapon_number = self.get_child_count()
	var unit = TAU / weapon_number
	var weapons = self.get_children()
	
	for i  in len(weapons):
		var weapon = weapons[i]
		var weapon_rad = unit * i 
		var end_pos = weapon.position + Vector2(weapon_radius,0).rotated(weapon_rad)
		weapon.position = end_pos
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
