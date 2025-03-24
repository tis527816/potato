#extends CharacterBody2D
#
## 移动速度
#var speed = 300
#
#func _physics_process(delta):
	## 获取输入方向
	#var input_dir = Vector2()
	#if Input.is_action_pressed("ui_right"):
		#input_dir.x += 1
	#if Input.is_action_pressed("ui_left"):
		#input_dir.x -= 1
	#if Input.is_action_pressed("ui_down"):
		#input_dir.y += 1
	#if Input.is_action_pressed("ui_up"):
		#input_dir.y -= 1
	#
	## 归一化输入方向
	#input_dir = input_dir.normalized()
	#
	## 计算移动向量
	#var velocity = input_dir * speed
	#
	## 设置速度
	#self.velocity = velocity
	#
	## 移动角色
	#move_and_slide()
	#
	## 根据移动方向翻转 Sprite
	#var sprite = $AnimatedSprite2D
	#if velocity.x > 0:
		#sprite.flip_h = false
	#elif velocity.x < 0:
		#sprite.flip_h = true    
extends  CharacterBody2D

@onready var playersprite = $sprite

var dir = Vector2.ZERO
var speed = 300
var flip = false
var canMove = true
var stop  = false

func _ready():
	choosePlayer("player1")
	pass
	
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var self_pos = position
	if mouse_pos.x > self_pos.x:
		flip =false
	else :
		flip = true
	
	playersprite.flip_h = flip
	dir =  (mouse_pos - self_pos).normalized()
	if canMove and !stop :
		velocity = dir * speed
		move_and_slide()
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		canMove = false
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and !event.is_pressed() :
		canMove = true


func _on_stop_mouse_entered() -> void:
	stop = true
	pass # Replace with function body.


func _on_stop_mouse_exited() -> void:
	stop = false
	pass # Replace with function body.


func  choosePlayer(type):
	var player_path = "res://player/"
	playersprite.sprite_frames.clear_all()
	
	var sprite_frame_custom = SpriteFrames.new()
	sprite_frame_custom.add_animation("default")
	sprite_frame_custom.set_animation_loop("default",true)
	var png_size = Vector2(960,240)
	var sprite_size =  Vector2(240,240)
	var full_png:Texture =  load(player_path + type + "/" + type + "-sheet.png")
	var clounm_num = int (png_size.x / sprite_size.x)
	var row_num = int(png_size.y / sprite_size.y)
	for x  in range(clounm_num):
		for y in range(row_num):
			var frame  = AtlasTexture.new()
			frame.atlas = full_png
			frame.region = Rect2(Vector2(x,y) * sprite_size, sprite_size )
			sprite_frame_custom.add_frame("default",frame)
		playersprite.sprite_frames = sprite_frame_custom
		playersprite.play("default")
		
	pass
	


func _on_stop_body_entered(body: Node2D) -> void:
	if body.is_in_group("drop_items"):
		body.queue_free()
	pass # Replace with function body.

var i = 0 
func _on_drop_item_area_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("drop_items"):
		body.canMove  = true
		print("即将拾取"+ str(i))
		i += 1
	pass # Replace with function body.
