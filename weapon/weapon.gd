extends Node2D

@onready var weaponani = $AnimatedSprite2D
@onready var shot_pos: Marker2D = $shot_pos
@onready var timer: Timer = $Timer
@onready var bullet = preload("res://bullet/bullet.tscn")

var bullet_shoot_time = 0.5
var bullet_speed = 1000
var bullet_hurt = 1
var attack_enemies = []

const weapon_level = {
	levle_1= "#c0b0e2",
	levle_2= "#b0c3d9",
	levle_3= "#d9b0c3",
	levle_4= "#b2b0d9",
	levle_5= "#f30000",
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ran =RandomNumberGenerator.new()
	var materialTemp = weaponani.material.duplicate()
	weaponani.material =materialTemp
	weaponani.material.set_shader_parameter("color",Color(weapon_level['levle_' + str(ran.randi_range(1,5))]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if attack_enemies.size() != 0:
		self.look_at(attack_enemies[0].global_position)
	else :
		rotation_degrees = 0


func _on_timer_timeout() -> void:
	if attack_enemies.size() != 0:
		var now_bullet = bullet.instantiate()
		now_bullet.speed = bullet_speed
		now_bullet.hurt = bullet_hurt
		now_bullet.position = shot_pos.global_position
		now_bullet.dir = (attack_enemies[0].global_position - now_bullet.position).normalized()
		get_tree().root.add_child(now_bullet)



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and !attack_enemies.has(body):
		attack_enemies.append(body)
	sort_enemy()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy") and attack_enemies.has(body):
		attack_enemies.remove_at(attack_enemies.find(body))
	sort_enemy()
	pass # Replace with function body.

func sort_enemy():
	if attack_enemies.size() != 0 :
		attack_enemies.sort_custom(
			func(x,y):
				return x.global_position.distance_to(self.global_position) < y.global_position.distance_to(self.global_position)
		)
		
