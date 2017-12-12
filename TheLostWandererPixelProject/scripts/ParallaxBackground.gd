extends ParallaxBackground

var _offset = 0

func _ready():
	pass
	
func _process(delta):
	_offset += delta
	print(_offset)
	offset = Vector2(_offset, 0)
