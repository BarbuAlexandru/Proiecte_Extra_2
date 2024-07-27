extends Control

var fileName = "";
var pathModel = "res://REPLACE.json";
var exePath = OS.get_executable_path();
var error = "File Invalid.";

func _ready():
	Global.Scor_GC = 0;

func _on_inapoi_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_start_gaseste_cuvintele_pressed():
	var path_debug = pathModel.replace("REPLACE", fileName);
	var path_exe = exePath + '/' + fileName + ".json"
	Global.Levels_GC = load_json_file(path_debug);
	if(fileName == ""):
		Global.Levels_GC = load_json_file(path_exe);
	if(fileName == ""):
		return;
	get_tree().change_scene_to_file("res://gaseste_cuvintele_joc.tscn")
	
func _on_text_edit_text_changed():
	fileName = get_node("/root/GasesteCuvintele/TextEdit").get_text();

func load_json_file(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ);
		var parsedFile = JSON.parse_string(dataFile.get_as_text())
		if("Code" in parsedFile and parsedFile.Code == "GC"):
			return parsedFile.Content
	get_node("/root/GasesteCuvintele/TextEdit").set_text("");
	fileName = "";
	get_node("/root/GasesteCuvintele/TextEdit").set_placeholder(error);
