extends KinematicBody2D

var voima_luokka= preload("res://voima.tscn")
onready var root = get_node("/root/peli")

func _ready():
	print("ok")
	add_to_group("tiilet")

func Osuma():
	#http://docs.godotengine.org/en/stable/tutorials/ray-casting.html
	
	queue_free()
	return true
	