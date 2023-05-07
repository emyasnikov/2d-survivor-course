extends Node

@export var sword_ability: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
    $Timer.timeout(on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass # Replace with function body.


func on_timer_timeout():
    print("ping")
