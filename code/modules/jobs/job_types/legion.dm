/*
Legion Design notes:
"Standard issue", AVOID identical kits and guns. Legion got spotty logistics and the hodgepodge aesthetic suits them, don't ruin it.
Sunglasses	For vets mainly, most lower ranks should have sandstorm goggles.
Money		Cent & Treasurer - "small" money bag (the biggest)
			Decanus - Officer money bag
			Rest - Enlisted money bag
Sidearm		None.
Melee		Officers only - Spatha
			Vets/Officers - Gladius
			Rest - Lawnmower machete the most common
Weapons		Lever shotgun, Grease gun, Repeater carbines, Revolvers, simple guns all good, very restrictive on long barrel automatics, generally limited ammo, always good melee option.
			Avoid Police shotguns, 5,56 semis, Desert Eagle, Survival knives etc, be creative and work within the limitations to avoid powercreep and things getting bland and same.
*/

/datum/job/CaesarsLegion
	department_flag = LEGION
	selection_color = "#fdb8b8"
	faction = FACTION_LEGION

	forbids = "The Legion forbids: Using drugs such as stimpacks and alcohol. Ghouls joining. Women fighting (self defense and suicide allowed). Slaves carrying weapons. Using robots and advanced machines. Killing Legion members in secret, only if according to law and in public is it acceptable."
	enforces = "The Legion demands: Obeying orders of superiors. A roman style name. Wearing the uniform, unless acting as a NON-COMBAT infiltrator. Expect death as punishment for failing to obey."
	objectivesList = list("Focus on the tribals, win them over or intimidate them.", "Focus on Town of Eastwood, display dominance.", "Send out patrols and establish checkpoints to curb use of digusting drugs and degenerate behaviour.", "Flagstaff requests more worker: acquire slaves, train them if possible, send them east for breaking if not.", "Make sure no other faction gains dominance over Town of Eastwood, if they remain neutral it can be used to the Legions advantage.")

	exp_type = EXP_TYPE_LEGION

	access = list(ACCESS_LEGION)
	minimal_access = list(ACCESS_LEGION)

/datum/outfit/job/CaesarsLegion
	ears = null
	box = null

/datum/outfit/job/CaesarsLegion/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legiongate)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/rip/crossexecution)

/datum/outfit/job/CaesarsLegion/Legionnaire
	belt = /obj/item/storage/belt/military/legion
	ears = /obj/item/radio/headset/headset_legion
	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	uniform = /obj/item/clothing/under/f13/legskirt
	shoes = /obj/item/clothing/shoes/f13/military/legion
	gloves = /obj/item/clothing/gloves/legion
	box = /obj/item/storage/survivalkit/tribal
	box_two = /obj/item/storage/survivalkit/medical/tribal

/datum/outfit/job/CaesarsLegion/Legionnaire/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	if(H.gender == FEMALE)
		H.gender = MALE
		H.real_name = random_unique_name(MALE)
		H.name = H.real_name
		if(H.wear_id)
			var/obj/item/card/id/dogtag/L = H.wear_id
			L.registered_name = H.name
			L.update_label()

/datum/outfit/job/CaesarsLegion/Legionnaire/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TRIBAL, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_FEARLESS, src) //no phobias for legion!
	ADD_TRAIT(H, TRAIT_BERSERKER, src)

/obj/item/storage/box/legate
	name = "legate belongings"
	icon_state = "secbox"
	illustration = "flashbang"

/obj/item/storage/box/legate/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/pill/patch/healpoultice(src)
	new /obj/item/reagent_containers/pill/patch/healpoultice(src)
	new /obj/item/ammo_box/magazine/pistol14mm(src)
	new /obj/item/ammo_box/magazine/pistol14mm(src)
	new /obj/item/ammo_box/magazine/pistol14mm(src)


///////////////////
/// Admin Roles ///
///////////////////

// LEGATE

/datum/job/CaesarsLegion/Legionnaire/f13legate
	title = "Legion Legate"
	flag = F13LEGATE
	head_announce = list("Security")
	supervisors = "Caesar"
	selection_color = "#ff8f8f"
	req_admin_notify = 1
	total_positions = 0
	spawn_positions = 0
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13legate
	access = list(ACCESS_LEGION, ACCESS_CHANGE_IDS)
	minimal_access = list(ACCESS_LEGION, ACCESS_CHANGE_IDS)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13legate/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	if(H.mind)
		var/obj/effect/proc_holder/spell/terrifying_presence/S = new /obj/effect/proc_holder/spell/terrifying_presence
		H.mind.AddSpell(S)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13legate	// 14mm Pistol, Goliath
	name = "Legate"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13legate
	shoes =	/obj/item/clothing/shoes/f13/military/legate
	suit = /obj/item/clothing/suit/armor/heavy/legion/legate
	head = /obj/item/clothing/head/helmet/f13/legion/legate
	gloves = /obj/item/clothing/gloves/legion/legate
	glasses = /obj/item/clothing/glasses/sunglasses/big
	suit_store = /obj/item/gun/ballistic/automatic/pistol/pistol14
	r_pocket = /obj/item/storage/bag/money/small/legion
	l_pocket = /obj/item/flashlight/lantern
	r_hand = /obj/item/melee/powerfist/f13/goliath
	l_hand = /obj/item/tank/internals/oxygen
	backpack = null
	satchel = null
	ears = /obj/item/radio/headset/headset_legion/cent
	box = /obj/item/storage/box/legate


// ORATOR

/datum/job/CaesarsLegion/Legionnaire/f13orator
	title = "Legion Orator"
	flag = F13ORATOR
	supervisors = "Centurion"
	total_positions = 1
	spawn_positions = 1
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13orator
	display_order = JOB_DISPLAY_ORDER_ORATOR
	access = list(ACCESS_LEGION, ACCESS_CHANGE_IDS, ACCESS_LEGION_COMMAND)
	minimal_access = list(ACCESS_LEGION, ACCESS_CHANGE_IDS, ACCESS_LEGION_COMMAND)
	exp_requirements = 750


/datum/outfit/job/CaesarsLegion/Legionnaire/f13orator	// .357 Revolver, Spatha
	name = "Orator"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13orator
	neck = /obj/item/storage/belt/holster
	shoes = /obj/item/clothing/shoes/f13/military/plated
	suit = /obj/item/clothing/suit/armor/medium/legion/orator
	id = /obj/item/card/id/dogtag/legorator
	gloves = null
	backpack = /obj/item/storage/backpack/legionr
	suit_store = /obj/item/gun/ballistic/revolver/colt357
	r_pocket = /obj/item/storage/bag/money/small/legofficers
	l_pocket = /obj/item/flashlight/lantern
	l_hand = /obj/item/melee/onehanded/machete/spatha
	backpack_contents = list(
		/obj/item/binoculars = 1,
		/obj/item/ammo_box/loader/a357 = 2,
		/obj/item/reagent_containers/pill/bitterdrink = 2,
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13orator/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)

/////////////////
//// Officers ///
/////////////////

// CENTURION

/datum/job/CaesarsLegion/Legionnaire/f13centurion
	title = "Legion Centurion"
	flag = F13CENTURION
	head_announce = list("Security")
	total_positions = 1
	spawn_positions = 1
	description = "You are the camp commander and strongest soldier. Use your officers, the Decanii, to delegate tasks, make sure you lead and give orders. Take no disrespect, you are the dominus. If you prove a fool or weak, expect to be dispatched by a stronger subordinate."
	supervisors = "the Legate"
	selection_color = "#ff8f8f"
	req_admin_notify = 1
	display_order = JOB_DISPLAY_ORDER_CENTURION
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13centurion
	exp_requirements = 750

	access = list(ACCESS_LEGION, ACCESS_CHANGE_IDS, ACCESS_LEGION_COMMAND)
	minimal_access = list(ACCESS_LEGION, ACCESS_CHANGE_IDS, ACCESS_LEGION_COMMAND)

	loadout_options = list(
		/datum/outfit/loadout/palacent,		// 10mm SMG, Goliath, CQC
		/datum/outfit/loadout/rangerhunter,	// Hunting Revolver, DKS, Spatha
		/datum/outfit/loadout/centurion,	// M1919, Hunting Revolver
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13centurion/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	if(H.mind)
		var/obj/effect/proc_holder/spell/terrifying_presence/S = new /obj/effect/proc_holder/spell/terrifying_presence
		H.mind.AddSpell(S)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13centurion
	name = "Legion Centurion"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13centurion
	id = /obj/item/card/id/dogtag/legcenturion
	mask = /obj/item/clothing/mask/bandana/legion/legcenturion
	ears = /obj/item/radio/headset/headset_legion/cent
	neck = /obj/item/storage/belt/holster
	gloves = /obj/item/clothing/gloves/legion/plated
	glasses = /obj/item/clothing/glasses/night/polarizing
	shoes = /obj/item/clothing/shoes/f13/military/plated
	r_pocket = /obj/item/restraints/handcuffs
	l_pocket = /obj/item/flashlight/lantern
	box = /obj/item/storage/survivalkit/tribal/chief
	box_two = /obj/item/storage/survivalkit/medical/tribal
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola = 1,
		/obj/item/storage/bag/money/small/legion = 1,
		/obj/item/warpaint_bowl = 1,
		/obj/item/ammo_box/loader/a357 = 1,
		/obj/item/gun/ballistic/revolver/colt357 = 1,
		/obj/item/binoculars = 1,
		)

/datum/outfit/loadout/palacent
	name = "Paladin-Slayer Centurion"
	suit = /obj/item/clothing/suit/armor/heavy/legion/palacent
	head = /obj/item/clothing/head/helmet/f13/legion/palacent
	suit_store = /obj/item/gun/ballistic/automatic/bar
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m762 = 3,
		/obj/item/melee/powerfist/f13/goliath = 1,
		/obj/item/gun/ballistic/automatic/pistol/n99/crusader = 1,
		/obj/item/ammo_box/magazine/pistol10mm = 2,
		)

/datum/outfit/loadout/rangerhunter
	name = "Ranger-Hunter Centurion"
	suit = /obj/item/clothing/suit/armor/medium/legion/rangercent
	head = /obj/item/clothing/head/helmet/f13/legion/rangercent
	suit_store = /obj/item/gun/ballistic/automatic/marksman/sniper
	backpack_contents = list(
		/obj/item/ammo_box/magazine/w308 = 2,
		/obj/item/ammo_box/loader/c4570 = 3,
		/obj/item/gun/ballistic/revolver/hunting = 1,
		/obj/item/melee/onehanded/machete/spatha = 1,
		)

/datum/outfit/loadout/centurion
	name = "Warlord Centurion"
	suit = /obj/item/clothing/suit/armor/medium/legion/centurion
	head = /obj/item/clothing/head/helmet/f13/legion/centurion
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat/citykiller
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/pistol14 = 1,
		/obj/item/ammo_box/magazine/pistol14mm = 2,
		/obj/item/ammo_box/magazine/d12g = 2,
		)

// VETERAN DECANUS

/datum/job/CaesarsLegion/Legionnaire/f13decanvet
	title = "Legion Veteran Decanus"
	flag = F13DECANVET
	total_positions = 1
	spawn_positions = 1
	description = "You answer directly to the Centurion, his second in command. Lead the camp, ensure its defended, keep track of the Explorers and use your veterans to their full potential."
	supervisors = "the Centurion"
	display_order = JOB_DISPLAY_ORDER_DECANVET
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13decanvet
	exp_requirements = 450

	access = list(ACCESS_LEGION, ACCESS_CHANGE_IDS, ACCESS_LEGION_COMMAND)
	minimal_access = list(ACCESS_LEGION, ACCESS_CHANGE_IDS, ACCESS_LEGION_COMMAND)

	loadout_options = list(
		/datum/outfit/loadout/decvetbull,	// Supersledge, 10mm SMG, Smokebomb
		/datum/outfit/loadout/decvetwolf,	// Thermic lance, .45 revoler, Extra Bitter
		/datum/outfit/loadout/decvetsnake, // Brush gun, Ripper, Extra Bitters
		/datum/outfit/loadout/decvetbrave, // trench shotgun, 44 revolver, ballistic fist
		)


/datum/outfit/job/CaesarsLegion/Legionnaire/f13decanvet/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decanvet
	name = "Legion Veteran Decanus"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13decanvet
	id = /obj/item/card/id/dogtag/legveteran
	head = /obj/item/clothing/head/helmet/f13/legion/vet/decan
	suit = /obj/item/clothing/suit/armor/medium/legion/vet
	mask = /obj/item/clothing/mask/bandana/legion/legdecan
	neck = /obj/item/storage/belt/holster
	gloves = /obj/item/clothing/gloves/legion/plated
	ears = /obj/item/radio/headset/headset_legion/cent
	glasses = /obj/item/clothing/glasses/sunglasses/big
	shoes = /obj/item/clothing/shoes/f13/military/plated
	r_pocket = /obj/item/flashlight/lantern
	box = /obj/item/storage/survivalkit/tribal/chief
	box_two = /obj/item/storage/survivalkit/medical/tribal
	backpack_contents = list(
		/obj/item/ammo_box/loader/a357 = 1,
		/obj/item/gun/ballistic/revolver/colt357 = 1,
		/obj/item/restraints/handcuffs = 1,
		/obj/item/storage/bag/money/small/legofficers = 1,
		/obj/item/binoculars = 1,
		)

/datum/outfit/loadout/decvetbull
	name = "Mark of The Bull"
	suit_store = /obj/item/twohanded/sledgehammer/supersledge
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/smg/smg10mm = 1,
		/obj/item/ammo_box/magazine/pistol10mm/extended = 2,
		/obj/item/grenade/smokebomb = 1,
		)

/datum/outfit/loadout/decvetwolf
	name = "Mark of the Wolf"
	suit_store = /obj/item/twohanded/thermic_lance
	backpack_contents = list(
		/obj/item/melee/onehanded/machete/spatha = 1,
		/obj/item/gun/ballistic/revolver/revolver45 = 1,
		/obj/item/reagent_containers/pill/bitterdrink = 2,
		)

/datum/outfit/loadout/decvetsnake
	name = "Mark of the Snake"
	suit_store = /obj/item/gun/ballistic/rifle/repeater/brush
	backpack_contents = list(
		/obj/item/melee/powered/ripper = 1,
		/obj/item/ammo_box/tube/c4570 = 3,
		/obj/item/gun_upgrade/scope/watchman = 1,
		/obj/item/reagent_containers/pill/bitterdrink = 2
		)

/datum/outfit/loadout/decvetbrave
	name = "Mark of the Brave"
	suit_store = /obj/item/gun/ballistic/shotgun/trench
	backpack_contents = list(
		/obj/item/gun/ballistic/revolver/ballisticfist = 1,
		/obj/item/ammo_box/shotgun/buck = 2,
		/obj/item/gun/ballistic/revolver/m29 = 1,
		)


// PRIME DECANUS

/datum/job/CaesarsLegion/Legionnaire/f13decan
	title = "Legion Prime Decanus"
	flag = F13DECAN
	total_positions = 1
	spawn_positions = 1
	description = "A experienced officer, often commanding the camp. Give orders, lead patrols."
	supervisors = "the Veteran Decanus and the Centurion"
	display_order = JOB_DISPLAY_ORDER_DECAN
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13decan
	access = list(ACCESS_LEGION, ACCESS_LEGION_COMMAND)
	minimal_access = list(ACCESS_LEGION,  ACCESS_LEGION_COMMAND)
	exp_requirements = 360

	loadout_options = list(	//ALL: Gladius, Smokebomb
		/datum/outfit/loadout/decprimfront,	// Lever action, .357 Revolver, Legion lance, Throwing knives
		/datum/outfit/loadout/decprimrear,	// Legion shield, Ballistic fist
		/datum/outfit/loadout/decprimboom, // Grenade rifle, .44 Revolver, Frag grenades, Coffepot bomb
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/CaesarsLegion,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/CaesarsLegion,
		),
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decan/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decan
	name = "Prime Decanus"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13decan
	id = /obj/item/card/id/dogtag/legveteran
	suit = /obj/item/clothing/suit/armor/light/legion/prime
	head = /obj/item/clothing/head/helmet/f13/legion/prime/decan
	mask = /obj/item/clothing/mask/bandana/legion/legdecan
	neck = /obj/item/storage/belt/holster
	glasses = /obj/item/clothing/glasses/legiongoggles
	shoes = /obj/item/clothing/shoes/f13/military/plated
	r_pocket = /obj/item/flashlight/lantern
	l_pocket = /obj/item/restraints/handcuffs
	box = /obj/item/storage/survivalkit/tribal/chief
	box_two = /obj/item/storage/survivalkit/medical/tribal
	backpack_contents = list(
		/obj/item/melee/onehanded/machete/gladius = 1,
		/obj/item/storage/bag/money/small/legofficers = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/binoculars = 1,
		/obj/item/reagent_containers/pill/bitterdrink = 1,
		)

/datum/outfit/loadout/decprimfront
	name = "Aspiring Prime Decanus"
	suit_store = /obj/item/twohanded/spear/lance
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/buck = 2,
		/obj/item/gun/ballistic/revolver/m29 = 1,
		/obj/item/ammo_box/loader/m44 = 3,
		/obj/item/restraints/legcuffs/bola = 1,
		/obj/item/melee/onehanded/knife/throwing = 2,
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever = 1
		)

/datum/outfit/loadout/decprimrear
	name = "Battleborn Prime Decanus"
	backpack_contents = list(
		/obj/item/shield/riot/legion = 1,
		/obj/item/gun/ballistic/revolver/ballisticfist = 1,
		/obj/item/ammo_box/shotgun/buck = 2,
		/obj/item/restraints/legcuffs/bola = 1,
		)

/datum/outfit/loadout/decprimboom
	name = "Loud Prime Decanus"
	suit_store = /obj/item/gun/ballistic/revolver/grenadelauncher
	backpack_contents = list(
		/obj/item/ammo_box/a40mm = 2,
		/obj/item/gun/ballistic/revolver/m29 = 1,
		/obj/item/ammo_box/loader/m44 = 3,
		/obj/item/grenade/f13/frag = 2,
		/obj/item/grenade/homemade/coffeepotbomb = 1,
		)


// RECRUIT DECANUS

/datum/job/CaesarsLegion/Legionnaire/f13decanrec
	title = "Legion Recruit Decanus"
	flag = F13DECANREC
	total_positions = 1
	spawn_positions = 1
	description = "The junior officer, you must train the recruits and test them, and if a suicide charge is needed, lead them to a glorious death."
	supervisors = "the Prime/Veteran Decanus and the Centurion"
	display_order = JOB_DISPLAY_ORDER_DECANREC
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13decanrec
	access = list(ACCESS_LEGION, ACCESS_LEGION_COMMAND)
	minimal_access = list(ACCESS_LEGION,  ACCESS_LEGION_COMMAND)
	exp_requirements = 300

	loadout_options = list(
		/datum/outfit/loadout/recdeclegion,	// Uzi, Bumper sword, Smokebomb
		/datum/outfit/loadout/recdectribal,	// M1 Garand, Throwing spears, Reinforced machete, Bottlecap mine
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/CaesarsLegion,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/CaesarsLegion,
		),
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decanrec/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decanrec
	name = "Legion Recruit Decanus"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13decanrec
	id = /obj/item/card/id/dogtag/legveteran
	suit = /obj/item/clothing/suit/armor/light/legion/recruit //That's not how legion ranks work Recruit = Recruit not Prime
	head = /obj/item/clothing/head/helmet/f13/legion/recruit/decan
	mask = /obj/item/clothing/mask/bandana/legion/legdecan
	neck = /obj/item/storage/belt/holster
	glasses = /obj/item/clothing/glasses/legiongoggles
	r_pocket = /obj/item/flashlight/lantern
	box = /obj/item/storage/survivalkit/tribal/chief
	box_two = /obj/item/storage/survivalkit/medical/tribal
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/healpoultice = 1,
		/obj/item/restraints/handcuffs = 1,
		/obj/item/storage/bag/money/small/legofficers = 1,
		)

/datum/outfit/loadout/recdeclegion
	name = "Frontier Decanus"
	suit_store = /obj/item/twohanded/fireaxe/bmprsword
	backpack_contents = list(
		/obj/item/grenade/smokebomb = 1,
		/obj/item/restraints/legcuffs/bola = 1,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi = 1,
		/obj/item/ammo_box/magazine/uzim9mm = 3
		)

/datum/outfit/loadout/recdectribal
	name = "Blackliner Decanus"
	suit_store = /obj/item/gun/ballistic/automatic/m1garand
	backpack_contents = list(
		/obj/item/ammo_box/magazine/garand308 = 2,
		/obj/item/melee/onehanded/machete/forgedmachete = 1,
		/obj/item/storage/backpack/spearquiver = 1,
		/obj/item/bottlecap_mine = 1,
		/obj/item/warpaint_bowl = 1
		)



////////////////////
///Specialist///////
////////////////////

// VEXILLARIUS

/datum/job/CaesarsLegion/Legionnaire/f13vexillarius
	title = "Legion Vexillarius"
	flag = F13VEXILLARIUS
	total_positions = 1
	spawn_positions = 1
	description = "You are a Veteran of proven bravery. When not fighting, relay orders from the commander and act as a bodyguard."
	supervisors = "the Veteran Decanus and Centurion"
	display_order = JOB_DISPLAY_ORDER_VEXILLARIUS
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13vexillarius
	access = list(ACCESS_LEGION, ACCESS_LEGION_COMMAND)
	minimal_access = list(ACCESS_LEGION,  ACCESS_LEGION_COMMAND)
	exp_requirements = 360

	loadout_options = list(
		/datum/outfit/loadout/vexbear,	//	Classic FO13 Vex with his ripper: .223 pistol, Ripper
		/datum/outfit/loadout/vexfox,	//	Classic New Vegas Vex with his 10mm SMG: 14mm SMG, Spartha
		/datum/outfit/loadout/vexnight, //  Classic and Iconic long range vex with a trail carbine
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/CaesarsLegion,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/CaesarsLegion,
		),
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13vexillarius/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13vexillarius
	name = "Vexillarius"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13vexillarius
	id = /obj/item/card/id/dogtag/legveteran
	suit = /obj/item/clothing/suit/armor/medium/legion/vexil
	mask = /obj/item/clothing/mask/bandana/legion/legvet
	neck = /obj/item/storage/belt/holster
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/legion/plated
	r_pocket = /obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/healpoultice = 1,
		/obj/item/restraints/handcuffs = 1,
		/obj/item/megaphone/cornu = 1,
		/obj/item/storage/bag/money/small/legenlisted = 1,
		/obj/item/warpaint_bowl = 1,
		)

/datum/outfit/loadout/vexbear
	name = "Mountain Bear"
	head = /obj/item/clothing/head/helmet/f13/legion/vet/combvexil
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever
	backpack_contents = list(
		/obj/item/melee/unarmed/tigerclaw = 1,
		/obj/item/melee/powered/ripper = 1,
		/obj/item/book/granter/martial/berserker = 1,
		)

/datum/outfit/loadout/vexfox
	name = "Desert Fox"
	head = /obj/item/clothing/head/helmet/f13/legion/vet/vexil
	suit_store = /obj/item/gun/ballistic/automatic/smg/smg14
	backpack_contents = list(
		/obj/item/ammo_box/magazine/smg14 = 2,
		/obj/item/melee/onehanded/machete/spatha = 1,
		)

/datum/outfit/loadout/vexnight
	name = "Night Stalker"
	head = /obj/item/clothing/head/helmet/f13/legion/vet/nightvexil
	suit_store = /obj/item/gun/ballistic/rifle/repeater/trail
	backpack_contents = list(
		/obj/item/ammo_box/tube/m44 = 2,
		/obj/item/melee/onehanded/machete/gladius = 1,
		/obj/item/book/granter/trait/rifleman = 1,
		)

//Speculator

/datum/job/CaesarsLegion/Legionnaire/f13venator
	title = "Legion Speculator"
	flag = F13VENATOR
	total_positions = 1
	spawn_positions = 1
	description = "You are a member of the Legion Speculatores. With your powerful rifle and your many years of experience, you are a killing machine, capable of taking down even the most formidable targets. Note that you are not a rank-and-file legionary, and you should not be operating as such -- your job is special operations, not fighting alongside the hordes of the Legion."
	supervisors = "the Decani and Centurion"
	display_order = JOB_DISPLAY_ORDER_ASSASSIN
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13venator
	exp_requirements = 750

/datum/outfit/job/CaesarsLegion/Legionnaire/f13venator/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_SILENT_STEP, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13venator
	name = "Legion Speculator"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13explorer
	id = /obj/item/card/id/dogtag/legvenator
	head = /obj/item/clothing/head/helmet/f13/legion/assassin
	suit = /obj/item/clothing/suit/armor/medium/legion/vet
	shoes = /obj/item/clothing/shoes/f13/military/plated
	neck = /obj/item/storage/belt/holster
	glasses = /obj/item/clothing/glasses/night/polarizing
	gloves = /obj/item/clothing/gloves/legion/plated
	ears = /obj/item/radio/headset/headset_legion
	r_pocket = /obj/item/binoculars
	suit_store = /obj/item/gun/ballistic/automatic/marksman/sniper/snipervenator
	backpack_contents = list(
		/obj/item/ammo_box/magazine/w308 = 3,
		/obj/item/melee/onehanded/machete/gladius = 1,
		/obj/item/reagent_containers/pill/patch/healpoultice = 3,
		/obj/item/gun/ballistic/revolver/revolver45 = 1,
		/obj/item/ammo_box/loader/acp45 = 3,
		)

//EXPLORER

/datum/job/CaesarsLegion/Legionnaire/f13explorer
	title = "Legion Explorer"
	flag = F13EXPLORER
	total_positions = 3
	spawn_positions = 3
	description = "Scout the area, secure key points, but do not ignore orders or wordlessly die some place. A good explorer helps his unit by taking initiative and helping the commander without needing micro-managment."
	supervisors = "the Decani and the Centurion. Note that you aren't underling of assassins and neither are you equal to veterans."
	display_order = JOB_DISPLAY_ORDER_EXPLORER
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13explorer
	exp_requirements = 150

	loadout_options = list(	// ALL: .45 Revolver, Machete
		/datum/outfit/loadout/expambusher,	// lever-action shotgun, Bottlecap mine, MP5
		/datum/outfit/loadout/expsniper,	// Commando Carbine, Smokebomb, C4
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/CaesarsLegion,
			),
		/datum/matchmaking_pref/rival = list(
			/datum/job/CaesarsLegion,
			),
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13explorer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_SILENT_STEP, src)



/datum/outfit/job/CaesarsLegion/Legionnaire/f13explorer
	name = "Legion Explorer"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13explorer
	id = /obj/item/card/id/dogtag/legprime
	suit = /obj/item/clothing/suit/armor/light/legion/explorer
	head = /obj/item/clothing/head/helmet/f13/legion/explorer
	neck = /obj/item/storage/belt/holster
	r_pocket = /obj/item/flashlight
	l_pocket = /obj/item/binoculars
	backpack_contents = list(
		/obj/item/gun/ballistic/revolver/revolver45 = 1,
		/obj/item/ammo_box/loader/acp45 = 1,
		/obj/item/reagent_containers/pill/healingpowder = 1,
		/obj/item/storage/bag/money/small/legenlisted = 1,
		/obj/item/melee/onehanded/machete = 1,
		/obj/item/restraints/handcuffs = 1,
		)

/datum/outfit/loadout/expambusher
	name = "Ambusher"
	suit_store = /obj/item/gun/ballistic/automatic/smg/mp5
	glasses = /obj/item/clothing/glasses/sunglasses/big
	backpack_contents = list(
		/obj/item/ammo_box/magazine/uzim9mm = 2,
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever = 1,
		/obj/item/bottlecap_mine = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/restraints/legcuffs/bola/tactical = 1,
		)

/datum/outfit/loadout/expsniper
	name = "Sniper"
	glasses = /obj/item/clothing/glasses/sunglasses/big
	suit_store = /obj/item/gun/ballistic/automatic/delisle/commando
	backpack_contents = list(
		/obj/item/ammo_box/magazine/pistol45/socom = 3,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/gun_upgrade/scope/watchman = 1,
		/obj/item/grenade/plastic/c4 = 1
		)

///////////////////
////Legionnaires///
///////////////////

// VETERAN

/datum/job/CaesarsLegion/Legionnaire/vetlegionnaire
	title = "Veteran Legionnaire"
	flag = F13VETLEGIONARY
	total_positions = 3
	spawn_positions = 3
	description = "A hardened warrior, obeying the orders from the Decanus and Centurion is second nature, as is fighting the profligates. If no officers are present, make sure the younger warriors act like proper Legionaires."
	supervisors = "the Decani and Centurion"
	display_order = JOB_DISPLAY_ORDER_VETLEGIONARY
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/vetlegionnaire
	exp_requirements = 300

	loadout_options = list(	//ALL: Gladius
		/datum/outfit/loadout/vetaxe,	// AXE AND FISTS AND NOTHING FUCKING ELSE
		/datum/outfit/loadout/vetsmg, 		// 10mm SMG, .357 Revolver
		/datum/outfit/loadout/vetberserker,	// Lever shotgun, Bola, Legion Lance
		/datum/outfit/loadout/vetrifle,		// Trail gun, .357 Revolver
		)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/CaesarsLegion,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/CaesarsLegion,
		),
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/vetlegionnaire/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/vetlegionnaire
	name = "Veteran Legionnaire"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/vetlegionnaire
	id = /obj/item/card/id/dogtag/legveteran
	mask = /obj/item/clothing/mask/bandana/legion/legvet
	head = /obj/item/clothing/head/helmet/f13/legion/vet
	neck = /obj/item/storage/belt/holster
	suit = /obj/item/clothing/suit/armor/medium/legion/vet
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/f13/military/plated
	gloves = /obj/item/clothing/gloves/legion/plated
	r_pocket = /obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/healpoultice = 1,
		/obj/item/storage/bag/money/small/legenlisted = 1,
		/obj/item/restraints/handcuffs = 1,
		/obj/item/melee/onehanded/machete/gladius = 1,
		/obj/item/reagent_containers/pill/bitterdrink = 1,
		)


/datum/outfit/loadout/vetaxe
	name = "Enforcer"
	suit_store = /obj/item/twohanded/legionaxe
	backpack_contents = list(
		/obj/item/melee/unarmed/tigerclaw = 1,
		/obj/item/restraints/legcuffs/bola = 1,
		/obj/item/reagent_containers/pill/patch/healpoultice = 2,
		/obj/item/stack/crafting/armor_plate = 4,
		)

/datum/outfit/loadout/vetsmg
	name = "Flanker"
	suit_store = /obj/item/gun/ballistic/automatic/smg/smg10mm
	backpack_contents = list(
		/obj/item/twohanded/spear/lance = 1,
		/obj/item/ammo_box/magazine/pistol10mm/extended = 2,
		/obj/item/gun/ballistic/revolver/colt357 = 1,
		/obj/item/ammo_box/loader/a357 = 1,
		/obj/item/reagent_containers/pill/patch/healpoultice = 2,
		)

/datum/outfit/loadout/vetberserker
	name = "Berserker"
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/slug = 1,
		/obj/item/ammo_box/shotgun/buck = 2,
		/obj/item/twohanded/spear/lance = 1,
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/restraints/legcuffs/bola = 2,
		)

/datum/outfit/loadout/vetrifle
	name = "Sharpshooter"
	suit_store = /obj/item/gun/ballistic/rifle/repeater/trail
	backpack_contents = list(
		/obj/item/ammo_box/tube/m44/ = 3,
		/obj/item/gun/ballistic/revolver/colt357 = 1,
		/obj/item/ammo_box/loader/a357 = 1,
		/obj/item/melee/onehanded/knife/throwing = 2,
		/obj/item/reagent_containers/pill/bitterdrink = 1,
		/obj/item/restraints/legcuffs/beartrap = 1,
		)

// PRIME

/datum/job/CaesarsLegion/Legionnaire/f13legionary
	title = "Prime Legionnaire"
	flag = F13LEGIONARY
	total_positions = 4
	spawn_positions = 4
	description = "A front line soldier who has shown ability to obey and fought in some battles. The Legions muscle, the young men who will build the future with their own blood and sacrifice, for Caesar."
	supervisors = "the Decani and Centurion"
	display_order = JOB_DISPLAY_ORDER_LEGIONARY
	exp_requirements = 60
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13legionary

	loadout_options = list(	//ALL: Forged Machete
		/datum/outfit/loadout/primelancer,	// .357 Revolver, Buckler, Bola.
		/datum/outfit/loadout/primerifle,	// Cowboy Repeater, Firebomb
		/datum/outfit/loadout/primebrave,	// Hunting shotgun, Throwing spears
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/CaesarsLegion,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/CaesarsLegion,
		),
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13legionary/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13legionary
	name = "Prime Legionnaire"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13legionary
	id = /obj/item/card/id/dogtag/legprime
	mask = /obj/item/clothing/mask/bandana/legion/legprime
	head = /obj/item/clothing/head/helmet/f13/legion/prime
	neck = /obj/item/storage/belt/holster
	suit = /obj/item/clothing/suit/armor/light/legion/prime
	glasses = /obj/item/clothing/glasses/legiongoggles
	r_pocket = /obj/item/flashlight/lantern
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/storage/bag/money/small/legenlisted = 1,
		/obj/item/reagent_containers/pill/patch/healpoultice = 1,
		/obj/item/melee/onehanded/machete/forgedmachete = 1,
		)

/datum/outfit/loadout/primelancer
	name = "Guardian"
	suit_store = /obj/item/gun/ballistic/revolver/colt357
	r_hand = /obj/item/shield/riot/legion
	backpack_contents = list(
		/obj/item/ammo_box/loader/a357 = 3,
		/obj/item/restraints/legcuffs/bola = 2,
		/obj/item/reagent_containers/pill/patch/healpoultice = 2,
		)

/datum/outfit/loadout/primerifle
	name = "Gunner"
	suit_store = /obj/item/gun/ballistic/rifle/repeater/cowboy
	backpack_contents = list(
		/obj/item/ammo_box/loader/a357 = 3,
		/obj/item/grenade/homemade/firebomb = 2,
		/obj/item/reagent_containers/pill/patch/healpoultice = 2,
		)

/datum/outfit/loadout/primebrave
	name = "Skirmish"
	suit_store = /obj/item/gun/ballistic/shotgun/hunting
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/buck = 1,
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/storage/backpack/spearquiver = 1,
		/obj/item/reagent_containers/pill/patch/healpoultice = 2,
		)

// RECRUIT

/datum/job/CaesarsLegion/Legionnaire/f13recleg
	title = "Recruit Legionnaire"
	flag = F13RECRUITLEG
	total_positions = 5
	spawn_positions = 5
	description = "You have recently come of age or been inducted into Caesar's Legion. You have absolutely no training, and are expected to follow every whim of the Decanii and your Centurion. Respect the soldiers of higher rank."
	supervisors = "the Decani and Centurion"
	display_order = JOB_DISPLAY_ORDER_RECRUITLEG
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13recleg

	loadout_options = list(	//ALL: Machete
		/datum/outfit/loadout/recruittribal,	// Fire Axe, Bola, Trekking
		/datum/outfit/loadout/recruitlegion,	// .357 Revolver, 2 x prefilled Molotovs
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/CaesarsLegion,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/CaesarsLegion,
		),
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13recleg/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13recleg
	name = "Recruit Legionnaire"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13recleg
	id = /obj/item/card/id/dogtag/legrecruit
	shoes = /obj/item/clothing/shoes/f13/military/leather
	suit = /obj/item/clothing/suit/armor/light/legion/recruit
	head = /obj/item/clothing/head/helmet/f13/legion/recruit
	mask = /obj/item/clothing/mask/bandana/legion/legrecruit
	glasses = /obj/item/clothing/glasses/legiongoggles
	r_pocket = /obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/storage/bag/money/small/legenlisted = 1,
		/obj/item/reagent_containers/pill/healingpowder = 1,
		/obj/item/melee/onehanded/machete = 1,
		)

/datum/outfit/loadout/recruittribal
	name = "Tribal Recruit"
	suit_store = /obj/item/twohanded/fireaxe
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola = 1,
		/obj/item/book/granter/trait/trekking = 1,
		/obj/item/warpaint_bowl = 1,
		)

/datum/outfit/loadout/recruitlegion
	name = "Born in the East"
	suit_store = /obj/item/gun/ballistic/revolver/widowmaker
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/buck = 3,
		/obj/item/reagent_containers/food/drinks/bottle/molotov/filled = 2,
		/obj/item/lighter/greyscale = 1,
		)



//////////////////////
////Support Roles ////
//////////////////////

// Legion Off-Duty - The difference between off-duty and camp follower is that off-duty is NOT expected to do a job.

/datum/job/CaesarsLegion/Legionnaire/f13immune
	title = "Legion Off-Duty"
	flag = F13IMMUNE
	total_positions = 4
	spawn_positions = 4
	description = "A Legionnaire immune from labor services for the week, granted time of recovery for their victories or injuries, or otherwise deligated to medial tasks maintaining the Legion's encampment."
	supervisors = "the Centurion"
	display_order = JOB_DISPLAY_ORDER_IMMUNE
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13immune
	exp_requirements = 150

/datum/outfit/job/CaesarsLegion/Legionnaire/f13immune
	name = "Legion Off-Duty"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13immune
	id = /obj/item/card/id/dogtag/legimmune
	mask = /obj/item/clothing/mask/bandana/legion/camp
	uniform = /obj/item/clothing/under/f13/legskirt
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/f13/military/leather
	l_pocket = /obj/item/flashlight/lantern
	suit_store = /obj/item/melee/onehanded/machete/forgedmachete
	backpack_contents = list(
		/obj/item/storage/bag/money/small/legenlisted = 1,
		/obj/item/reagent_containers/pill/healingpowder = 2
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13immune/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_MARS_TEACH, src)

// Camp Follower - Difference intended between off-duty and Camp Follower is that camp followers may vary in background and are EXPECTED to work as an on-duty role.

/datum/job/CaesarsLegion/Legionnaire/f13campfollower	// Extra materials, Blueprints
	title = "Camp Follower"
	flag = F13CAMPFOLLOWER
	total_positions = 4
	spawn_positions = 4
	description = "A camp follower ranges in defintiion and purposes. Some may be not enslaved men who are simply not fit for service, termorarily or perminantly, or women who serve a purpose above stock to the Legion. Duties may vary from medical specialities, weapon crafting or other skilled-labor tasks."
	supervisors = "the Decani and Centurion"
	display_order = JOB_DISPLAY_ORDER_CAMPFOLLOWER
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13campfollower
	exp_requirements = 150

	loadout_options = list(	//ALL: Machete
		/datum/outfit/loadout/forgemaster,	// Explosives and base Building
		/datum/outfit/loadout/headmedicus,	// Head Surgeon
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13campfollower
	name = "Camp Follower"
	id = /obj/item/card/id/dogtag/legforgemaster
	glasses = /obj/item/clothing/glasses/welding
	shoes = /obj/item/clothing/shoes/f13/military/plated
	gloves = null
	r_pocket = /obj/item/flashlight/lantern
	suit_store = 	/obj/item/melee/onehanded/machete/forgedmachete
	backpack_contents = list(
		/obj/item/storage/bag/money/small/legenlisted = 1,
		/obj/item/stack/sheet/metal/twenty = 2,
		/obj/item/stack/sheet/mineral/wood/twenty = 1,
		/obj/item/stack/sheet/leather/twenty = 1,
		/obj/item/stack/sheet/cloth/thirty = 1,
		/obj/item/stack/sheet/prewar/twenty = 1
		)

/datum/outfit/loadout/forgemaster
	name = "Forgemaster"
	backpack_contents = list(
		/obj/item/storage/belt/utility/waster/forgemaster = 1,
		/obj/item/clothing/neck/apron/labor/forge = 1,
		/obj/item/weldingtool = 1,
		/obj/item/book/granter/trait/explosives = 1,
		/obj/item/book/granter/trait/explosives_advanced = 1,
		/obj/item/clothing/gloves/blacksmith_mittens = 1
		)

/datum/outfit/loadout/headmedicus
	name = "Head Surgeon"
	backpack_contents = list(
		/obj/item/clothing/neck/apron/medical/surgical = 1,
		/obj/item/clothing/gloves/color/latex = 1,
		/obj/item/storage/belt/medical/primitive = 1,
		/obj/item/book/granter/trait/midsurgery = 1
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13campfollower/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_TRIBAL, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	if(H.gender == FEMALE)
		H.gender = MALE
		H.real_name = random_unique_name(MALE)
		H.name = H.real_name
		if(H.wear_id)
			var/obj/item/card/id/dogtag/L = H.wear_id
			L.registered_name = H.name
			L.update_label()
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/dks)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legionshield)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/lever_action)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/grease_gun)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/brush)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/huntingshotgun)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/high_explosive)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/strongrocket)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/empgrenade)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tribalwar/xbow)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tribalwar/cheaparrow)



// LEGION SLAVES - Servant cook, and assist with medical, low surgery. Worker farm and mine.
// Both get Mars teachings to help out when normal work is done.

/datum/job/CaesarsLegion/slave
	title = "Legion Slave"
	flag = F13LEGIONSLAVE
	total_positions = 0
	spawn_positions = 0
	description = "A slave that survives the breaking camps is given a Legion appropriate name (latin-tribal inspired) and bull tattoo. Be obedient, respectful, stay inside the camp. Work the farm, mine, make food, clean and help injured men. Do NOT escape on your own, up to you how to handle it if forcibly freed by outside forces."
	supervisors = "Officers and Camp Exactor first, then warriors."
	display_order = JOB_DISPLAY_ORDER_LEGIONSLAVE
	exp_requirements = 0
	outfit = /datum/outfit/job/CaesarsLegion/slave

	loadout_options = list(
		/datum/outfit/loadout/slaveservant,
		/datum/outfit/loadout/slaveworker,
		/datum/outfit/loadout/slavetreasure,
		/datum/outfit/loadout/slavemedicus,
		/datum/outfit/loadout/slaveopifex
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/CaesarsLegion/slave,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/CaesarsLegion/slave,
		),
	)

/datum/outfit/job/CaesarsLegion/slave/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_SURGERY_LOW, src)
	ADD_TRAIT(H, TRAIT_MARS_TEACH, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tailor/legionuniform)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/warpaint)
	if(H.gender == MALE)
		H.gender = FEMALE
		H.real_name = random_unique_name(FEMALE)
		H.name = H.real_name
		if(H.wear_id)
			var/obj/item/card/id/dogtag/L = H.wear_id
			L.registered_name = H.name
			L.update_label()


/datum/outfit/job/CaesarsLegion/slave
	name = "Legion Slave"
	jobtype = /datum/outfit/job/CaesarsLegion/slave
	id = /obj/item/card/id/legionbrand
	uniform = /obj/item/clothing/under/f13/legslavef
	neck = /obj/item/electropack/shockcollar
	shoes =	/obj/item/clothing/shoes/roman
	l_pocket = /obj/item/radio

/datum/outfit/loadout/slaveservant
	name = "Servant"
	head = /obj/item/clothing/head/f13/servant
	uniform	= /obj/item/clothing/under/f13/campfollowermale
	gloves = /obj/item/clothing/gloves/f13/crudemedical
	r_pocket = /obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/reagent_containers/pill/healingpowder = 2,
		/obj/item/reagent_containers/pill/patch/healpoultice = 2,
		/obj/item/smelling_salts = 1,
		/obj/item/book/granter/trait/lowsurgery = 1,
		/obj/item/reagent_containers/food/condiment/flour = 2,
		/obj/item/storage/box/bowls = 1,
		/obj/item/reagent_containers/glass/beaker/large = 1,
		/obj/item/soap/homemade = 1,
		/obj/item/lighter = 1,
		)

/datum/outfit/loadout/slaveworker
	name = "Worker"
	suit = /obj/item/clothing/suit/armor/outfit/slavelabor
	uniform = /obj/item/clothing/under/f13/legslave
	shoes =	/obj/item/clothing/shoes/f13/rag
	r_hand = /obj/item/flashlight/flare/torch
	backpack_contents = list(
		/obj/item/storage/bag/plants = 1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/deus = 1,
		/obj/item/cultivator = 1,
		/obj/item/soap/homemade = 1,
		/obj/item/shovel/spade = 1,
		)

/datum/outfit/loadout/slavetreasure
	name = "Treasurer"
	neck = /obj/item/clothing/neck/mantle/treasurer
	backpack_contents = list(
		/obj/item/folder/red = 1,
		/obj/item/paper/natural = 2,
		/obj/item/pen/fountain = 1,
		/obj/item/storage/bag/money/small/legion = 1,
		/obj/item/taperecorder = 1,
		)

/datum/outfit/loadout/slavemedicus
	name = "Surgeon"
	neck = /obj/item/clothing/neck/apron/medical
	gloves = /obj/item/clothing/gloves/f13/crudemedical
	belt = /obj/item/storage/belt/medical/primitive
	backpack_contents = list(
		/obj/item/storage/firstaid/ancient = 1,
		/obj/item/stack/sticky_tape/surgical = 1,
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/book/granter/trait/midsurgery = 1,
		)

/datum/outfit/loadout/slaveopifex
	name = "Artisan"
	neck = /obj/item/clothing/neck/apron/labor/forge
	gloves = /obj/item/clothing/gloves/blacksmith_mittens
	belt = /obj/item/storage/belt/fannypack
	glasses = /obj/item/clothing/glasses/welding
	shoes = /obj/item/clothing/shoes/f13/military/plated
	r_pocket = /obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/stack/sheet/metal/twenty = 2,
		/obj/item/stack/sheet/mineral/wood/twenty = 1,
		/obj/item/stack/sheet/leather/twenty = 1,
		/obj/item/stack/sheet/cloth/thirty = 1,
		/obj/item/stack/sheet/prewar/twenty = 1,
		/obj/item/weldingtool = 1,
		/obj/item/book/granter/trait/explosives = 1
		)

// Legion Citizen
// Really only used for ID console
/datum/job/ncr/f13legioncitizen
	title = "Legion Citizen"
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13legioncitizen

/datum/outfit/job/CaesarsLegion/Legionnaire/f13legioncitizen
	name = "Legion Citizen (Role)"
	uniform = /obj/item/clothing/under/f13/doctor
	shoes = /obj/item/clothing/shoes/f13/fancy
	suit = /obj/item/clothing/suit/curator
	head = /obj/item/clothing/head/scarecrow_hat
	gloves = /obj/item/clothing/gloves/color/black
	glasses = /obj/item/clothing/glasses/welding
	id = /obj/item/card/id/dogtag/town/legion
	l_hand = /obj/item/shield/riot/buckler
	backpack_contents = list(
		/obj/item/melee/onehanded/machete/spatha = 1,
		)
