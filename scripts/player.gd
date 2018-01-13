extends KinematicBody2D

const GRAVITY_VEC = Vector2(0, 1000)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 13
const MIN_ONAIR_TIME = 0.1
const WALK_SPEED = 160 # pixels/sec
const JUMP_SPEED = 280
const SIDING_CHANGE_SPEED = 7
const MIN_JUMP = -40

var linear_vel = Vector2()
var onair_time = 0 #
var on_floor = false

var move_sound
var jump_sound = preload("res://assets/sound_effects/player/sfx_movement_jump1.wav")

# items
var no_lives
var no_stars

var anim=""

#cache the sprite here for fast access (we will set scale to flip it often)
onready var sprite = $AnimatedSprite

func _ready():
	get_node("/root/global").connect("decrease_life", self, "hurt_player")
	get_node("/root/global").connect("star_pickup", self, "increase_star")
	no_lives = 3.0
	no_stars = 0

# global will emit signal when player has been hurt (indicated by spike instance script, etc)
func hurt_player(amount):
	if no_lives - amount <= 0:
		print("game_over")
	no_lives -= amount

func increase_star():
	no_stars += 1
	
# make it invisible and inactive
func prep_animation():
	hide()
	$Camera2D.current = false
	$AnimatedSprite.stop()
	set_physics_process(false)

# make visible again and active
func finish_animation():
	show()
	$Camera2D.current = true
	set_physics_process(true)

# input
func _physics_process(delta):
	#increment counters
	onair_time += delta

	### MOVEMENT ###

	# Apply Gravity
	linear_vel += delta * GRAVITY_VEC
	# Move and Slide
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	# Detect Floor
	if is_on_floor():
		onair_time = 0

	on_floor = onair_time < MIN_ONAIR_TIME

	### CONTROL ###

	# Horizontal Movement
	var target_speed = 0
	if Input.is_action_pressed("ui_left"):
		target_speed -= 1
	if Input.is_action_pressed("ui_right"):
		target_speed +=  1

	target_speed *= WALK_SPEED
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)

	# Jumping
	if on_floor and Input.is_action_just_pressed("ui_up"):
		linear_vel.y = -JUMP_SPEED
		$AudioStreamPlayer.stream = jump_sound
		$AudioStreamPlayer.play()
	if !on_floor and !Input.is_action_pressed("ui_up"):
		if linear_vel.y < MIN_JUMP:
			linear_vel.y = MIN_JUMP
		
	### ANIMATION ###

	var new_anim = "idle"

	if on_floor:
		if linear_vel.x < -SIDING_CHANGE_SPEED:
			sprite.flip_h = true
			new_anim = "walk"

		if linear_vel.x > SIDING_CHANGE_SPEED:
			sprite.flip_h = false
			new_anim = "walk"
	else:
		# We want the character to immediately change facing side when the player
		# tries to change direction, during air control.
		# This allows for example the player to shoot quickly left then right.
		if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
			sprite.flip_h = true
		if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
			sprite.flip_h = false

		if !on_floor:
			new_anim = "jump"

	if new_anim != anim:
		anim = new_anim
		$AnimatedSprite.play(anim)
