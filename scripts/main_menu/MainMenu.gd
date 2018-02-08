extends Node2D

onready var global = get_node("/root/global")
var level_selected = 0

func _ready():
	global.load_game()
	print("game has been loaded")
	print(global.levels_star_count)
	$Elements/Play.connect("pressed", self, "play_btn_pressed")
	$Elements/Quit.connect("pressed", self, "quit_btn_pressed")
	$LevelSelectNode/LevelSelect/Back_Button.connect("pressed", self, "back_btn_pressed")
	connect_levels()
	update_star_counts()
	
func update_star_counts():
	var levels_star_count = global.get_level_star_count()
	$LevelSelectNode/LevelSelect.set_star_counts(levels_star_count) # parse the whole dict
	
func set_anim(result):
	var slide_instance = load("res://scenes/util/slide.tscn").instance()
	add_child(slide_instance)
	slide_instance.play_slide_down()

func connect_levels():
	var levels_star_count = global.get_level_star_count()
	for i in range(2, (levels_star_count.size()/2) + 1):
		var key = "level"+str(i)+"unlocked"
		if levels_star_count[key] == false:
			$LevelSelectNode/LevelSelect.lock_level(i)
		else:
			$LevelSelectNode/LevelSelect.unlock_level(i)
	# connect signals to the buttons if the level has been unlocked
	for level in $LevelSelectNode/LevelSelect/Border/Levels.get_children():
		if global.levels_star_count[level.get_name()+"unlocked"] == true:
			level.connect("pressed", self, "level_pressed", [level])
	
func play_btn_pressed():
	$Button_Sound.play()
	$AnimationPlayer.play("move_right")

func quit_btn_pressed():
	get_tree().quit()

func back_btn_pressed():
	$Button_Sound.play()
	$AnimationPlayer.play("move_left")

func level_pressed(level):
	var level_name = level.get_name()
	if level_name == "level1":
		level_selected = 1
	elif level_name == "level2":
		level_selected = 2
	$Level_Select_Sound.play()
	fade_out()
	
func fade_out():
	var fade_out_instance = load("res://scenes/util/fade_out_node.tscn").instance()
	fade_out_instance.connect("anim_finished", self, "play_level")
	add_child(fade_out_instance)
	fade_out_instance.fade_out()
	
func play_level():
	get_node("/root/global").set_level(level_selected)
	get_node("/root/global").goto_scene("res://scenes/levels/level%s.tscn" % level_selected)
