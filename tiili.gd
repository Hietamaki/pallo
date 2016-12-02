extends KinematicBody2D

var voima_luokka= preload("res://voima.tscn")

func _ready():
	add_to_group("tiilet")

func Osuma():

	if (get_tree().get_nodes_in_group("tiilet").size() < 2):
		get_node("/root/peli").GeneroiKentta()
	elif (randi() % 2):
		var voima = voima_luokka.instance()
		voima.set_pos(get_pos())
		get_node("/root/peli").add_child(voima)
	
	return true
	