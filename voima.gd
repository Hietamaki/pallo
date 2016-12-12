extends KinematicBody2D

func _ready():
	add_to_group("voima")
	set_fixed_process(true)
	
	if (randi() % 5):
		get_node("super2").show()
	else:
		get_node("super1").show()

onready var lauta = get_node("/root/peli/lauta")

func _fixed_process(delta):
	move(Vector2(0, 2))
	
	if (get_pos().y > get_node("/root/peli/pallo").PELIALUE_Y):
		queue_free()
	
	if (is_colliding()):
		if (get_collider() == lauta):
			SuperEfekti()

func SuperEfekti():
	if (get_node("super1").is_hidden()):
		lauta.Venyta(1.1)
	else:
		get_node("/root/peli/pallo").Supermode()
	queue_free()