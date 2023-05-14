extends Node

var current_experience = 0


# Called when the node enters the scene tree for the first time.
func _ready():
    GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(number: float):
    current_experience += number


func on_experience_vial_collected(number: float):
    increment_experience(number)
