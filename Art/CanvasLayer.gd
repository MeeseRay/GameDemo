extends CanvasLayer

@onready var main = $Main
@onready var how_to_play = $HOW_TO_PLAY




func _on_play_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	#jump into the game screen 
	#this does not work. 

func _on_how_to_play_pressed():
	main.visible = false
	how_to_play.visible = true


func _on_exit_pressed():
	get_tree().quit()
	#simplly quit the game 


func _on_back_pressed():
	main.visible = true
	how_to_play.visible = false
	#inside the "How to play" menu and going back to main_menu
	
