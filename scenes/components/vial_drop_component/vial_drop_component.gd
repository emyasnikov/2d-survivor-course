extends Node

@export var health_component: HealthComponent
@export var vial_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
    health_component.died.connect(on_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func on_died():
    if vial_scene == null:
        return

    if not owner is Node2D:
        return

    var spawn_position = (owner as Node2D).global_position
    var vial_instance = vial_scene.instantiate() as Node2D

    owner.get_parent().add_child(vial_instance)
    vial_instance.global_position = spawn_position