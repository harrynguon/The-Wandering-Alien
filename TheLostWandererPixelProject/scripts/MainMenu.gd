extends Control

var menu_popped
var timer

var playbtn = preload("res://assets/art/mainmenu/playbtn.png")
var playbtn_pressed = preload("res://assets/art/mainmenu/playbtn-pressed.png")
var quitbtn_pressed = preload("res://assets/art/mainmenu/quitbtn-pressed.png")

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
			$MarginContainer/H/V/MenuOptions/Play.texture = playbtn_pressed
			$MarginContainer2/LevelSelectScreen/Tween.interpolate_property(\
					$MarginContainer2, "rect_position", $MarginContainer2.rect_position,\
					Vector2(-5, 0), 0.3, Tween.TRANS_QUINT, Tween.EASE_OUT, 0.05)
			$MarginContainer2/LevelSelectScreen/Tween.start()
			
func _on_LevelSelectScreen_back_btn_pressed():
	$MarginContainer/H/V/MenuOptions/Play.texture = playbtn
	$MarginContainer2/LevelSelectScreen/Tween.interpolate_property(\
			$MarginContainer2, "rect_position", $MarginContainer2.rect_position,\
			Vector2(800, 0), 0.3, Tween.TRANS_QUINT, Tween.EASE_OUT, 0.05)
	$MarginContainer2/LevelSelectScreen/Tween.start()

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
			$MarginContainer/H/V/MenuOptions/Quit.texture = quitbtn_pressed
			get_tree().quit()
