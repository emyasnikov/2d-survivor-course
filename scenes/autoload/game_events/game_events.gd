extends Node

signal ability_upgrade_added(upgrade: AbilityUpgrade, upgrades: Dictionary)
signal experience_vial_collected(number: float)


func emit_ability_upgrade_added(upgrade: AbilityUpgrade, upgrades: Dictionary):
    ability_upgrade_added.emit(upgrade, upgrades)


func emit_experience_vial_collected(number: float):
    experience_vial_collected.emit(number)
