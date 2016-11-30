extends KinematicBody2D

const PALLON_NOPEUS = 300
const PELIALUE_X = 1010
const PELIALUE_Y = 600

onready var root = get_node("/root/peli")
onready var lauta = get_node("../lauta")
onready var soundit = get_node("../soundit")

var voima_luokka= preload("res://voima.tscn")
var pallo_suunta = Vector2(2, 4)
var supervoima = false
var aloitus = true
var aika_viimeksi

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	
	if (is_colliding()):
		
		var tormaaja = get_collider()
		
		if (tormaaja == lauta):
			if (OS.get_unix_time() != aika_viimeksi):
				var osuu_kohtaan = (get_pos().x - lauta.get_pos().x) / 10
				pallo_suunta = Vector2(osuu_kohtaan, -pallo_suunta.y)
				soundit.play("blomp2")
				print (OS.get_unix_time())
				aika_viimeksi = OS.get_unix_time()
		#elif(tormaaja.get_name() == "voima"):
		#	pass
		else:
			#tiili, koska muutakaan ei ole
			var normaali = get_collision_normal()
			print (normaali)
			soundit.play("blomp")
			
			if (!supervoima):
				#olettaa kaikkien tasojen olevan vaaka tai kohtisuoria
				if (abs(normaali.x) < abs(normaali.y)):
					pallo_suunta = Vector2(pallo_suunta.x, -pallo_suunta.y)
				else:
					pallo_suunta = Vector2(-pallo_suunta.x, pallo_suunta.y)
				
			
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
		pallo_suunta = Vector2(pallo_suunta.x, 4)
	if (get_pos().x < 10):
		pallo_suunta = Vector2(2, pallo_suunta.y)
	if (get_pos().x > PELIALUE_X):
		pallo_suunta = Vector2(-2, pallo_suunta.y)
	if (get_pos().y > PELIALUE_Y):
		aloitus = true
		lauta.Venyta(0.9)
		Supermode(false)
	
	
	if (!aloitus):
		pallo_suunta = pallo_suunta.normalized() * PALLON_NOPEUS * delta
		move(pallo_suunta)
	else:
		var sijainti = lauta.get_pos()
		sijainti.y -= 20
		set_pos(sijainti)
	
func Supermode(super_paalle = true):
	if (super_paalle == false):
		supervoima = false
		get_node("superpallo").hide()
		get_node("kuva").show()
	else:
		get_node("kuva").hide()
		get_node("superpallo").show()
		supervoima = true