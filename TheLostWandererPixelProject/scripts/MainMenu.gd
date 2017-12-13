extends Control

var menu_popped
var timer

func _ready():
	menu_popped = false
	timer = 0.0
	$Player.play("default")
	
func _process(delta):
	if menu_popped:
		timer += delta
	if timer >= 0.13: # delay for no instantaneous options menu opening and closing
		if menu_popped and Input.is_action_just_pressed("ui_click"):
			modulate.a = 1.0
			$Player.play("default")
			$OptionsMenu.hide()
			menu_popped = false
			timer = 0.0
		

func _on_Play_gui_input( ev ):
	if (ev is InputEventMouseButton):
		if (ev.pressed):
			get_node("/root/global").goto_scene("res://scenes/LevelSelect.tscn")
			

func _on_Options_gui_input( ev ):
	if (ev is InputEventMouseButton):
		if (ev.pressed) and !menu_popped:
			modulate.a = 0.3
			$Player.stop()
			$OptionsMenu.show()
			menu_popped = true
			

func _on_Quit_gui_input( ev ):
	if (ev is InputEventMouseButton):
		if (ev.pressed):
			get_tree().quit()
