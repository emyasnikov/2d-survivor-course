extends Node2D


func _ready():
    $Area2D.area_entered.connect(on_area_2d_area_entered)


func on_area_2d_area_entered(area: Area2D):
    GameEvents.emit_experience_vial_collected(1)
    queue_free()
