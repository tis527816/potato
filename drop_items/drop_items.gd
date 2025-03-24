extends CharacterBody2D

var canMove = false
var speed = 500
var player 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	self.set_collision_layer_value(5,false)
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if canMove:
		var dir = (player.global_position - self.global_position).normalized()
		velocity = dir * speed
		move_and_slide()
	pass 
pass
"""
options.box :掉落物父级
options.ani_name : 掉落物名称
options.position ：掉落物坐标
options。scale ：掉落物缩放等级
"""
func gen_drop_item(options):
	if !options.has("box"):
		options.box = Gamemain.duplicate_node
	var ani_temp = self.duplicate()
	options.box.add_child.call_deferred(ani_temp)
	ani_temp.show.call_deferred()
	self.set_collision_layer_value.call_deferred(5,true)
	ani_temp.scale = options.scale if  options.has("scale") else Vector2(1,1)
	#ani_temp.position = options.get("position", Vector2.ZERO)  # 默认位置为 (0, 0)
	ani_temp.position = options.position
	ani_temp.get_node("allAnimation").play(options.ani_name)
	pass
