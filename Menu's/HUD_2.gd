extends CanvasLayer
var coins = 0

func _ready():
	$Coins.text = str(coins)
	




func _on_coin_collected():
	coins = coins + 1
	_ready()
	#counting up, update the value
	if coins == 3:
		get_tree().change_scene_to_file("res://youwin.tscn")
