extends TileMap

@onready var tile_map: TileMap = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_tile()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func random_tile():
	tile_map.clear_layer(1)
	var bg1_cells = tile_map.get_used_cells(0)
	var ran = RandomNumberGenerator.new()
	ran.randomize()  # 初始化随机种子
	var modified_cells = []  # 记录所有被修改的单元格
	
	for cell_pos in bg1_cells:
		var num = ran.randi_range(1, 100) 
		if  num < 5 and num > 2:  # 3% 概率（数值3、4、5）
			tile_map.set_cell(1, cell_pos, 0, Vector2i(18, 1))
			modified_cells.append(cell_pos)
		elif num < 3:      # 2% 概率（数值1、2）
			tile_map.set_cell(1, cell_pos, 0, Vector2i(19, 11))
			modified_cells.append(cell_pos)
	


func _on_button_pressed() -> void:
	random_tile()
	pass # Replace with function body.
