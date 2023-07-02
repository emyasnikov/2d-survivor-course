extends Node

@export var axe_ability_scene: PackedScene


func _ready():
    $Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
    var player = get_tree().get_first_node_in_group("player") as Player

    if player == null:
        return

    var foreground = get_tree().get_first_node_in_group("foreground_layer") as Node2D

    if foreground == null:
        return

    var axe_ability_instance = axe_ability_scene.instantiate() as AxeAbility

    foreground.add_child(axe_ability_instance)
    axe_ability_instance.global_position = player.global_position
