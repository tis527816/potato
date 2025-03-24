extends CharacterBody2D

var dir = null
var speed = 100
var target = null
var hp = 1
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target =  get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		dir = Vector2(target.global_position - self.global_position).normalized()
		velocity =  speed * dir 
		move_and_slide()
	pass

func enemy_hurt(hurt):
	self.hp -= hurt 
	enemy_flash()
	Gamemain.animation_scene_obj.run_animation({
		"box" : Gamemain.duplicate_node,
		"ani_name" : "hurt",
		"position" : Vector2(0,0),
		"scale" : Vector2(0.125,0.125)
	})
	
	
	if self.hp <= 0:
			enemy_dead()
	pass
		
func enemy_dead():
	Gamemain.animation_scene_obj.run_animation({
		"box" : Gamemain.duplicate_node,
		"ani_name" : "dead",
		"position" :  self.global_position,
		"scale" : Vector2(0.125,0.125)
	})
	Gamemain.drop_items_scene_obj.gen_drop_item({
		"ani_name" : "gold",
		"position" :  self.global_position,
		"scale" : Vector2(2,2)
	})
	self.queue_free()
	pass


func enemy_flash():
	# 正确设置参数
	animated_sprite_2d.material.set_shader_parameter("flash_color", Color("#ff0000"))  # 红色
	animated_sprite_2d.material.set_shader_parameter("hit_effect", 1.0)  # 触发效果
	await get_tree().create_timer(0.1).timeout
	# 正确设置参数
	animated_sprite_2d.material.set_shader_parameter("flash_color", 0)  # 红色
	animated_sprite_2d.material.set_shader_parameter("hit_effect", 0)  # 触发效果

	pass
	
