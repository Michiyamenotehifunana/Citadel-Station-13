/obj/structure/bed/wood
	name = "wooden bed"
	desc = "This is used to lie in, sleep in or strap on. Made of wood."
	icon_state = "bed-wood"
	icon = 'code/citadel/icons/objects.dmi'
	buildstacktype = /obj/item/stack/sheet/mineral/wood

/obj/structure/bed/wood/head
	desc = "This is used to lie in, sleep in or strap on. Made of wood and has a headboard."
	icon_state = "bed-woodpost"
	buildstackamount = 3

GLOBAL_LIST_INIT(cit_wood_recipes, list ( \
	new/datum/stack_recipe("wooden bed", /obj/structure/bed/wood, 2, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("ornate wooden bed", /obj/structure/bed/wood/head, 3, one_per_turf = TRUE, on_floor = TRUE), \
	))