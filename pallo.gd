extends RigidBody2D

const PALLON_NOPEUS = 4
const PELIALUE_X = 1010
const PELIALUE_Y = 600

onready var root = get_node("/root/peli")
onready var lauta = get_node("../lauta")
onready var soundit = get_node("../soundit")

var voima_luokka= preload("res://voima.tscn")
var pallo_suunta = Vector2(2, PALLON_NOPEUS)
var supervoima = false

func _ready():
	#set_use_custom_integrator(true)
	set_fixed_process(true)

func _integrate_forces(state):
	set_linear_velocity(pallo_suunta.normalized()*state*PALLON_NOPEUS)
	
func _fixed_process(delta):
	
	if (is_colliding()):
		
		var tormaaja = get_collider()
		
		if (tormaaja == lauta):
			var osuu_kohtaan = (get_pos().x - lauta.get_pos().x) / 10
			pallo_suunta = Vector2(osuu_kohtaan, -PALLON_NOPEUS)
			soundit.play("blomp2")
		#elif(tormaaja.get_name() == "voima"):
		#	pass
		else:
			#tiili, koska muutakaan ei ole
			var normaali = get_collision_normal()
			soundit.play("blomp")
			
			if (!supervoima):
				#todo: pongauta pallo fysiikan lakien mukaan
				pallo_suunta = Vector2(pallo_suunta.x, -pallo_suunta.y)
			
			#todo: siirrä muualle
			if (get_tree().get_nodes_in_group("tiilet").size() < 2):
				root.GeneroiKentta()
			elif (randi() % 2):
				var voima = voima_luokka.instance()
				voima.set_pos(tormaaja.get_pos())
				root.add_child(voima)
			#queue_free kaataa, ehtii törmätä uusiksi vaikka ei ole enää olemassa
			tormaaja.free()
		
	if (get_pos().y < 10):
		pallo_suunta = Vector2(pallo_suunta.x, PALLON_NOPEUS)
	if (get_pos().x < 10):
		pallo_suunta = Vector2(2, pallo_suunta.y)
	if (get_pos().x > PELIALUE_X):
		pallo_suunta = Vector2(-2, pallo_suunta.y)
	if (get_pos().y > PELIALUE_Y):
		set_pos(Vector2(PELIALUE_Y -100, 300))
		lauta.Venyta(0.9)
	
	move(pallo_suunta)

func Supermode():
	supervoima = true
	get_node("kuva").hide()
	get_node("superpallo").show()