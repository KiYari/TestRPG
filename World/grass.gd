extends Node2D

const grassDestroyed = preload("res://Effects/effect.tscn")

func create_grass_effect():
	var grassdestroyed = grassDestroyed.instance()
		
	var main = get_tree().current_scene
		
	get_parent().add_child(grassdestroyed)
	grassdestroyed.global_position = global_position


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
