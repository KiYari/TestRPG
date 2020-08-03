extends Node2D

func create_grass_effect():
	var grassDestroyed = load("res://World/GrassDestroyed.tscn")
	var grassdestroyed = grassDestroyed.instance()
		
	var main = get_tree().current_scene
		
	main.add_child(grassdestroyed)
	grassdestroyed.global_position = global_position


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
