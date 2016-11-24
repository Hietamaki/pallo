
extends Node2D

const PALLON_NOPEUS = 4
const PELIALUE_X = 1000
const PELIALUE_Y = 600
var pallo_suunta = Vector2(2, PALLON_NOPEUS)
var tiilet = Array()
onready var pallo = get_node("pallo")
onready var lauta = get_node("lauta")
onready var tiili_malli = get_node("tiili")
onready var lauta_koko = lauta.get_texture().get_size()
onready var tiili_koko = tiili_malli.get_texture().get_size()
onready var soundit = get_node("soundit")

func _input(ev):
	
	# Mouse in viewport coordinates
	
	if (ev.type==InputEvent.MOUSE_BUTTON):
		print("Mouse Click/Unclick at: ",ev.pos)
	elif (ev.type==InputEvent.MOUSE_MOTION):
		lauta.set_pos(Vector2(ev.pos.x, lauta.get_pos().y))
		#print("Mouse Motion at: ",ev.pos)


func _fixed_process(delta):
	
	for tiili in tiilet:
		
		var tiili_alue = Rect2(tiili.get_pos() - tiili_koko / 2, tiili_koko)
		
		if (tiili_alue.has_point(pallo.get_pos())):
			tiilet.erase(tiili)
			tiili.queue_free()
			soundit.play("blomp")
	
	var lauta_alue = Rect2(lauta.get_pos() - lauta_koko / 2, lauta_koko)
	
	if (lauta_alue.has_point(pallo.get_pos())):
		var osuu_kohtaan = (pallo.get_pos().x - lauta.get_pos().x) / 10
		pallo_suunta = Vector2(osuu_kohtaan, -PALLON_NOPEUS)
		soundit.play("blomp2")
			
	if (pallo.get_pos().y < 10):
		pallo_suunta = Vector2(pallo_suunta.x, PALLON_NOPEUS)
	if (pallo.get_pos().x < 10):
		pallo_suunta = Vector2(2, pallo_suunta.y)
	if (pallo.get_pos().x > 1000):
		pallo_suunta = Vector2(-2, pallo_suunta.y)
	if (pallo.get_pos().y > 600):
		pallo.set_pos(Vector2(500, 300))
	
	var pallo_sijainti = pallo.get_pos()
	pallo.set_pos(pallo_sijainti + pallo_suunta)
	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process_input(true)
	set_fixed_process(true)
	
	for i in range(100):
		
		var tiili = tiili_malli.duplicate()
		print(tiili.set_pos(Vector2(50 + randi() % 20 * 50, 20 + randi() % 20 * 20)))
		get_node(".").add_child(tiili)
		#print(tiili.get_texture().get_name() + " " + str(tiili.get_pos().y) + " "+str(tiili.is_hidden()) + str(tiili.get_parent()))
	
		tiilet.append(tiili)
	