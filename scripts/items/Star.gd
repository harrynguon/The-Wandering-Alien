extends Area2D

signal star_picked_up

var active
var going_up

# Start the floating animation upon instantiation
func _ready():
	active = true
	going_up = false
	connect("body_entered", self, "_on_Star_body_entered")
	$Tween.interpolate_property($Sprite, "position", $Sprite.position,\
			$Sprite.position + Vector2(0.0, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

# When the player picks up the star, fade out and self destruct
func _on_Star_body_entered( body ):
	if body.get_name() == "Player" and active:
		emit_signal("star_picked_up")
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("fade_out")
		active = false

# Self-destruct
func _on_AnimationPlayer_animation_finished( name ):
	queue_free()

# Loop the animation
func _on_Tween_tween_completed( object, key ):
	if going_up:
		$Tween.interpolate_property($Sprite, "position", $Sprite.position,\
				$Sprite.position - Vector2(0.0, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
		going_up = false
	else:
		$Tween.interpolate_property($Sprite, "position", $Sprite.position,\
				$Sprite.position + Vector2(0.0, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
		going_up = true
	$Tween.start()
