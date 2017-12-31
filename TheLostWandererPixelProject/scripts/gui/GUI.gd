extends MarginContainer

func _ready():
	get_node("/root/global").connect("star_pickup", self, "increase_star")
	
func increase_star():
	$AnimationPlayer.play("expand")
	var count = int($info/c/count.text)
	count += 1
	$info/c/count.text = str(count)

func _on_AnimationPlayer_animation_finished( name ):
	if name == "expand":
		$AnimationPlayer.play("shrink")
