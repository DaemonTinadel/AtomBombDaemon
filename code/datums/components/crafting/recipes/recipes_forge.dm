////////////
//Forging//
////////////

/datum/crafting_recipe/forge
	name = "Metalworking bench"
	result = /obj/machinery/workbench/forge
	reqs = list(
		/datum/reagent/fuel = 100,
		/obj/item/weldingtool = 1,
		/obj/item/screwdriver = 1,
		/obj/item/wrench = 1,
		/obj/item/wirecutters = 1,
		/obj/item/stack/sheet/metal = 20,
		)
	time = 400
	category = CAT_CRAFTING
	subcategory = CAT_FORGING

/datum/crafting_recipe/blacksmith/tableanvil
	name = "Table Anvil"
	result = /obj/structure/blacksmith/anvil/obtainable/table
	time = 300
	reqs = list(
		/obj/item/stack/sheet/metal = 8,
		/obj/item/stack/rods = 8,
		)
	tools = list(TOOL_SCREWDRIVER, TOOL_WRENCH, TOOL_WELDER)
	category = CAT_CRAFTING
	subcategory = CAT_FORGING

/datum/crafting_recipe/blacksmith/anvil
	name = "Anvil"
	result = /obj/structure/blacksmith/anvil/obtainable
	time = 450
	reqs = list(
		/obj/item/stack/sheet/metal = 50,
		/obj/item/stack/sheet/mineral/titanium = 15,
		)
	tools = list(TOOL_SCREWDRIVER, TOOL_WRENCH, TOOL_WELDER, TOOL_CROWBAR)
	category = CAT_CRAFTING
	subcategory = CAT_FORGING

/datum/crafting_recipe/blacksmith/sandvil
	name = "Sandstone Anvil"
	result = /obj/structure/blacksmith/anvil/obtainable/sandstone
	time = 300
	reqs = list(/obj/item/stack/sheet/mineral/sandstone = 50)
	tools = list(TOOL_CROWBAR)
	category = CAT_CRAFTING
	subcategory = CAT_FORGING

/datum/crafting_recipe/blacksmith/furnace
	name = "Furnace"
	result = /obj/structure/blacksmith/furnace
	time = 300
	reqs = list(
		/obj/item/stack/sheet/mineral/sandstone = 30,
		/obj/item/stack/sheet/metal = 6,
		)
	tools = list(TOOL_CROWBAR)
	category = CAT_CRAFTING
	subcategory = CAT_FORGING

/datum/crafting_recipe/blacksmith/quenching_trough
	name = "Quenching trough"
	result = /obj/structure/blacksmith/quenching
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 20,
		/datum/reagent/water = 300,
		)
	time = 100
	category = CAT_CRAFTING
	subcategory = CAT_FORGING

/datum/crafting_recipe/barrelfire // needs to be a ore smelter thing
	name = "Stoke barrel fire"
	result = /obj/structure/campfire/barrel
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 15,
		/obj/item/stack/sheet/metal = 10,
		)
	time = 80
	category = CAT_CRAFTING
	subcategory = CAT_FORGING

/datum/crafting_recipe/tools/forged/sledge // metalworking bench
	name = "Sledgehammer"
	result = /obj/item/twohanded/sledgehammer/simple
	time = 700
	reqs = list(
		/obj/item/stack/sheet/metal = 15,
		/obj/item/stack/sheet/mineral/wood = 5,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_CRAFTING
	subcategory = CAT_FORGING


//KNIVES//

/datum/crafting_recipe/melee/forged/cleaver
	name = "Butchers Cleaver"
	result = /obj/item/kitchen/knife/butcher
	time = 100
	reqs = list(
		/obj/item/stack/sheet/metal = 3,
		/obj/item/stack/sheet/mineral/wood = 1,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/melee/forged/huntingknife
	name = "Hunting Knife"
	result = /obj/item/melee/onehanded/knife/hunting
	time = 150
	reqs = list(
		/obj/item/stack/sheet/metal = 3,
		/obj/item/blacksmith/swordhandle = 1,
		/obj/item/stack/sheet/cloth = 1,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/melee/forged/throwing
	name = "Throwing Knife"
	result = /obj/item/melee/onehanded/knife/throwing
	time = 90
	reqs = list(
		/obj/item/stack/sheet/prewar = 3,
		/obj/item/stack/sheet/leather = 1,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE


/datum/crafting_recipe/melee/forged/bayonet
	name = "Bayonet Knife"
	result = /obj/item/melee/onehanded/knife/bayonet
	time = 300
	reqs = list(
		/obj/item/stack/sheet/metal = 6,
		/obj/item/blacksmith/swordhandle = 1,
		)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/melee/forged/kitchen
	name = "Kitchen Knife"
	result = /obj/item/kitchen/knife
	time = 30
	reqs = list(
		/obj/item/stack/sheet/metal = 2,
		/obj/item/stack/sheet/mineral/wood = 1,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/melee/forged/survival
	name = "Survival Knife"
	result = /obj/item/melee/onehanded/knife/survival
	time = 100
	reqs = list(
		/obj/item/stack/sheet/metal = 5,
		/obj/item/blacksmith/swordhandle = 1,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/melee/forged/switchblade
	name = "Switchblade"
	result = /obj/item/melee/onehanded/knife/switchblade
	time = 40
	reqs = list(
		/obj/item/stack/sheet/metal = 2,
		/obj/item/stack/crafting/metalparts = 1,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/melee/forged/trench_knife
	name = "Trench Knife"
	result = /obj/item/melee/onehanded/knife/trench
	reqs = list(
		/obj/item/stack/sheet/metal = 5,
		/obj/item/stack/crafting/goodparts = 2,
		/obj/item/blacksmith/swordhandle = 1,
		)
	time = 280
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

//swords
/datum/crafting_recipe/melee/forged/bmprsword
	name = "Bumper Sword"
	result = /obj/item/twohanded/fireaxe/bmprsword
	reqs = list(
		/obj/item/stack/sheet/metal = 25,
		/obj/item/stack/sheet/cloth = 2,
		)
	time = 400
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/scrapsabre
	name = "Scrap sabre"
	result = /obj/item/melee/onehanded/machete/scrapsabre
	reqs = list(
		/obj/item/stack/sheet/metal = 18,
		/obj/item/stack/sheet/leather = 2,
		/obj/item/stack/sheet/plasteel = 2,
	    )
	time = 380
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE


// LEGION
/datum/crafting_recipe/legionshield
	name = "Legion Shield"
	result = /obj/item/shield/riot/legion
	reqs = list(
		/obj/item/stack/sheet/metal = 8,
		/obj/item/stack/sheet/mineral/wood = 8,
		/obj/item/stack/sheet/leather = 2,
		)
	time = 250
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE
	always_available = FALSE


//polearms

/datum/crafting_recipe/melee/forged/spear
	name = "Spear"
	result = /obj/item/twohanded/spear
	time = 200
	reqs = list(
		/obj/item/stack/sheet/metal = 16,
		/obj/item/stack/sheet/mineral/wood = 4,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/forgethrowingspear
	name = "Throwing Spear"
	result = /obj/item/throwing_star/spear
	time = 120
	reqs = list(
		/obj/item/stack/sheet/metal = 2,
		/obj/item/stack/sheet/mineral/wood = 3,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

//fists

/datum/crafting_recipe/melee/forged/knucklespike
	name = "Spiked Knuckledusters"
	result = /obj/item/melee/unarmed/brass/spiked
	time = 140
	reqs = list(/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/melee/forged/sap
	name = "Sappers"
	result = /obj/item/melee/unarmed/sappers
	time = 180
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
		/obj/item/stack/sheet/lead = 2,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/melee/forged/maceglove
	name = "Mace Glove"
	result = /obj/item/melee/unarmed/maceglove
	time = 240
	reqs = list(/obj/item/stack/sheet/metal = 20)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE


///////////
// TOOLS //
///////////

/datum/crafting_recipe/crusher
	name = "Kinetic Crusher"
	result = /obj/item/kinetic_crusher
	time = 300
	reqs = list(
		/obj/item/stack/sheet/metal = 25,
		/obj/item/stack/crafting/metalparts = 2,
		/obj/item/stack/crafting/electronicparts = 3
		)
	tools = list(TOOL_WORKBENCH, TOOL_WELDER)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/glaive
	name = "Kinetic Glaive"
	result = /obj/item/kinetic_crusher/glaive
	time = 100
	reqs = list(
		/obj/item/kinetic_crusher = 1,
		/obj/item/stack/sheet/mineral/titanium = 1,
		/obj/item/stack/crafting/electronicparts = 5
		)
	tools = list(TOOL_WORKBENCH, TOOL_MULTITOOL)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE


/datum/crafting_recipe/tools/forged/fryingpan
	name = "Frying Pan"
	result = /obj/item/melee/onehanded/club/fryingpan
	time = 80
	reqs = list(
		/obj/item/stack/sheet/metal = 5,
		/obj/item/stack/sheet/mineral/wood = 1,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/tools/forged/pick_axe
	name = "Pickaxe"
	result = /obj/item/pickaxe
	time = 150
	reqs = list(
		/obj/item/stack/sheet/metal = 5,
		/obj/item/stack/sheet/mineral/wood = 1,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/tools/forged/shovel
	name = "Shovel"
	result = /obj/item/shovel
	time = 150
	reqs = list(
		/obj/item/stack/sheet/metal = 2,
		/obj/item/stack/sheet/mineral/wood = 3,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/tools/forged/hatchet
	name = "Hatchet"
	result = /obj/item/hatchet
	time = 80
	reqs = list(
		/obj/item/stack/sheet/metal = 5,
		/obj/item/stack/sheet/mineral/wood = 2,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/tools/forged/entrenching_tool
	name = "Pattern 2281 Entrenching Tool"
	result = /obj/item/shovel/trench
	time = 150
	reqs = list(
		/obj/item/stack/sheet/metal = 5,
		/obj/item/stack/sheet/cloth = 1,
		/obj/item/stack/sheet/mineral/wood = 1,
		)
	tools = list(TOOL_METAL_BENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE
	always_available = FALSE
