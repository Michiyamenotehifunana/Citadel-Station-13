/*
			Citadel's Exclusive armor (Armor vests, space suits, jackets, helmets, etc.) go here I guess
*/

	// Lavaknight Armor

/obj/item/clothing/head/helmet/space/hardsuit/lavaknight
	name = "cydonian helmet"
	desc = "A helmet designed with both form and function in mind, it protects the user against physical trauma and hazardous conditions while also having polychromic light strips."
	icon = 'icons/obj/clothing/cit_hats.dmi'
	icon_state = "knight_cydonia"
	item_state = "knight_yellow"
	item_color = null
	alternate_worn_icon = 'icons/mob/citadel/head.dmi'
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	heat_protection = HEAD
	armor = list(melee = 50, bullet = 10, laser = 10, energy = 10, bomb = 50, bio = 100, rad = 50, fire = 75, acid = 75)
	brightness_on = 7
	allowed = list(/obj/item/device/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/device/mining_scanner, /obj/item/device/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator)
	var/energy_color = "#35FFF0"

/obj/item/clothing/head/helmet/space/hardsuit/lavaknight/attack_self(mob/user)
	on = !on

	if(on)
		set_light(brightness_on)
	else
		set_light(0)
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/head/helmet/space/hardsuit/lavaknight/update_icon()
	var/mutable_appearance/helm_overlay = mutable_appearance('icons/obj/clothing/cit_hats.dmi', "knight_cydonia_overlay", LIGHTING_LAYER + 1)

	if(energy_color)
		helm_overlay.color = energy_color

	helm_overlay.plane = LIGHTING_PLANE + 1	//Magic number is used here because we have no ABOVE_LIGHTING_PLANE plane defined. Lighting plane is 15, HUD is 18

	cut_overlays()		//So that it doesn't keep stacking overlays non-stop on top of each other

	add_overlay(helm_overlay)

	emissivelights()

	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/head/helmet/space/hardsuit/lavaknight/equipped(mob/user, slot)
	..()
	emissivelights()

/obj/item/clothing/head/helmet/space/hardsuit/lavaknight/dropped(mob/user)
	..()
	emissivelightsoff()

/obj/item/clothing/head/helmet/space/hardsuit/lavaknight/proc/emissivelights(mob/user = usr)
	var/mutable_appearance/energy_overlay = mutable_appearance('icons/mob/citadel/head.dmi', "knight_cydonia_overlay", LIGHTING_LAYER + 1)
	energy_overlay.color = energy_color
	energy_overlay.plane = LIGHTING_PLANE + 1
	user.cut_overlay(energy_overlay)	//honk
	user.add_overlay(energy_overlay)	//honk

/obj/item/clothing/head/helmet/space/hardsuit/lavaknight/proc/emissivelightsoff(mob/user = usr)
	user.cut_overlays()
	user.regenerate_icons()    //honk

/obj/item/clothing/suit/space/hardsuit/lavaknight
	icon = 'icons/obj/clothing/cit_suits.dmi'
	icon_state = "knight_cydonia"
	name = "cydonian armor"
	desc = "A suit designed with both form and function in mind, it protects the user against physical trauma and hazardous conditions while also having polychromic light strips."
	item_state = "swat_suit"
	alternate_worn_icon = 'icons/mob/citadel/suit.dmi'
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	armor = list(melee = 50, bullet = 10, laser = 10, energy = 10, bomb = 50, bio = 100, rad = 50, fire = 75, acid = 75)
	allowed = list(/obj/item/device/flashlight, /obj/item/tank/internals, /obj/item/storage/bag/ore, /obj/item/pickaxe)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/lavaknight
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	actions_types = list(/datum/action/item_action/toggle_helmet, /datum/action/item_action/pick_color)
	var/obj/item/clothing/head/helmet/space/hardsuit/lavaknight/linkedhelm

	var/energy_color = "#35FFF0"

/obj/item/clothing/suit/space/hardsuit/lavaknight/New()
	..()
	if(helmet)
		linkedhelm = helmet
	light_color = energy_color
	set_light(1)

/obj/item/clothing/suit/space/hardsuit/lavaknight/update_icon()
	var/mutable_appearance/suit_overlay = mutable_appearance('icons/obj/clothing/cit_suits.dmi', "knight_cydonia_overlay", LIGHTING_LAYER + 1)

	if(energy_color)
		suit_overlay.color = energy_color

	suit_overlay.plane = LIGHTING_PLANE + 1		//Magic number is used here because we have no ABOVE_LIGHTING_PLANE plane defined. Lighting plane is 15.

	cut_overlays()		//So that it doesn't keep stacking overlays non-stop on top of each other

	add_overlay(suit_overlay)

	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/suit/space/hardsuit/lavaknight/equipped(mob/user, slot)
	..()
	if(slot != slot_wear_suit)
		emissivelights()

/obj/item/clothing/suit/space/hardsuit/lavaknight/dropped(mob/user)
	..()
	emissivelightsoff()

/obj/item/clothing/suit/space/hardsuit/lavaknight/proc/emissivelights(mob/user = usr)
	var/mutable_appearance/energy_overlay = mutable_appearance('icons/mob/citadel/suit.dmi', "knight_cydonia_overlay", LIGHTING_LAYER + 1)
	energy_overlay.color = energy_color
	energy_overlay.plane = LIGHTING_PLANE + 1
	user.cut_overlay(energy_overlay)	//honk
	user.add_overlay(energy_overlay)	//honk

/obj/item/clothing/suit/space/hardsuit/lavaknight/proc/emissivelightsoff(mob/user = usr)
	user.cut_overlays()
	user.regenerate_icons()    //honk

/obj/item/clothing/suit/space/hardsuit/lavaknight/ui_action_click(mob/user, var/datum/action/A)
	if(istype(A, /datum/action/item_action/pick_color))
		if(alert("Are you sure you want to recolor your armor stripes?", "Confirm Repaint", "Yes", "No") == "Yes")
			var/energy_color_input = input(usr,"Choose Energy Color") as color|null
			if(energy_color_input)
				energy_color = sanitize_hexcolor(energy_color_input, desired_format=6, include_crunch=1)
				user.update_inv_wear_suit()
				if(linkedhelm)
					linkedhelm.energy_color = sanitize_hexcolor(energy_color_input, desired_format=6, include_crunch=1)
					user.update_inv_head()
					linkedhelm.update_icon()
				update_icon()
				user.update_inv_wear_suit()
				light_color = energy_color
				emissivelights()
				update_light()

	else
		..()