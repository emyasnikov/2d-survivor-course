extends Node2D
class_name AxeAbility

const MAX_RADIUS = 100


func _ready():
    var tween = create_tween()

    tween.tween_method(tween_method, 0.0, 2.0, 2.0)


func tween_method(rotations: float):
    var current_direction = Vector2.RIGHT.rotated(rotations * TAU)
    var percent = rotations / 2
    var root_position = Vector2.ZERO

    var current_radius = percent * MAX_RADIUS

    var player = get_tree().get_first_node_in_group("player")

    if player == null:
        root_position = global_position
    else:
        root_position = player.global_position

    global_position = root_position + (current_direction * current_radius)

