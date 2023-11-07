extends Node

# Inventory
signal inventory_opened( inventory )
signal inventory_closed
signal inventory_ready
signal player_inventory_ready ( inventories )


# Interactables
signal item_picked ( item, sender )


# UI
signal ui_scale_changed ( uiScale )
