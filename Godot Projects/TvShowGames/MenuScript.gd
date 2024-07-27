extends Control

func _on_gaseste_cuvintele_pressed():
	get_tree().change_scene_to_file("res://gaseste_cuvintele.tscn")

func _on_ce_spun_pressed():
	get_tree().change_scene_to_file("res://ce_spun.tscn")

func _on_info_pressed():
	get_tree().change_scene_to_file("res://info.tscn")

func _on_iesire_pressed():
	get_tree().quit()
