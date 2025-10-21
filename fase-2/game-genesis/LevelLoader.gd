extends Node2D
@export var level_file_path: String = "res://levels/level_001.json"
@export var tile_size: int = 64

# Colores para cada tipo de tile
var tile_colors = {
	"empty": Color.TRANSPARENT,
	"ground": Color.SADDLE_BROWN,
	"wall": Color.GRAY,
	"player": Color.GREEN,
	"exit": Color.RED,
	"profesor": Color.BLUE,
	
}

func _ready():
	load_and_generate_level()

func load_and_generate_level():
	var level_data = load_level_data()
	if level_data:
		generate_visual_level(level_data)
	else:
		print("Error: No se pudo cargar el nivel")
		create_test_level()  # Usar nivel de prueba si falla

func load_level_data() -> Dictionary:
	var file = FileAccess.open(level_file_path, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var json = JSON.new()
		var error = json.parse(json_text)
		if error == OK:
			return json.data
		else:
			print("Error parseando JSON: ", json.get_error_message())
	return {}

func generate_visual_level(level_data: Dictionary):
	clear_existing_tiles()
	
	var tiles = level_data.get("tiles", [])
	var tile_types = level_data.get("tile_types", {})
	
	for y in range(tiles.size()):
		var row = tiles[y]
		for x in range(row.size()):
			var tile_value = row[x]
			var tile_name = tile_types.get(str(tile_value), "empty")
			create_tile_visual(x, y, tile_name)

func create_tile_visual(x: int, y: int, tile_type: String):
	if tile_type == "empty":
		return
	
	var color = tile_colors.get(tile_type, Color.WHITE)
	
	# Crear un ColorRect como tile visual
	var tile = ColorRect.new()
	tile.size = Vector2(tile_size, tile_size)
	tile.position = Vector2(x * tile_size, y * tile_size)
	tile.color = color
	
	# Agregar label para debug
	var label = Label.new()
	label.text = str(tile_type[0])  # Primera letra
	label.add_theme_color_override("font_color", Color.BLACK)
	label.add_theme_font_size_override("font_size", 12)
	label.position = Vector2(5, 5)
	tile.add_child(label)
	
	add_child(tile)

func clear_existing_tiles():
	for child in get_children():
		child.queue_free()

# Función para probar con datos hardcodeados si el JSON falla
func create_test_level():
	var test_data = {
		"width": 10,
		"height": 8,
		"tile_types": {"0": "empty", "1": "ground", "2": "wall", "3": "player", "4": "exit", "5": "profesor"},
		"tiles": [
			[2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
			[2, 3, 1, 1, 1, 1, 1, 1, 1, 2],
			[2, 1, 1, 1, 1, 1, 1, 1, 1, 2],
			[2, 1, 1, 2, 2, 1, 1, 1, 1, 2],
			[2, 1, 1, 2, 2, 1, 1, 1, 1, 2],
			[2, 1, 1, 1, 1, 1, 1, 1, 1, 2],
			[2, 1, 1, 1, 1, 1, 1, 1, 4, 2],
			[2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
			[2, 2, 2, 2, 2, 2, 1, 1, 5, 4],
		]
	}
	generate_visual_level(test_data)
