extends Node2D

var punctajTextNode

func _ready():
	var punctaj = Global.scor
	punctajTextNode = get_node("/root/GasesteCuvintele_Final/Title")
	punctajTextNode.set_text("Felicitari!!\nAi obtinut "+str(punctaj)+" puncte!!")


func _on_inapoi_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://gaseste_cuvintele.tscn")
