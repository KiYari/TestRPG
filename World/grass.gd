extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		var grassDestroyed = load("res://World/GrassDestroyed.tscn")
		var grassdestroyed = grassDestroyed.instance()
		
		var main = get_tree().current_scene
		
		main.add_child(grassdestroyed)
		grassdestroyed.global_position = global_position
		
		queue_free()
