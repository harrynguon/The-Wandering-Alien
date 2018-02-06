extends KinematicBody2D

const WALK_SPEED = 50
const FLOOR_NORMAL = Vector2(0, -1)

#export(String, "purple", "blue")var type_of_snail

var linear_vel = Vector2()
var moving_left = true
var anim=""

#cache the sprite here for fast access (we will set scale to flip it often)
onready var sprite = $AnimatedSprite

func _ready():
	linear_vel += Vector2(0, 100)
	pass
	
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
		anim = "idle"
	else:
		anim = "walk"
		
	sprite.play(anim)
