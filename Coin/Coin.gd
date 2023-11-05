extends Area2D


signal coin_collected

func _on_body_entered(_body):
	$AnimationPlayer.play("bounce") #bounce action
	emit_signal("coin_collected")
	set_collision_mask_value(1,false)
	
	
	
func _on_animation_player_animation_finished(_anim_name):
	queue_free()
	#when bounce animation finishes, coin disappear. 
	#and this is the group of codes does that 


