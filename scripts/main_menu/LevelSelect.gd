extends Node2D

var star_icon = preload("res://assets/art/level_select/star_button.png")

func _ready():
	pass

# sets the number of stars on the level select screen according to
# what the star count is in the dictionary.
func set_star_counts(star_counts):
	for i in range(1, (star_counts.size()/2) + 1): # half size because of the boolean values
		var level_name = "level%s" % i
		var node_path = "Border/Levels/"
		var number_of_stars = star_counts[level_name]
		if number_of_stars == -1:
			continue
		var level_node = get_node(node_path+level_name)
		var level_node_children = level_node.get_children() # index:1,2,3 are the star icons
		for j in range(1, number_of_stars + 1):
			level_node_children[j].texture = star_icon
	
func lock_level(level):
	# TODO:
	# Set the process to false (meaning that it cannot be clicked).
	var level_number_node = get_node("Border/Levels/level%s/LevelNumber" % level)
	level_number_node.hide()
	
func unlock_level(level):
	var level_number_node = get_node("Border/Levels/level%s/LevelNumber" % level)
	level_number_node.show()
	var level_lock_node = get_node("Border/Levels/level%s/lock" % level)
	level_lock_node.hide()
