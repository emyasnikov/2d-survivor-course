extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}


func _ready():
    experience_manager.level_up.connect(on_level_up)


func apply_upgrade(upgrade: AbilityUpgrade):
    var has_upgrade = current_upgrades.has(upgrade.id)

    if not has_upgrade:
        current_upgrades[upgrade.id] = {
            "quantity": 1,
            "resource": upgrade
        }
    else:
        current_upgrades[upgrade.id]["quantity"] += 1

    GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func on_level_up(new_level: int):
    var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen

    add_child(upgrade_screen_instance)

    var chosen_upgrades = pick_upgrades()

    upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
    upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)


func on_upgrade_selected(upgrade: AbilityUpgrade):
    apply_upgrade(upgrade)


func pick_upgrades():
    var chosen_upgrades: Array[AbilityUpgrade] = []
    var filtered_upgrades = upgrade_pool.duplicate() as Array[AbilityUpgrade]

    for i in 2:
        var chosen_upgrade = filtered_upgrades.pick_random() as AbilityUpgrade

        chosen_upgrades.append(chosen_upgrade)

        filtered_upgrades = filtered_upgrades.filter(func (upgrade: AbilityUpgrade):
            return upgrade.id != chosen_upgrade.id
        )

    return chosen_upgrades
