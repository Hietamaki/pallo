extends KinematicBody2D

var voima_luokka= preload("res://voima.tscn")
onready var root = get_node("/root/peli")

func _ready():
	print("ok")
	add_to_group("tiilet")

func Osuma():
	if (randi() % 2):
		var voima = voima_luokka.instance()
		voima.set_pos(get_pos())
		print(get_node("/root/peli").get_name())
		get_node("/root/peli").add_child(voima)
	
	return true
	