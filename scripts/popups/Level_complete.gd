extends Node2D

const LAST_LEVEL = 9

var number_of_stars

func _ready():
	number_of_stars = 0
	hide_buttons()
	$Frame/Stars_Amount.hide()
	$fading.hide()
	
# play the corresponding animation with the number of stars
# collected
func play_animation():
	if number_of_stars == 0:
		$Frame/Stars_Amount.show()
		$Frame/Stars_Amount.text = "%s/3 STARS" % number_of_stars
		$AnimationPlayer.play("star_count_from_left")
	elif number_of_stars == 1:
		$AnimationPlayer.play("one_star")
	elif number_of_stars == 2:
		$AnimationPlayer.play("two_stars")
	elif number_of_stars == 3:
		$AnimationPlayer.play("three_stars")

# Animation player chaining
func _on_AnimationPlayer_animation_finished( name ):
	# frame has flown down, now play the star animation
	if name == "window_frame_fly_down":
		show_buttons()
		play_animation()
	# if it's the one/two/three star animation, queue the
	# star count text (n/3 STARS)
	elif name == "one_star" or name == "two_stars" or name == "three_stars":
		$Frame/Stars_Amount.show()
		$Frame/Stars_Amount.text = "%s/3 STARS" % number_of_stars
		$AnimationPlayer.play("star_count_from_left")
	# now that the stars and star count has been shown, queue the buttons
	# flying upwards
	elif name == "star_count_from_left":
		$AnimationPlayer.play("buttons_flying_up")
	# user pressed home button and fade anim has finished
	elif name == "fade_below":
		get_node("/root/global").goto_scene("res://scenes/main_menu/MainMenu.tscn", true)

func set_number_of_stars(amount):
	number_of_stars = amount
	# update star count in global.gd dictionary
	var global_node = get_node("/root/global")
	var current_level_number = global_node.current_level
	var current_level = "level"+str(current_level_number)
	var existing_star_amount = global_node.get_level_star_count()[current_level]
	if number_of_stars > existing_star_amount:
		global_node.get_level_star_count()[current_level] = number_of_stars
	
func hide_buttons():
	$Frame/home.hide()
	$Frame/next.hide()
	$Frame/restart.hide()
	
func show_buttons():
	$Frame/home.show()
	$Frame/next.show()
	$Frame/restart.show()
	# it is the last level, cannot advance forward
	if get_node("/root/global").current_level == LAST_LEVEL:
		$Frame/next.normal = $Frame/next.pressed

func _on_home_pressed():
	$fading.show()
	$AnimationPlayer.play("fade_below")

# Restart the level
func _on_restart_pressed():
	var fade_out_instance = load("res://scenes/util/fade_out_node.tscn").instance()
	fade_out_instance.connect("anim_finished", self, "restart_game")
	$Frame.hide()
	$CanvasLayer.add_child(fade_out_instance)
	fade_out_instance.play("fade")

func restart_game():
	get_node("/root/global").goto_scene("res://scenes/levels/level%s.tscn" % \
			get_node("/root/global").current_level, true)

# Advances forward to the next level
func _on_next_pressed():
	if get_node("/root/global").current_level < LAST_LEVEL:
		var current_level = get_node("/root/global").current_level
		current_level += 1
		get_node("/root/global").set_level(current_level + 1)
	
