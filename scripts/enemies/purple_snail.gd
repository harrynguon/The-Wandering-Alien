extends KinematicBody2D

var WALK_SPEED = 50
const FLOOR_NORMAL = Vector2(0, -1)

export(String, "purple", "blue") var type_of_snail = "purple" setget type_of_snail_set

var linear_vel = Vector2()
var moving_left = true
var anim=""

#cache the sprite here for fast access (we will set scale to flip it often)
onready var sprite = $AnimatedSprite

func _ready():
	# push to floor
	linear_vel += Vector2(0, 100)
	if type_of_snail == "blue":
		WALK_SPEED = 70
	
func _physics_process(delta):
	# Move and Slide
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL)
	if linear_vel == Vector2(0, 0):
		moving_left = false if moving_left else true
		
	# Horizontal Movement calculations for next step
	var target_speed = 0
	if moving_left:
		target_speed -= 1
	else:
		target_speed += 1

	# calculates next movement velocity
	target_speed *= WALK_SPEED
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)
	
	# flip depending on direction
	if linear_vel > Vector2(0, 0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
	if linear_vel <= Vector2(5, 5) and linear_vel >= Vector2(-5, -5):
		sprite.flip_h = true
		anim = "idle"
	else:
		anim = "walk"
	
	if type_of_snail == "purple":
		sprite.play("purple_"+anim)
	else:
		sprite.play("blue_"+anim)


func type_of_snail_set(new_value):
	type_of_snail = new_value