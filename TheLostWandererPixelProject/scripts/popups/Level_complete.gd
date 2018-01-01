extends Node2D

var number_of_stars

func _ready():
	number_of_stars = 3
	hide_buttons()
	$AnimationPlayer.play("window_frame_fly_down")
	pass
	
func play_animation():
	if number_of_stars == 0:
		return
	elif number_of_stars == 1:
		$AnimationPlayer.play("one_star")
	elif number_of_stars == 2:
		$AnimationPlayer.play("two_stars")
	elif number_of_stars == 3:
		$AnimationPlayer.play("three_stars")


func _on_AnimationPlayer_animation_finished( name ):
	if name == "window_frame_fly_down":
		show_buttons()
		play_animation()
	elif name != "buttons_flying_up":
		$AnimationPlayer.play("buttons_flying_up")

func set_number_of_stars(amount):
	number_of_stars = amount
	
func hide_buttons():
	$Frame/home.hide()
	$Frame/next.hide()
	$Frame/restart.hide()
	
func show_buttons():
	$Frame/home.show()
	$Frame/next.show()
	$Frame/restart.show()