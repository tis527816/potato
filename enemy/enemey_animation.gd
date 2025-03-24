extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

'''
options.box 动画父级
options.ani_name 动画名称
options.position 动画坐标
options.scale 动画缩放
'''


func run_animation(options):
	if !options.has("box"):
		options.box = Gamemain.duplicate_node
	var ani_temp = self.duplicate()
	options.box.add_child(ani_temp)
	ani_temp.show()
	ani_temp.scale = options.scale if  options.has("scale") else Vector2(1,1)
	ani_temp.position = options.get("position", Vector2.ZERO)  # 默认位置为 (0, 0)
	ani_temp.get_node("allAnimation").play(options.ani_name)
	pass

func _on_all_animation_animation_finished() -> void:
	self.queue_free()
	pass # Replace with function body.
