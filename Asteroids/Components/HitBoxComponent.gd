@tool
extends Area2D

@export var collision_shape: CollisionShape2D
@export var type_name: String = ""

signal hitbox_entered(shape)
signal hitbox_exited(shape)
signal damage_taken(dmg)

func _enter_tree():
	if collision_shape == null:
		collision_shape = $CollisionShape2D
		#collision_shape.shape = RectangleShape2D.new()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_parent().set_editable_instance(self, true);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	emit_signal("hitbox_entered", area)
	
	var dmg = area.get_parent().find_child("DamageComponent")
	if dmg:
		emit_signal("damage_taken", dmg)

func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	emit_signal("hitbox_exited", area)
