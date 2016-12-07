extends Node2D

const X_PALIKKA = 50
const Y_PALIKKA = 20

onready var tiili_malli = preload("res://tiili.tscn")
onready var pommi_malli = preload("res://pommi.tscn")
onready var soundit = get_node("soundit")

var level_number = 1

func _ready():
	randomize()
	set_fixed_process(true)
	GeneroiKentta(1)

func GeneroiKentta(level_name = false):
	
	if (level_name == false):
		level_number += 1
		level_name = level_number
	
	var kentta = LataaKenttaData(level_name)
	print (kentta)
	var rivi = 0
	var solu = 0
	var kommentti = false
	
	for i in range(kentta.length()):
		var point = kentta.substr(i,1)
		var ascii = point.to_ascii()[0]
		
		if (kommentti):
			if (point == "\n"):
				kommentti = false
			
			continue
		
		if (point == "#"):
			kommentti = true
			continue
			
		if (ascii > 32 and ascii < 127):
			var tiili
			
			if (point == "b"):
				tiili = pommi_malli.instance()
			else:
				tiili = tiili_malli.instance()
			
			tiili.set_pos(Vector2(44 + solu * X_PALIKKA, Y_PALIKKA + rivi * Y_PALIKKA))
			get_node("/root/peli").add_child(tiili)
			
		solu += 1
		
		if (point == "\n"):
			rivi += 1
			solu = 0
		
func LataaKenttaData(kentta):
	
	var file = File.new()
	file.open("res://levels/"+str(kentta), file.READ)
	var sisalto = file.get_as_text()
	file.close()
	return sisalto