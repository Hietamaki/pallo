extends KinematicBody2D

func _ready():
	add_to_group("voima")
	set_fixed_process(true)
	
	if (randi() % 5):
		get_node("super2").show()
	else:
		get_node("super1").show()

func _fixed_process(delta):
	move(Vector2(0, 2))
	
	if (get_pos().y > get_node("../pallo").PELIALUE_Y):
		queue_free()
	
	if (is_colliding()):
		if (get_collider().get_name() == "lauta"):
			if (get_node("super1").is_hidden()):
				get_node("../lauta").Venyta(1.1)
			else:
				get_node("../pallo").Supermode()
			free()