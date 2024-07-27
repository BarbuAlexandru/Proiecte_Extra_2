extends Node2D

var punctajTextNode

func _ready():
	var punctaj = Global.Scor_GC
	punctajTextNode = get_node("/root/GasesteCuvintele_Final/Title")
	punctajTextNode.set_text("Felicitări!!\nAi obținut "+str(punctaj)+" puncte!!")
	
func _on_inapoi_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://gaseste_cuvintele.tscn")
