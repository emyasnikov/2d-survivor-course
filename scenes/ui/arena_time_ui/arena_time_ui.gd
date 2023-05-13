extends CanvasLayer

@export var arena_time_manager: Node
@onready var label = %Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if arena_time_manager == null:
        return

    var time_elapsed = arena_time_manager.get_time_elapsed()

    label.text = str(time_elapsed)
