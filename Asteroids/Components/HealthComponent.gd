extends Node
class_name HealthComponent

@export var health: int = 100
@export var max_health: int = 100
signal damage_dealt(dmg, health, prev_health)
signal death

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func take_damage(dmg: int):
	var prev_health = health
	
	health -= dmg
	
	if health <= 0:
		emit_signal("death")
		return
		
	emit_signal("damage_dealt", dmg, health, prev_health)
		
