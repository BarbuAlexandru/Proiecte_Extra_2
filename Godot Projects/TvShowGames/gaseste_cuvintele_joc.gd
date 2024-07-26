extends Node2D

var timerSeconds = 0;
var timerMinutes = 5;
var timpGhicit = 30;
var timerGhicit = timpGhicit;

var ghicit = false
var punctaj = 0

var timer := Timer.new()
var timerTotalTextNode
var timerGhicitTextNode
var timerTotalPauzaTextNode

var punctajTextNode
var descriereTextNode
var cuvantTextNode
var localLevels = Global.Levels

var currentLevel = 0;

var cuvantCurent
var cuvantAscuns
var descriere
var finalRunda = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timerTotalTextNode = get_node("/root/GasesteCuvintele_Joc/timer_total")
	timerTotalPauzaTextNode = get_node("/root/GasesteCuvintele_Joc/timer_total_pauza")
	timerTotalPauzaTextNode.visible = false
	timerGhicitTextNode = get_node("/root/GasesteCuvintele_Joc/timer_ghicit")
	timerGhicitTextNode.visible = false;
	punctajTextNode = get_node("/root/GasesteCuvintele_Joc/Puncte")
	descriereTextNode = get_node("/root/GasesteCuvintele_Joc/Descriere")
	cuvantTextNode = get_node("/root/GasesteCuvintele_Joc/Cuvant")
	
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = 1
	timer.timeout.connect(timerSecond)
	timer.start()
	
	timerTotalTextNode.set_text(getTimeLeftAsString(timerMinutes, timerSeconds))
	loadLevel()
	
func loadLevel():
	descriereTextNode.set("theme_override_colors/font_color",Color.WHITE)
	timerGhicit = timpGhicit;
	punctajTextNode.set_text("Puncte: "+str(punctaj))
	timer.wait_time = 1
	timer.start()
	ghicit = false
	finalRunda = false
	timerTotalPauzaTextNode.visible = false;
	if(currentLevel >= len(localLevels)):
		Global.Scor = punctaj;
		get_tree().change_scene_to_file("res://gaseste_cuvintele_final.tscn");
		return
	var level = localLevels[currentLevel]
	cuvantCurent = level.Cuvant.to_upper()
	cuvantAscuns = ascundeCuvantul();
	cuvantTextNode.set_text(cuvantAscuns)
	
	descriere = level.Descriere
	descriereTextNode.set_text(descriere)

func ascundeCuvantul():
	var cuv = ""
	for l in range(0, len(cuvantCurent)):
		cuv += "_ "
	return cuv

func timerSecond():
	if finalRunda:
		return
	if ghicit:
		timerGhicit -= 1;
	else:
		timerSeconds -=1;
	if(timerSeconds < 0):
		timerSeconds = 59
		timerMinutes -= 1
	if(timerGhicit < 0):
		cuvantNeghicit();
	if(timerMinutes < 0):
		Global.Scor = punctaj;
		get_tree().change_scene_to_file("res://gaseste_cuvintele_final.tscn");
		return
	else:
		timer.wait_time = 1
		timer.start()
		timerTotalTextNode.set_text(getTimeLeftAsString(timerMinutes, timerSeconds))
		timerGhicitTextNode.set_text(getTimeLeftAsString(0, timerGhicit))

func getTimeLeftAsString(minutes, sec):
	var secondsText = str(sec) if sec > 9 else "0" + str(sec)
	return (str(minutes) + ":" + secondsText)

func _input(_ev):
	if Input.is_key_pressed(KEY_SPACE):
		if(finalRunda == false and ghicit == false):
			timerGhicit = timpGhicit
			timerGhicitTextNode.set_text(getTimeLeftAsString(0, timerGhicit))
			ghicit = !ghicit
			timerGhicitTextNode.visible = !timerGhicitTextNode.visible
			timerTotalPauzaTextNode.visible = !timerTotalPauzaTextNode.visible
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://menu.tscn")
		return;
	if Input.is_key_pressed(KEY_L):
		if(ghicit == false and finalRunda == false):
			descoperaLitera()
	if Input.is_key_pressed(KEY_N):
		if(finalRunda):
			currentLevel += 1;
			loadLevel()
		else:
			if(ghicit == true):
				cuvantNeghicit()
	if Input.is_key_pressed(KEY_Y):
		cuvantGhicit();
	if Input.is_key_pressed(KEY_P):
		if(finalRunda == false and ghicit == true):
			timerGhicit -= 5

func cuvantGhicit():
	var count = 0
	for character in cuvantAscuns:
		if character == "_":
			count += 1
	var punctajCurent = int(count * sqrt(timerMinutes*60 + timerSeconds))
	punctaj += punctajCurent;
	
	while("_" in cuvantAscuns):
		descoperaLitera()
	finalRunda = true
	timerGhicitTextNode.visible = false;
	timerTotalPauzaTextNode.visible = true;
	
	descriereTextNode.set("theme_override_colors/font_color",Color.GREEN)
	descriereTextNode.set_text("Bravo, ai ghicit cuvantul :)!\nAi primit " + str(punctajCurent) + " puncte!")
	punctajTextNode.set_text("Puncte: "+str(punctaj))

func descoperaLitera():
	var indexLitera = randi_range(0, len(cuvantCurent)-1)
	while(cuvantAscuns[indexLitera*2] != '_'):
		indexLitera = randi_range(0, len(cuvantCurent)-1)
	cuvantAscuns[indexLitera*2] = cuvantCurent[indexLitera]
	cuvantTextNode.set_text(cuvantAscuns)
	if "_" not in cuvantAscuns:
		cuvantNeghicit()
		return
	
func cuvantNeghicit():
	while("_" in cuvantAscuns):
		descoperaLitera()
	finalRunda = true
	timerGhicitTextNode.visible = false;
	timerTotalPauzaTextNode.visible = true;
	descriereTextNode.set("theme_override_colors/font_color",Color.RED)
	descriereTextNode.set_text("Din pacate nu ai ghicit cuvantul :(..\nNu ai primit niciun punct.")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
