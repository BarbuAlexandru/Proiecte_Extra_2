extends Node2D

var puncte = 0
var greseli = 0

var raspunsLeftTextNode
var raspunsRightTextNode
var puncteTextNode
var intrebareTextNode
var greseliTextNode

var currentLevel

var optionSetLeft = []
var optionSetRight = []

func _ready():
	raspunsLeftTextNode = get_node("/root/CeSpun_Joc/Raspuns_Left")
	raspunsRightTextNode = get_node("/root/CeSpun_Joc/Raspuns_Right")
	puncteTextNode = get_node("/root/CeSpun_Joc/Puncte")
	intrebareTextNode = get_node("/root/CeSpun_Joc/Intrebare")
	greseliTextNode = get_node("/root/CeSpun_Joc/Greseli")
	currentLevel = Global.Levels_CS
	loadIndividualOptions()
	displayOptions()
	intrebareTextNode.set_text(Global.Intrebare_CS)
	
func displayOptions():
	puncteTextNode.set_text("Puncte: "+str(puncte))
	var optionSetLeftText = ''
	var optionSetRightText = ''
	
	for i in len(optionSetLeft):
		if(optionSetLeft[i].Guessed):
			optionSetLeftText += (str(i+1) + ": " + optionSetLeft[i].Option + " - " + str(optionSetLeft[i].Scor) + "\n")
		else:
			optionSetLeftText += (str(i+1) + ": " + "???? - ?\n")
	
	for i in len(optionSetRight):
		if(optionSetRight[i].Guessed):
			optionSetRightText += (str(i+1+len(optionSetLeft)) + ": " + optionSetRight[i].Option + " - " + str(optionSetRight[i].Scor) + "\n")
		else:
			optionSetRightText += (str(i+1+len(optionSetLeft)) + ": " + "???? - ?\n")
			
	raspunsLeftTextNode.set_text(optionSetLeftText)
	raspunsRightTextNode.set_text(optionSetRightText)
	
	var textGreseli = "Greseli: "
	for i in greseli:
		textGreseli += "X "
	greseliTextNode.set_text(textGreseli)
	

func _input(_ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://menu.tscn")
		return;
	if Input.is_key_pressed(KEY_1):
		revealOption(1);
	if Input.is_key_pressed(KEY_2):
		revealOption(2);
	if Input.is_key_pressed(KEY_3):
		revealOption(3);
	if Input.is_key_pressed(KEY_4):
		revealOption(4);
	if Input.is_key_pressed(KEY_5):
		revealOption(5);
	if Input.is_key_pressed(KEY_6):
		revealOption(6);
	if Input.is_key_pressed(KEY_7):
		revealOption(7);
	if Input.is_key_pressed(KEY_8):
		revealOption(8);
	if Input.is_key_pressed(KEY_N):
		if(greseli<3):
			greseli += 1
		else:
			endRound();
		
	displayOptions();
	
func endRound():
	Global.Scor_CS = puncte
	get_tree().change_scene_to_file("res://ce_spun_final.tscn")
	
func revealOption(option):
	if(option <= len(optionSetLeft)):
		if(optionSetLeft[option-1].Guessed == false):
			optionSetLeft[option-1].Guessed = true;
			if(greseli < 3):
				puncte += optionSetLeft[option-1].Scor
		return
	if(option <= len(optionSetLeft) + len(optionSetRight)):
		if(optionSetRight[option - len(optionSetLeft) - 1].Guessed == false):
			optionSetRight[option - len(optionSetLeft) - 1].Guessed = true;
			if(greseli < 3):
				puncte += optionSetRight[option - len(optionSetLeft) - 1].Scor
		
func loadIndividualOptions():
	for index in len(currentLevel)-1:
		currentLevel[index]["Guessed"] = false
		if(index < 4):
			optionSetLeft.append(currentLevel[index])
		else:
			optionSetRight.append(currentLevel[index])
