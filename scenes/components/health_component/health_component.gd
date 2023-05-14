extends Node
class_name HealthComponent

signal died

@export var max_health: float = 10

var current_health


# Called when the node enters the scene tree for the first time.
func _ready():
    current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func damage(damage_amount: float):
    current_health = max(current_health - damage_amount, 0)

    if current_health == 0:
        died.emit()
        owner.queue_free()