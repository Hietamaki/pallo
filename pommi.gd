extends KinematicBody2D

var voima_luokka= preload("res://voima.tscn")
onready var root = get_node("/root/peli")

var tuhoutumassa = false

func _ready():
	print("ok")
	add_to_group("tiilet")

func Osuma():
	var avaruustila = get_world_2d().get_direct_space_state()
	
	for suunta in [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]:
		var paikka = get_pos() + Vector2(root.X_PALIKKA * suunta.x, root.Y_PALIKKA * suunta.y)
		var r = avaruustila.intersect_point(paikka)
		if (!r.empty()):
			var tiili =  r[0].collider
			print (tiili.get_groups())
			if ("tiilet" in tiili.get_groups()):
				if (!tiili.tuhoutumassa):
					tuhoutumassa = true
					tiili.Osuma()
					print (tiili.get_name())
	
	queue_free()
	return true
	