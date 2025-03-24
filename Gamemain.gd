extends Node

#定义敌人受到攻击以及死亡动画管理
var animation_scene= preload("res://enemy/enemey_animation.tscn")
var animation_scene_obj = null


#定义掉落物管理
var drop_items_scene= preload("res://drop_items/drop_items.tscn")
var drop_items_scene_obj = null

var duplicate_node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#添加敌人受伤
	animation_scene_obj = animation_scene.instantiate()
	add_child(animation_scene_obj)
	
	#添加掉落物
	drop_items_scene_obj = drop_items_scene.instantiate()
	add_child(drop_items_scene_obj)
	
	var node2d = Node2D.new() 
	node2d.name = "duplicate_node"
	get_window().add_child.call_deferred(node2d)
	duplicate_node = node2d
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
