extends CanvasLayer


func _ready():
    get_tree().paused = true

    %QuitButton.pressed.connect(on_quit_button_pressed)
    %RestartButton.pressed.connect(on_restart_button_pressed)


func on_quit_button_pressed():
    get_tree().quit()


func on_restart_button_pressed():
    get_tree().change_scene_to_file("res://scenes/main/main.tscn")
