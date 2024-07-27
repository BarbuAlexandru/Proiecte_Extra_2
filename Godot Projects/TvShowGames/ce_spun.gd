extends Node2D

var fileName = "";
var pathModel = "res://REPLACE.json";
var exePath = OS.get_executable_path();
var error = "File Invalid.";

func _on_text_edit_text_changed():
	fileName = get_node("/root/CeSpun/TextEdit").get_text();

func load_json_file(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ);
		var parsedFile = JSON.parse_string(dataFile.get_as_text())
		if("Code" in parsedFile and parsedFile.Code == "CS"):
			return parsedFile
	get_node("/root/CeSpun/TextEdit").set_text("");
	fileName = "";
	get_node("/root/CeSpun/TextEdit").set_placeholder(error);

func _on_start_pressed():
	var path_debug = pathModel.replace("REPLACE", fileName);
	var path_exe = exePath + '/' + fileName + ".json"
	var parsedFile = load_json_file(path_debug);
	if(fileName == ""):
		parsedFile = load_json_file(path_exe);
	if(fileName != ""):
		Global.Levels_CS = parsedFile.Content
		Global.Intrebare_CS = parsedFile.Intrebare
	else:
		return;
	get_tree().change_scene_to_file("res://ce_spun_joc.tscn")

func _on_inapoi_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
