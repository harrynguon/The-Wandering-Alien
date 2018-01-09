extends Node2D

var level_selected = 0

func _ready():
	$Elements/Play.connect("pressed", self, "play_btn_pressed")
	$Elements/Quit.connect("pressed", self, "quit_btn_pressed")
	$LevelSelectNode/LevelSelect/Back_Button.connect("pressed", self, "back_btn_pressed")
	connect_levels()
	update_star_counts()
	
func update_star_counts():
	# TODO: get all star counts and update for the level select screen
	var levels_star_count = get_node("/root/global").get_level_star_count()
	$LevelSelectNode/LevelSelect.set_star_counts(levels_star_count) # parse the whole dict
	
func set_anim(result):
	var slide_instance = load("res://scenes/util/slide.tscn").instance()
	add_child(slide_instance)
	slide_instance.play_slide_down()

func connect_levels():
	$LevelSelectNode/LevelSelect/Border/Levels/level1.connect("pressed", self, "level_1_pressed")
	# TODO:
	# check global variables and lock accordingly depending on which one has been completed
	# or not. 
	$LevelSelectNode/LevelSelect.lock_level(2)
	$LevelSelectNode/LevelSelect.lock_level(3)
	$LevelSelectNode/LevelSelect.lock_level(4)
	$LevelSelectNode/LevelSelect.lock_level(5)
	$LevelSelectNode/LevelSelect.lock_level(6)
	$LevelSelectNode/LevelSelect.lock_level(7)
	$LevelSelectNode/LevelSelect.lock_level(8)
	
func play_btn_pressed():
	$AnimationPlayer.play("move_right")

func quit_btn_pressed():
	get_tree().quit()

func back_btn_pressed():
	$AnimationPlayer.play("move_left")
	
func play_level():
	get_node("/root/global").set_level(level_selected)
	get_node("/root/global").goto_scene("res://scenes/levels/level%s.tscn" % level_selected)
	
func level_1_pressed():
	level_selected = 1
	fade_out()
	
func fade_out():
	var fade_out_instance = load("res://scenes/util/fade_out_node.tscn").instance()
	fade_out_instance.connect("anim_finished", self, "play_level")
	add_child(fade_out_instance)
	fade_out_instance.fade_out()
