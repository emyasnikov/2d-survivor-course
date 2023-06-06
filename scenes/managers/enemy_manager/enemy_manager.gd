extends Node

const SPAWN_RADIUS = 340

@onready var timer = $Timer

@export var arena_time_manager: ArenaTimeManager
@export var basic_enemy_scene: PackedScene

var base_spawn_time = 0


func _ready():
    arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)
    timer.timeout.connect(on_timer_timeout)

    base_spawn_time = timer.wait_time


func get_spawn_position(player):
    if player == null:
        return Vector2.ZERO

    var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
    var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)

    var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1 << 0)
    var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)

    if not result.is_empty():
        return player.global_position

    return spawn_position


func on_arena_difficulty_increased(arena_difficulty: int):
    var time_off = max((0.1 / 12) * arena_difficulty, 0.7)

    timer.wait_time = base_spawn_time - time_off


func on_timer_timeout():
    timer.start()

    var player = get_tree().get_first_node_in_group("player") as Node2D

    if player == null:
        return

    var enemy = basic_enemy_scene.instantiate() as Node2D
    var entities_layer = get_tree().get_first_node_in_group("entities_layer")

    entities_layer.add_child(enemy)
    enemy.global_position = get_spawn_position(player)
