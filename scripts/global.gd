extends Node

signal decrease_life(amount)
signal star_pickup

var current_scene = null
var current_level = 0

# dictionary syntax
#var d = { "name": "john", "age": 22 } # simple syntax
#print("Name: ", d["name"], " Age: ", d["age"])

var levels_star_count = {
	"level1": 0,
	"level2": 0,
	"level3": 0,
	"level4": 0,
	"level5": 0,
	"level6": 0,
	"level7": 0,
	"level8": 0,
}

# params: String, Integer
func set_star_count(level_name, star_count):
	if star_count > levels_star_count[level_name]:
		levels_star_count[level_name] = star_count


# TODO: Upon completing a level, check number of stars and see if the number of stars
# is greater than the current number of stars. If so, update it, otherwise don't.
# and then in mainmenu.gd, everytime it is instanced, update the corresponding
# level with its number of stars achieved. Also unlock the level if stars >= 1 or
# it is the next level available.
func _ready():
	OS.set_window_size(Vector2(800, 480)) # may have to delete if causing errors with mobile
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() - 1)
	
func decrease_lives(no_lives):
	emit_signal("decrease_life", no_lives)
	
func star_picked_up():
	emit_signal("star_pickup")
	
func set_level(level):
	current_level = level

# path -> the path to the scene to be loaded
# play_anim -> whether or not the starting cutscene for
# the level should be played or not
func goto_scene(path, dont_play_anim=null):

    # This function will usually be called from a signal callback,
    # or some other function from the running scene.
    # Deleting the current scene at this point might be
    # a bad idea, because it may be inside of a callback or function of it.
    # The worst case will be a crash or unexpected behavior.

    # The way around this is deferring the load to a later time, when
    # it is ensured that no code from the current scene is running:
	call_deferred("_deferred_goto_scene",path, dont_play_anim)
	
func _deferred_goto_scene(path, dont_play_anim):
	# Immediately free the current scene, there is no risk here
	current_scene.free()
	
	# Load new scene
	var s = ResourceLoader.load(path)
	
	# Instance the new scene
	current_scene = s.instance()
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
	# optional, make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene(current_scene)
	
	# The user has restarted the level, so dont play the animation
	if dont_play_anim:
		current_scene.set_anim(true)
		
func get_level_star_count():
	return levels_star_count
	