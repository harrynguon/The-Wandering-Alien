extends Node2D

var star_icon = preload("res://assets/art/level_select/star_button.png")

func _ready():
	pass

# sets the number of stars on the level select screen according to
# what the star count is in the dictionary.
func set_star_counts(star_counts):
	for i in range(1, star_counts.size() + 1):
		var level_name = "level%s" % i
		var node_path = "Border/Levels/"
		var number_of_stars = star_counts[level_name]
		var level_node = get_node(node_path+level_name)
		var level_node_children = level_node.get_children() # index:1,2,3 are the star icons
		for j in range(1, number_of_stars + 1):
			level_node_children[j].texture = star_icon
	
func lock_level(level):
	# TODO:
	# Set the process to false (meaning that it cannot be clicked).
	if level == 2:
		$Border/Levels/level2/LevelNumber.hide()
	elif level == 3:
		$Border/Levels/level3/LevelNumber.hide()
	elif level == 4:
		$Border/Levels/level4/LevelNumber.hide()
	elif level == 5:
		$Border/Levels/level5/LevelNumber.hide()
	elif level == 6:
		$Border/Levels/level6/LevelNumber.hide()
	elif level == 7:
		$Border/Levels/level7/LevelNumber.hide()
	elif level == 8:
		$Border/Levels/level8/LevelNumber.hide()
