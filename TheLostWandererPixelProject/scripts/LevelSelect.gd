extends Control

func _ready():
	pass

func _on_Level_1_pressed():
	get_node("/root/global").goto_scene("res://scenes/levels/level1.tscn")

func _on_Back_pressed():
	get_node("/root/global").goto_scene("res://scenes/MainMenu.tscn")
