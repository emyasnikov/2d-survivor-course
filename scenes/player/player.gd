extends CharacterBody2D
class_name Player

const ACCELERATION_SMOOTHING = 25
const MAX_SPEED = 150

@onready var abilities = $Abilities
@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_bar = $HealthBar
@onready var health_component = $HealthComponent as HealthComponent

var number_colliding_bodies = 0


func _ready():
    $CollisionArea.body_entered.connect(on_body_entered)
    $CollisionArea.body_exited.connect(on_body_exited)
    damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
    health_component.health_changed.connect(on_health_changed)
    GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

    update_health_display()


func _process(delta):
    var movement_vector = get_movement_vector()
    var direction = movement_vector.normalized()
    var target_velocity = direction * MAX_SPEED

    velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
    move_and_slide()


func check_deal_damage():
    if number_colliding_bodies == 0 or not damage_interval_timer.is_stopped():
        return

    health_component.damage(1)
    damage_interval_timer.start()


func get_movement_vector():
    var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

    return Vector2(x_movement, y_movement)


func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, upgrades: Dictionary):
    if not ability_upgrade is Ability:
        return

    var ability = ability_upgrade as Ability

    abilities.add_child(ability.ability_controller_scene.instantiate())


func on_body_entered(body: Node2D):
    number_colliding_bodies += 1
    check_deal_damage()


func on_body_exited(body: Node2D):
    number_colliding_bodies = max(number_colliding_bodies - 1, 0)


func on_damage_interval_timer_timeout():
    check_deal_damage()


func on_health_changed():
    update_health_display()

func update_health_display():
    health_bar.value = health_component.get_health_percent()
