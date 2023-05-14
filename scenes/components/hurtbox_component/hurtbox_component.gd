extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
    area_entered.connect(on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func on_area_entered(area: Node2D):
    if not area is HitboxComponent:
        return

    if health_component == null:
        return

    var hitbox_component = area as HitboxComponent

    health_component.damage(hitbox_component.damage)
