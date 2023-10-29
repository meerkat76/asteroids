extends CharacterBody2D

@export var health: HealthComponent

@onready var bullet_scene = preload("res://bullet.tscn")
var ui
# Called when the node enters the scene tree for the first time.
func _ready():
	health = $HealthComponent
	ui = get_tree().root.get_node("World").find_child("UI")
	print(ui)
	$HitBoxComponent.connect("damage_taken", take_damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if $HealthComponent.health <= 0:
		velocity = Vector2.ZERO 
		return
		
	if Input.is_action_pressed("w"):
		$VelocityComponent.accelerate_max_velocity(delta, global_rotation)
	
	if Input.is_action_just_pressed("fire"):
		fire()
		
	if Input.is_action_pressed("a"):
		global_rotation += -2.0 * delta
	if Input.is_action_pressed("d"):
		global_rotation += 2.0 * delta
		
	velocity = $VelocityComponent.velocity
	
	position.x = wrapf(position.x, 0, get_viewport().size.x)
	position.y = wrapf(position.y, 0, get_viewport().size.y)
	
	
	move_and_slide()

func fire():
	var vel = Vector2(50, 0).rotated(global_rotation)
	var bullet = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.direction = vel
	bullet.top_level = true
	add_child(bullet)
	
func take_damage(dmg):
	if dmg.type_name == "asteroid":
		$HealthComponent.take_damage(dmg.damage)
		ui.update_hp($HealthComponent.health)

func _on_health_component_death():
	ui.show_new_game()
