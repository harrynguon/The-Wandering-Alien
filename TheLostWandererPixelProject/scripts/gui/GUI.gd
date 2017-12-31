extends MarginContainer

func _ready():
	get_node("/root/global").connect("star_pickup", self, "increase_star")
	
func increase_star():
	pass
