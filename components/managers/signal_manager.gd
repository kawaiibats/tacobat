extends Node

# Inventory
signal inventory_opened( inventory )
signal inventory_closed
signal inventory_ready
signal player_inventory_ready ( inventories )
signal item_dropped


# Interactables
signal item_picked ( item, sender, quantity )


# UI
signal ui_scale_changed ( uiScale )
