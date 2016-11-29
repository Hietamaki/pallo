extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const PALLON_NOPEUS = 4
const PELIALUE_X = 1010
const PELIALUE_Y = 600
var pallo_suunta = Vector2(2, PALLON_NOPEUS)
var tippuu = Array()
var supervoima = false
onready var root = get_node("/root/peli")
onready var lauta = get_node("../lauta")
onready var lauta_koko = get_node("../lauta/kuva").get_texture().get_size()
onready var soundit = get_node("../soundit")

onready var tiili_malli = get_node("../tiili")
onready var tiili_koko = get_node("../tiili/kuva").get_texture().get_size()


func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	
	if (is_colliding()):
		
		if (get_collider().get_name() == "lauta"):
			var osuu_kohtaan = (get_pos().x - lauta.get_pos().x) / 10
			pallo_suunta = Vector2(osuu_kohtaan, -PALLON_NOPEUS)
			soundit.play("blomp2")
		else:
			#tiili koska muutakaan ei ole
			var tiili = get_collider()
			var normaali = get_collision_normal()
			
			soundit.play("blomp")
			
			if (!supervoima):
				#todo: pongauta pallo fysiikan lakien mukaan
				pallo_suunta = Vector2(pallo_suunta.x, -pallo_suunta.y)
			
			#todo: siirrä muualle
			if (get_tree().get_nodes_in_group("tiilet").size() < 75):
				root.GeneroiKentta()
			#elif (randi() % 2):
			#	LuoSuper(tiili.get_pos())
			
			#queue_free kaataa, ehtii törmätä uusiksi vaikka ei ole enää olemassa
			tiili.free()
			
	if (get_pos().y < 10):
		pallo_suunta = Vector2(pallo_suunta.x, PALLON_NOPEUS)
	if (get_pos().x < 10):
		pallo_suunta = Vector2(2, pallo_suunta.y)
	if (get_pos().x > PELIALUE_X):
		pallo_suunta = Vector2(-2, pallo_suunta.y)
	if (get_pos().y > PELIALUE_Y):
		set_pos(Vector2(PELIALUE_Y -100, 300))
		lauta.VenytaLautaa(0.9)
	
	move(pallo_suunta)
	