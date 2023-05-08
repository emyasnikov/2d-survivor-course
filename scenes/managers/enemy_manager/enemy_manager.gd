extends Node

const SPAWN_RADIUS = 340

@export var basic_enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _on_timer_timeout():
    var player = get_tree().get_first_node_in_group("player") as Node2D

    if player == null:
        return

    var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
    var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
    var enemy = basic_enemy_scene.instantiate() as Node2D

    get_parent().add_child(enemy)
    enemy.global_position = spawn_position
