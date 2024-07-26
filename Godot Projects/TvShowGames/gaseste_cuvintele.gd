extends Control

var fileName = "";
var pathModel = "res://REPLACE.json";
var error = "File-ul nu exista.";

func _ready():
	Global.Scor = 0;

func _on_inapoi_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_start_gaseste_cuvintele_pressed():
	var path = pathModel.replace("REPLACE", fileName);
	Global.Levels = load_json_file(path);
	if(fileName == ""):
		return;
	get_tree().change_scene_to_file("res://gaseste_cuvintele_joc.tscn")
	
func _on_text_edit_text_changed():
	fileName = get_node("/root/GasesteCuvintele/TextEdit").get_text();

func load_json_file(filePath: String):
	print(filePath);
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ);
		return JSON.parse_string(dataFile.get_as_text())
	else:
		get_node("/root/GasesteCuvintele/TextEdit").set_text("");
		fileName = "";
		get_node("/root/GasesteCuvintele/TextEdit").set_placeholder(error);
