extends Node2D

func _ready():
	pass
	
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
