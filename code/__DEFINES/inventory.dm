/*ALL DEFINES RELATED TO INVENTORY OBJECTS, MANAGEMENT, ETC, GO HERE*/

//Inventory depth: limits how many nested storage items you can access directly.
//1: stuff in mob, 2: stuff in backpack, 3: stuff in box in backpack, etc
#define STORAGE_VIEW_DEPTH 1
#define INVENTORY_DEPTH 2
#define FAR_DEPTH 6

//ITEM INVENTORY SLOT BITMASKS
#define ITEM_SLOT_OCLOTHING		(1<<0)
#define ITEM_SLOT_ICLOTHING		(1<<1)
#define ITEM_SLOT_GLOVES		(1<<2)
#define ITEM_SLOT_EYES			(1<<3)
#define ITEM_SLOT_EARS			(1<<4)
#define ITEM_SLOT_MASK			(1<<5)
#define ITEM_SLOT_HEAD			(1<<6)
#define ITEM_SLOT_FEET			(1<<7)
#define ITEM_SLOT_ID			(1<<8)
#define ITEM_SLOT_BELT			(1<<9)
#define ITEM_SLOT_BACK			(1<<10)
#define ITEM_SLOT_POCKET		(1<<11) // this is to allow items with a w_class of WEIGHT_CLASS_NORMAL or WEIGHT_CLASS_BULKY to fit in pockets.
#define ITEM_SLOT_DENYPOCKET	(1<<12) // this is to deny items with a w_class of WEIGHT_CLASS_SMALL or WEIGHT_CLASS_TINY to fit in pockets.
#define ITEM_SLOT_NECK			(1<<13)
#define ITEM_SLOT_HANDS			(1<<14)
#define ITEM_SLOT_BACKPACK		(1<<15)
#define ITEM_SLOT_SUITSTORE		(1<<16)

//A list of the variable names of all slots people can equip things in. This is used to massively reduce code complexity when checking all slots
#define ALL_EQUIP_SLOTS list("w_uniform", "wear_suit", "back", "belt", "gloves", "shoes", "head", "wear_mask", "wear_neck", "ears", \
"glasses", "wear_id", "l_store", "r_store", "s_store")
#define ALL_OUTFIT_SLOTS list("uniform", "suit", "back", "belt", "gloves", "shoes", "head", "mask", "neck", "ears", \
"glasses", "id", "l_pocket", "r_pocket", "suit_store", "r_hand", "l_hand", "internals_slot")

//SLOTS
#define SLOT_BACK			1
#define SLOT_WEAR_MASK		2
#define SLOT_HANDCUFFED		3
#define SLOT_HANDS			4 //wherever you provide a slot for hands you provide SLOT_HANDS
								//SLOT_HANDS as a slot will pick ANY available hand
#define SLOT_BELT			5
#define SLOT_WEAR_ID		6
#define SLOT_EARS			7
#define SLOT_GLASSES		8
#define SLOT_GLOVES			9
#define SLOT_NECK			10
#define SLOT_HEAD			11
#define SLOT_SHOES			12
#define SLOT_WEAR_SUIT		13
#define SLOT_W_UNIFORM		14
#define SLOT_L_STORE		15
#define SLOT_R_STORE		16
#define SLOT_S_STORE		17
#define SLOT_IN_BACKPACK	18
#define SLOT_LEGCUFFED		19
#define SLOT_GENERC_DEXTROUS_STORAGE	20


#define SLOTS_AMT			20 // Keep this up to date!

//I hate that this has to exist
/proc/slotdefine2slotbit(slotdefine) //Keep this up to date with the value of SLOT BITMASKS and SLOTS (the two define sections above)
	. = 0
	switch(slotdefine)
		if(SLOT_BACK)
			. = ITEM_SLOT_BACK
		if(SLOT_WEAR_MASK)
			. = ITEM_SLOT_MASK
		if(SLOT_NECK)
			. = ITEM_SLOT_NECK
		if(SLOT_BELT)
			. = ITEM_SLOT_BELT
		if(SLOT_WEAR_ID)
			. = ITEM_SLOT_ID
		if(SLOT_EARS)
			. = ITEM_SLOT_EARS
		if(SLOT_GLASSES)
			. = ITEM_SLOT_EYES
		if(SLOT_GLOVES)
			. = ITEM_SLOT_GLOVES
		if(SLOT_HEAD)
			. = ITEM_SLOT_HEAD
		if(SLOT_SHOES)
			. = ITEM_SLOT_FEET
		if(SLOT_WEAR_SUIT)
			. = ITEM_SLOT_OCLOTHING
		if(SLOT_W_UNIFORM)
			. = ITEM_SLOT_ICLOTHING
		if(SLOT_L_STORE, SLOT_R_STORE)
			. = ITEM_SLOT_POCKET
		if(SLOT_HANDS)
			. = ITEM_SLOT_HANDS
		if(SLOT_IN_BACKPACK)
			. = ITEM_SLOT_BACKPACK
		if(SLOT_S_STORE)
			. = ITEM_SLOT_SUITSTORE


//Bit flags for the flags_inv variable, which determine when a piece of clothing hides another. IE a helmet hiding glasses.
#define HIDEGLOVES		(1<<0)
#define HIDESUITSTORAGE	(1<<1)
#define HIDEJUMPSUIT	(1<<2)	//these first four are only used in exterior suits
#define HIDESHOES		(1<<3)
#define HIDEMASK		(1<<4)	//these last six are only used in masks and headgear.
#define HIDEEARS		(1<<5)	// (ears means headsets and such)
#define HIDEEYES		(1<<6)	// Whether eyes and glasses are hidden
#define HIDEFACE		(1<<7)	// Whether we appear as unknown.
#define HIDEHAIR		(1<<8)
#define HIDEFACIALHAIR	(1<<9)
#define HIDENECK		(1<<10)
#define HIDETAUR		(1<<11) //gotta hide that snowflake
#define HIDESNOUT		(1<<12) //or do we actually hide our snoots
#define HIDEACCESSORY	(1<<13) //hides the jumpsuit accessory.

//bitflags for clothing coverage - also used for limbs
#define HEAD		(1<<0)
#define CHEST		(1<<1)
#define GROIN		(1<<2)
#define LEG_LEFT	(1<<3)
#define LEG_RIGHT	(1<<4)
#define LEGS		(LEG_LEFT | LEG_RIGHT)
#define FOOT_LEFT	(1<<5)
#define FOOT_RIGHT	(1<<6)
#define FEET		(FOOT_LEFT | FOOT_RIGHT)
#define ARM_LEFT	(1<<7)
#define ARM_RIGHT	(1<<8)
#define ARMS		(ARM_LEFT | ARM_RIGHT)
#define HAND_LEFT	(1<<9)
#define HAND_RIGHT	(1<<10)
#define HANDS		(HAND_LEFT | HAND_RIGHT)
#define NECK		(1<<11)
#define FULL_BODY	(~0)

//flags for alternate styles: These are hard sprited so don't set this if you didn't put the effort in
#define NORMAL_STYLE		0
#define ALT_STYLE			1

//flags for female outfits: How much the game can safely "take off" the uniform without it looking weird
#define NO_FEMALE_UNIFORM			0
#define FEMALE_UNIFORM_FULL			1
#define FEMALE_UNIFORM_TOP			2

//flags for outfits that have mutant race variants: Most of these require additional sprites to work.
#define STYLE_DIGITIGRADE		(1<<0) //jumpsuits, suits and shoes
#define STYLE_MUZZLE			(1<<1) //hats or masks
#define STYLE_SNEK_TAURIC		(1<<2) //taur-friendly suits
#define STYLE_PAW_TAURIC		(1<<3)
#define STYLE_HOOF_TAURIC		(1<<4)
#define STYLE_ALL_TAURIC		(STYLE_SNEK_TAURIC|STYLE_PAW_TAURIC|STYLE_HOOF_TAURIC)
#define STYLE_NO_ANTHRO_ICON	(1<<5) //When digis fit the default sprite fine and need no copypasted states. This is the case of skirts and winter coats, for example.
#define USE_SNEK_CLIP_MASK		(1<<6)
#define USE_QUADRUPED_CLIP_MASK	(1<<7)
#define USE_TAUR_CLIP_MASK		(USE_SNEK_CLIP_MASK|USE_QUADRUPED_CLIP_MASK)

//digitigrade legs settings.
#define NOT_DIGITIGRADE				0
#define FULL_DIGITIGRADE			1
#define SQUISHED_DIGITIGRADE		2

//flags for covering body parts
#define GLASSESCOVERSEYES	(1<<0)
#define MASKCOVERSEYES		(1<<1)		// get rid of some of the other stupidity in these flags
#define HEADCOVERSEYES		(1<<2)		// feel free to realloc these numbers for other purposes
#define MASKCOVERSMOUTH		(1<<3)		// on other items, these are just for mask/head
#define HEADCOVERSMOUTH		(1<<4)

#define TINT_DARKENED 2			//Threshold of tint level to apply weld mask overlay
#define TINT_BLIND 3			//Threshold of tint level to obscure vision fully

// defines for AFK theft
/// How many messages you can remember while logged out before you stop remembering new ones
#define AFK_THEFT_MAX_MESSAGES 10
/// If someone logs back in and there are entries older than this, just tell them they can't remember who it was or when
#define AFK_THEFT_FORGET_DETAILS_TIME 5 MINUTES
/// The index of the entry in 'afk_thefts' with the person's visible name at the time
#define AFK_THEFT_NAME 1
/// The index of the entry in 'afk_thefts' with the text
#define AFK_THEFT_MESSAGE 2
/// The index of the entry in 'afk_thefts' with the time it happened
#define AFK_THEFT_TIME 3

//Allowed equipment lists for security vests and hardsuits.

/// Little bitty ammo thingies
GLOBAL_LIST_INIT(small_ammo_types, typecacheof(list(
	/obj/item/ammo_box/magazine/pistol22,
	/obj/item/ammo_box/magazine/zipgun,
	/obj/item/ammo_box/magazine/pistol9mm,
	/obj/item/ammo_box/magazine/pistol45,
	/obj/item/ammo_box/magazine/pistol44,
	/obj/item/ammo_box/magazine/pistol14mm,
	/obj/item/ammo_box/magazine/autopipe,
	/obj/item/ammo_box/magazine/m556/rifle/small,
	/obj/item/ammo_box/loader/c38,
	/obj/item/ammo_box/loader/a10mm,
	/obj/item/ammo_box/loader/a357,
	/obj/item/ammo_box/loader/m44,
	/obj/item/ammo_box/loader/acp45,
	/obj/item/ammo_box/loader/longcolt45,
	/obj/item/ammo_box/loader/rev308,
	/obj/item/ammo_box/loader/c4570,
	/obj/item/ammo_box/stripper/a762,
	/obj/item/ammo_box/stripper/a308,
	/obj/item/ammo_box/stripper/a556,
	/obj/item/ammo_box/stripper/needle,
	/obj/item/ammo_box/foambox
	)))

GLOBAL_LIST_INIT(holster_allowed, typecacheof(list(
	/obj/item/gun
	)))

/// Not so little bitty ammo thingies
GLOBAL_LIST_INIT(holster_disallowed, typecacheof(list(
	/obj/item/ammo_box/magazine/pistol22/extended
	)))

GLOBAL_LIST_INIT(advanced_hardsuit_allowed, typecacheof(list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/flashlight,
	/obj/item/gun,
	/obj/item/melee/baton,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals
	)))

GLOBAL_LIST_INIT(security_hardsuit_allowed, typecacheof(list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/flashlight,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/melee/baton,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals
	)))

GLOBAL_LIST_INIT(f13_coat_allowed, typecacheof(list(
	/obj/item/gun,
	/obj/item/kitchen,
	/obj/item/twohanded,
	/obj/item/twohanded/spear,
	/obj/item/reagent_containers/food/drinks/flask,
	/obj/item/melee,
	/obj/item/flashlight,
	/obj/item/tank/internals,
	/obj/item/storage/fancy/cigarettes,
	/obj/item/throwing_star/spear,
	/obj/item/restraints/legcuffs/bola
	)))

GLOBAL_LIST_INIT(detective_vest_allowed, typecacheof(list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/detective_scanner,
	/obj/item/flashlight,
	/obj/item/taperecorder,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/lighter,
	/obj/item/melee/baton,
	/obj/item/melee/classic_baton,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/storage/fancy/cigarettes,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/tank/internals/plasmaman
	)))

GLOBAL_LIST_INIT(security_vest_allowed, typecacheof(list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/flashlight,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/melee/onehanded/knife,
	/obj/item/melee/baton,
	/obj/item/melee/classic_baton/telescopic,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/tank/internals/plasmaman
	)))

GLOBAL_LIST_INIT(security_wintercoat_allowed, typecacheof(list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/flashlight,
	/obj/item/storage/fancy/cigarettes,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/lighter,
	/obj/item/melee/baton,
	/obj/item/melee/classic_baton/telescopic,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/tank/internals/plasmaman,
	/obj/item/toy
	)))

///things every armor can hold in their slot
GLOBAL_LIST_INIT(default_all_armor_slot_allowed, typecacheof(list(
	/obj/item/storage/backpack/spearquiver,
	/obj/item/flashlight,
	/obj/item/gun,
	/obj/item/melee,
	/obj/item/twohanded,
	/obj/item/throwing_star,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals,
	/obj/item/restraints/legcuffs/bola,
	/obj/item/kitchen,
	/obj/item/toy
	)))

/// Things allowed in a toolbelt
GLOBAL_LIST_INIT(toolbelt_allowed, typecacheof(list(
	/obj/item/crowbar,
	/obj/item/screwdriver,
	/obj/item/weldingtool,
	/obj/item/wirecutters,
	/obj/item/wrench,
	/obj/item/multitool,
	/obj/item/inducer,
	/obj/item/flashlight,
	/obj/item/stack/cable_coil,
	/obj/item/stack/sheet,
	/obj/item/stock_parts,
	/obj/item/twohanded/chainsaw,
	/obj/item/melee/smith/hammer,
	/obj/item/t_scanner,
	/obj/item/analyzer,
	/obj/item/geiger_counter,
	/obj/item/extinguisher/mini,
	/obj/item/radio,
	/obj/item/lightreplacer,
	/obj/item/rcd_ammo,
	/obj/item/resonator,
	/obj/item/mining_scanner,
	/obj/item/pickaxe,
	/obj/item/lighter,
	/obj/item/storage/fancy/cigarettes,
	/obj/item/reagent_containers/food/drinks/bottle,
	/obj/item/kitchen/knife,
	/obj/item/gps,
	/obj/item/storage/bag/ore,
	/obj/item/survivalcapsule,
	/obj/item/t_scanner/adv_mining_scanner,
	/obj/item/stack/ore,
	/obj/item/reagent_containers/food/drinks,
	/obj/item/organ/regenerative_core,
	/obj/item/wormhole_jaunter,
	/obj/item/stack/marker_beacon,
	/obj/item/reagent_containers/food/snacks/donut,
	/obj/item/flashlight/seclite,
	/obj/item/construction,
	/obj/item/circuitboard,
	/obj/item/clothing/gloves,
	/obj/item/clothing/mask/gas/welding,
	/obj/item/clothing/glasses/welding,
	/obj/item/clothing/head/welding,
	/obj/item/clothing/head/helmet/f13/raider/arclight,
	/obj/item/holosign_creator,
	/obj/item/grenade/chem_grenade,
	/obj/item/flashlight,
	/obj/item/reagent_containers/glass/beaker,
	/obj/item/reagent_containers/glass/bottle,
	/obj/item/reagent_containers/spray,
	/obj/item/soap,
	/obj/item/holosign_creator,
	/obj/item/forcefield_projector,
	/obj/item/key/janitor,
	/obj/item/clothing/gloves,
	/obj/item/melee/flyswatter,
	/obj/item/broom,
	/obj/item/paint/paint_remover,
	/obj/item/assembly/mousetrap,
	/obj/item/screwdriver,
	/obj/item/kitchen,
	/obj/item/reagent_containers/food,
	/obj/item/gun/ballistic/revolver/detective,
	/obj/item/gun/ballistic/revolver/m29/snub,
	/obj/item/shovel,
	/obj/item/cultivator,
	/obj/item/hatchet,
	/obj/item/book/manual/advice_farming,
	/obj/item/reagent_containers/glass/bottle,
	/obj/item/reagent_containers/glass/bucket,
	/obj/item/reagent_containers/glass/beaker,
	/obj/item/reagent_containers/food/drinks,
	/obj/item/storage/bag/plants,
	/obj/item/plant_analyzer,
	/obj/item/scythe, 
	/obj/item/assembly/signaler,
	/obj/item/grenade/chem_grenade,
	/obj/item/lightreplacer,
	/obj/item/flashlight,
	/obj/item/reagent_containers/glass/beaker,
	/obj/item/reagent_containers/glass/bottle,
	/obj/item/reagent_containers/spray,
	/obj/item/soap,
	/obj/item/holosign_creator,
	/obj/item/forcefield_projector,
	/obj/item/key/janitor,
	/obj/item/clothing/gloves,
	/obj/item/melee/flyswatter,
	/obj/item/broom,
	/obj/item/paint/paint_remover,
	/obj/item/assembly/mousetrap,
	/obj/item/screwdriver,
	/obj/item/stack/cable_coil,
	/obj/item/reagent_containers/food
	)))

/// Things allowed in a medibelt
GLOBAL_LIST_INIT(medibelt_allowed, typecacheof(list(
	/obj/item/healthanalyzer,
	/obj/item/dnainjector,
	/obj/item/reagent_containers/dropper,
	/obj/item/reagent_containers/glass/beaker,
	/obj/item/reagent_containers/glass/bottle,
	/obj/item/reagent_containers/pill,
	/obj/item/reagent_containers/syringe,
	/obj/item/reagent_containers/medspray,
	/obj/item/reagent_containers/hypospray,
	/obj/item/reagent_containers/chem_pack,
	/obj/item/reagent_containers/hypospray/medipen,
	/obj/item/lighter,
	/obj/item/storage/fancy/cigarettes,
	/obj/item/storage/pill_bottle,
	/obj/item/stack/medical,
	/obj/item/flashlight/pen,
	/obj/item/extinguisher/mini,
	/obj/item/hypospray,
	/obj/item/sensor_device,
	/obj/item/radio,
	/obj/item/clothing/gloves,
	/obj/item/lazarus_injector,
	/obj/item/clothing/mask/surgical,
	/obj/item/clothing/mask/breath,
	/obj/item/surgical_drapes, //for true paramedics
	/obj/item/bedsheet, //for true hobos
	/obj/item/scalpel,
	/obj/item/circular_saw,
	/obj/item/bonesetter,
	/obj/item/surgicaldrill,
	/obj/item/retractor,
	/obj/item/cautery,
	/obj/item/hemostat,
	/obj/item/geiger_counter,
	/obj/item/clothing/neck/stethoscope,
	/obj/item/stamp,
	/obj/item/cosmetics/razor,
	/obj/item/clothing/glasses,
	/obj/item/wrench/medical,
	/obj/item/clothing/mask/muzzle,
	/obj/item/storage/bag/chemistry,
	/obj/item/storage/bag/bio,
	/obj/item/reagent_containers/blood,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/implantcase,
	/obj/item/implant,
	/obj/item/implanter,
	/obj/item/pinpointer/crew,
	/obj/item/weldingtool,
	/obj/item/gun/ballistic/revolver/needler, // the healing is not as rewarding as the hurting
	/obj/item/ammo_box/stripper/needle,
	/obj/item/tele_iv,
	/obj/item/stack/sticky_tape, //surgical tape
	/obj/item/handsaw,
	/obj/item/reagent_containers/food,
	/obj/item/slime_extract,
	/obj/item/reagent_containers/blood,
	/obj/item/organ,
	/obj/item/bodypart
	)))

/// Things allowed in a holster (more of a secbelt)
GLOBAL_LIST_INIT(gunbelt_allowed, GLOB.small_ammo_types + typecacheof(list(
	/obj/item/storage/fancy/cigarettes,
	/obj/item/gun,
	/obj/item/stock_parts/cell/ammo,
	/obj/item/ammo_casing,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/reagent_containers/glass/beaker,
	/obj/item/reagent_containers/glass/bottle,
	/obj/item/reagent_containers/hypospray/medipen/stimpak,
	/obj/item/reagent_containers/spray,
	/obj/item/melee/onehanded/knife,
	/obj/item/melee/baton,
	/obj/item/melee/classic_baton/telescopic,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals,
	/obj/item/restraints/legcuffs/bola,
	/obj/item/toy,
	/obj/item/reagent_containers/food,
	/obj/item/grenade,
	/obj/item/screwdriver,
	/obj/item/lighter,
	/obj/item/multitool,
	/obj/item/reagent_containers/food/drinks/bottle/molotov,
	/obj/item/grenade/plastic/c4
	)) - GLOB.holster_disallowed) // woo

/// Things allowed in a bandolier
GLOBAL_LIST_INIT(ammobelt_allowed, typecacheof(list(
	/obj/item/storage/fancy/cigarettes,
	/obj/item/ammo_box,
	/obj/item/stock_parts/cell/ammo,
	/obj/item/ammo_casing,
	/obj/item/grenade,
	/obj/item/reagent_containers/hypospray/medipen/stimpak,
	/obj/item/reagent_containers/pill/healingpowder,
	/obj/item/reagent_containers/pill/patch/healpoultice,
	/obj/item/reagent_containers/pill/bitterdrink,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals,
	/obj/item/restraints/legcuffs/bola,
	/obj/item/assembly/flash,
	/obj/item/melee/baton,
	/obj/item/melee/onehanded/knife,
	/obj/item/grenade
	))) 

/// Things allowed in a scabbard
GLOBAL_LIST_INIT(knifebelt_allowed, typecacheof(list(
	/obj/item/storage/fancy/cigarettes,
	/obj/item/melee,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals,
	/obj/item/restraints/legcuffs/bola,
	/obj/item/toy,
	/obj/item/reagent_containers/food
	)))

GLOBAL_LIST_INIT(storage_shoes_can_hold, typecacheof(list(
	/obj/item/reagent_containers/syringe,
	/obj/item/reagent_containers/hypospray/medipen,
	/obj/item/reagent_containers/dropper,
	/obj/item/screwdriver,
	/obj/item/weldingtool/mini,
	/obj/item/pen,
	/obj/item/gun/ballistic/revolver/detective,
	/obj/item/gun/ballistic/revolver/hobo/knifegun,
	/obj/item/melee/onehanded/knife,
	/obj/item/scalpel,
	)))

GLOBAL_LIST_INIT(storage_hat_can_hold, typecacheof(list(
	/obj/item/storage/fancy/cigarettes,
	/obj/item/toy/cards/deck,
	/obj/item/ammo_casing,
	)))

GLOBAL_LIST_INIT(storage_binocular_can_hold, typecacheof(list(
	/obj/item/binoculars,
	)))

GLOBAL_LIST_INIT(storage_treasurer_can_hold, typecacheof(list(
	/obj/item/stack/f13Cash,
	/obj/item/key,
	/obj/item/melee/onehanded/knife,
	/obj/item/paper,
	/obj/item/folder,
	/obj/item/storage/bag/money/small,
	/obj/item/binoculars,
	/obj/item/cosmetics/lipstick,
	/obj/item/pen,
	/obj/item/melee/smith/dagger,
	)))

GLOBAL_LIST_INIT(storage_wallet_can_hold, typecacheof(list(
	/obj/item/stack/spacecash,
	/obj/item/holochip,
	/obj/item/card,
	/obj/item/clothing/mask/cigarette,
	/obj/item/flashlight/pen,
	/obj/item/seeds,
	/obj/item/stack/medical,
	/obj/item/toy/crayon,
	/obj/item/coin,
	/obj/item/dice,
	/obj/item/disk,
	/obj/item/implanter,
	/obj/item/lighter,
	/obj/item/cosmetics/lipstick,
	/obj/item/match,
	/obj/item/paper,
	/obj/item/pen,
	/obj/item/photo,
	/obj/item/reagent_containers/dropper,
	/obj/item/reagent_containers/syringe,
	/obj/item/screwdriver,
	/obj/item/valentine,
	/obj/item/stamp,
	/obj/item/key,
	/obj/item/cartridge,
	/obj/item/camera_film,
	/obj/item/stack/ore/bluespace_crystal,
	/obj/item/reagent_containers/food/snacks/grown/poppy,
	/obj/item/instrument/harmonica,
	/obj/item/mining_voucher,
	/obj/item/suit_voucher,
	/obj/item/reagent_containers/pill,
	/obj/item/coin,
	/obj/item/stack/f13Cash
	)))

GLOBAL_LIST_INIT(storage_holdout_can_hold, typecacheof(list(
	/obj/item/gun/ballistic/automatic/pistol/sig,
	/obj/item/gun/ballistic/revolver/detective,
	/obj/item/gun/ballistic/automatic/hobo/zipgun,
	/obj/item/gun/ballistic/automatic/pistol/pistol14/compact,
	/obj/item/gun/ballistic/revolver/police,
	/obj/item/gun/ballistic/revolver/colt357/lucky,
	/obj/item/gun/ballistic/revolver/m29/snub,
	/obj/item/gun/ballistic/revolver/needler,
	/obj/item/gun/energy/laser/wattz
	)))

GLOBAL_LIST_INIT(storage_produce_bag_can_hold, typecacheof(list(
	/obj/item/reagent_containers/food/snacks/grown,
	/obj/item/seeds,
	/obj/item/grown,
	/obj/item/reagent_containers/honeycomb,
	/obj/item/reagent_containers/food/snacks,
	/obj/item/stack/sheet/wetleather,
	/obj/item/stack/sheet/hairlesshide,
	/obj/item/stack/sheet/animalhide,
	/obj/item/stack/sheet/leatherstrips,
	/obj/item/stack/sheet/leather,
	/obj/item/stack/sheet/sinew,
	/obj/item/stack/sheet/bone,
	/obj/item/fishy
	)))

GLOBAL_LIST_INIT(storage_salvage_storage_bag_can_hold, typecacheof(list(
	/obj/item/advanced_crafting_components,
	/obj/item/stack/crafting,
	/obj/item/crafting,
	/obj/item/multitool/advanced,
	/obj/item/crowbar/hightech,
	/obj/item/wrench/hightech,
	/obj/item/weldingtool/hightech,
	/obj/item/screwdriver/hightech,
	/obj/item/wirecutters/hightech,
	/obj/item/blueprint/research,
	/obj/item/multitool/advanced
	)))

GLOBAL_LIST_INIT(storage_tray_can_hold, typecacheof(list(
	/obj/item/reagent_containers/food,
	/obj/item/reagent_containers/glass,
	/datum/reagent/consumable,
	/obj/item/kitchen/knife,
	/obj/item/kitchen/rollingpin,
	/obj/item/kitchen/fork,
	/obj/item/storage/box
	)))

/// Number of rows volume storage should have
#define STORAGE_ROWS_DEFAULT 1

/* * * * * * * * * * * * * * *
 * The International Pocket
 * * * * * * * * * * * * * * */

/// How many items total fit in a pocket
#define STORAGE_TINY_POCKET_MAX_ITEMS 1
/// How big a thing can fit in a pocket
#define STORAGE_TINY_POCKET_MAX_SIZE WEIGHT_CLASS_TINY
/// How much volume fits in a pocket
#define STORAGE_TINY_POCKET_MAX_TOTAL_SPACE STORAGE_TINY_POCKET_MAX_SIZE * STORAGE_TINY_POCKET_MAX_ITEMS

/// How many items total fit in a pocket
#define STORAGE_SMALL_POCKET_MAX_ITEMS 1
/// How big a thing can fit in a pocket
#define STORAGE_SMALL_POCKET_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a pocket
#define STORAGE_SMALL_POCKET_MAX_TOTAL_SPACE STORAGE_SMALL_POCKET_MAX_SIZE * STORAGE_SMALL_POCKET_MAX_ITEMS

/// How many items total fit in a pocket
#define STORAGE_NORMAL_POCKET_MAX_ITEMS 1
/// How big a thing can fit in a pocket
#define STORAGE_NORMAL_POCKET_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a pocket
#define STORAGE_NORMAL_POCKET_MAX_TOTAL_SPACE STORAGE_NORMAL_POCKET_MAX_SIZE * STORAGE_NORMAL_POCKET_MAX_ITEMS

/// How many items total fit in a pocket
#define STORAGE_BULKY_POCKET_MAX_ITEMS 1
/// How big a thing can fit in a pocket
#define STORAGE_BULKY_POCKET_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a pocket
#define STORAGE_BULKY_POCKET_MAX_TOTAL_SPACE STORAGE_BULKY_POCKET_MAX_SIZE * STORAGE_BULKY_POCKET_MAX_ITEMS

/* * * * * * * * * * * * * * *
 * Belt slot inventory things
 * * * * * * * * * * * * * * */

/// How many items total fit in a specialized belt
#define STORAGE_BELT_SPECIALIZED_MAX_ITEMS 8
/// How big a thing can fit in a specialized belt
#define STORAGE_BELT_SPECIALIZED_MAX_SIZE WEIGHT_CLASS_NORMAL
/// How much volume fits in a specialized belt
#define STORAGE_BELT_SPECIALIZED_MAX_TOTAL_SPACE STORAGE_BELT_SPECIALIZED_MAX_SIZE * STORAGE_BELT_SPECIALIZED_MAX_ITEMS

/// How many items total fit in a generic belt
#define STORAGE_BELT_GENERIC_MAX_ITEMS 6
/// How big a thing can fit in a generic belt
#define STORAGE_BELT_GENERIC_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a generic belt
#define STORAGE_BELT_GENERIC_MAX_TOTAL_SPACE STORAGE_BELT_GENERIC_MAX_SIZE * STORAGE_BELT_GENERIC_MAX_ITEMS

/// How many items total fit in a holster belt - Bandolier
#define STORAGE_BELT_HOLSTER_MAX_ITEMS 4
/// How big a thing can fit in a holster belt
#define STORAGE_BELT_HOLSTER_MAX_SIZE WEIGHT_CLASS_NORMAL
/// How much volume fits in a holster belt
#define STORAGE_BELT_HOLSTER_MAX_TOTAL_SPACE STORAGE_BELT_HOLSTER_MAX_SIZE * STORAGE_BELT_HOLSTER_MAX_ITEMS

/// How many items total fit in a webbing
#define STORAGE_BELT_WEBBING_MAX_ITEMS 8
/// How big a thing can fit in a webbing
#define STORAGE_BELT_WEBBING_MAX_SIZE WEIGHT_CLASS_NORMAL
/// How much volume fits in a webbing
#define STORAGE_BELT_WEBBING_MAX_TOTAL_SPACE STORAGE_BELT_SPECIALIZED_MAX_SIZE * STORAGE_BELT_WEBBING_MAX_ITEMS

/* * * * * * * * * * * * * * *
 * Neck slot inventory things
 * * * * * * * * * * * * * * */

/// How many items total fit in a specialized neckpron
#define STORAGE_NECKPRON_SPECIALIZED_MAX_ITEMS 4
/// How big a thing can fit in a specialized neckpron
#define STORAGE_NECKPRON_SPECIALIZED_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a specialized neckpron
#define STORAGE_NECKPRON_SPECIALIZED_MAX_TOTAL_SPACE STORAGE_NECKPRON_SPECIALIZED_MAX_SIZE * STORAGE_NECKPRON_SPECIALIZED_MAX_ITEMS

/// How many items total fit in a generic neckpron
#define STORAGE_NECKPRON_GENERIC_MAX_ITEMS 3
/// How big a thing can fit in a generic neckpron
#define STORAGE_NECKPRON_GENERIC_MAX_SIZE WEIGHT_CLASS_TINY
/// How much volume fits in a generic neckpron
#define STORAGE_NECKPRON_GENERIC_MAX_TOTAL_SPACE STORAGE_NECKPRON_GENERIC_MAX_SIZE * STORAGE_NECKPRON_GENERIC_MAX_ITEMS

/// How many items total fit in a holster neckpron
#define STORAGE_NECKPRON_HOLSTER_MAX_ITEMS 1
/// How big a thing can fit in a holster neckpron
#define STORAGE_NECKPRON_HOLSTER_MAX_SIZE WEIGHT_CLASS_NORMAL
/// How much volume fits in a holster neckpron
#define STORAGE_NECKPRON_HOLSTER_MAX_TOTAL_SPACE STORAGE_NECKPRON_HOLSTER_MAX_ITEMS * STORAGE_NECKPRON_HOLSTER_MAX_SIZE

/* * * * * * * * * * * * * * *
 * Suit slot inventory things
 * * * * * * * * * * * * * * */

/// How many items total fit in a specialized suit
#define STORAGE_SUIT_SPECIALIZED_MAX_ITEMS 4
/// How big a thing can fit in a specialized suit
#define STORAGE_SUIT_SPECIALIZED_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a specialized suit
#define STORAGE_SUIT_SPECIALIZED_MAX_TOTAL_SPACE STORAGE_SUIT_SPECIALIZED_MAX_SIZE * STORAGE_SUIT_SPECIALIZED_MAX_ITEMS

/// How many items total fit in a generic suit
#define STORAGE_SUIT_GENERIC_MAX_ITEMS 2
/// How big a thing can fit in a generic suit
#define STORAGE_SUIT_GENERIC_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a generic suit
#define STORAGE_SUIT_GENERIC_MAX_TOTAL_SPACE STORAGE_SUIT_GENERIC_MAX_SIZE * STORAGE_SUIT_GENERIC_MAX_ITEMS

/// How many items total fit in a jacket suit
#define STORAGE_SUIT_JACKET_MAX_ITEMS 2
/// How big a thing can fit in a jacket suit
#define STORAGE_SUIT_JACKET_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a jacket suit
#define STORAGE_SUIT_JACKET_MAX_TOTAL_SPACE STORAGE_SUIT_JACKET_MAX_SIZE * STORAGE_SUIT_JACKET_MAX_ITEMS

/// How many items total fit in a duster suit
#define STORAGE_SUIT_DUSTER_MAX_ITEMS 2
/// How big a thing can fit in a duster suit
#define STORAGE_SUIT_DUSTER_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a duster suit
#define STORAGE_SUIT_DUSTER_MAX_TOTAL_SPACE STORAGE_SUIT_DUSTER_MAX_SIZE * STORAGE_SUIT_DUSTER_MAX_ITEMS

/// How many items total fit in a duster armor
#define STORAGE_SUIT_DUSTER_ARMOR_MAX_ITEMS 2
/// How big a thing can fit in a duster armor
#define STORAGE_SUIT_DUSTER_ARMOR_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a duster armor
#define STORAGE_SUIT_DUSTER_ARMOR_MAX_TOTAL_SPACE STORAGE_SUIT_DUSTER_ARMOR_MAX_SIZE * STORAGE_SUIT_DUSTER_ARMOR_MAX_ITEMS

/* * * *
 * Bags
 * * * */

/// How many items total fit in a bag thing
#define STORAGE_BAG_MAX_ITEMS STORAGE_BELT_SPECIALIZED_MAX_ITEMS * 2 //14
/// How big a thing can fit in a bag thing
#define STORAGE_BAG_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a bag thing
#define STORAGE_BAG_MAX_TOTAL_SPACE STORAGE_BAG_MAX_ITEMS * STORAGE_BAG_MAX_SIZE

/// How many items total fit in a trash bag thing
#define STORAGE_TRASH_BAG_MAX_ITEMS STORAGE_BAG_MAX_ITEMS * 2 //28
/// How big a thing can fit in a trash bag thing
#define STORAGE_TRASH_BAG_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a trash bag thing
#define STORAGE_TRASH_BAG_MAX_TOTAL_SPACE STORAGE_TRASH_BAG_MAX_ITEMS * STORAGE_TRASH_BAG_MAX_SIZE

/// How many items total fit in a big trash bag thing
#define STORAGE_BIG_TRASH_BAG_MAX_ITEMS STORAGE_BAG_MAX_ITEMS * 2 //52
/// How big a thing can fit in a trash bag thing
#define STORAGE_BIG_TRASH_BAG_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a trash bag thing
#define STORAGE_BIG_TRASH_BAG_MAX_TOTAL_SPACE STORAGE_BIG_TRASH_BAG_MAX_ITEMS * STORAGE_BIG_TRASH_BAG_MAX_SIZE

/// How many items total fit in a casing bag
#define STORAGE_CASING_BAG_MAX_ITEMS 600
/// How big a thing can fit in a casing bag
#define STORAGE_CASING_BAG_MAX_SIZE WEIGHT_CLASS_NORMAL
/// How much volume fits in a casing bag
#define STORAGE_CASING_BAG_MAX_TOTAL_SPACE STORAGE_CASING_BAG_MAX_ITEMS * STORAGE_CASING_BAG_MAX_SIZE

/// How many items total fit in a casing quiver
#define STORAGE_CASING_QUIVER_MAX_ITEMS 30
/// How big a thing can fit in a casing quiver
#define STORAGE_CASING_QUIVER_MAX_SIZE WEIGHT_CLASS_NORMAL
/// How much volume fits in a casing quiver
#define STORAGE_CASING_QUIVER_MAX_TOTAL_SPACE STORAGE_CASING_QUIVER_MAX_ITEMS * STORAGE_CASING_QUIVER_MAX_SIZE

/* * * * *
 * Boxes
 * * * * */

/// How many items total fit in a box
#define STORAGE_BOX_DEFAULT_MAX_ITEMS 7
/// How big a thing can fit in a box
#define STORAGE_BOX_DEFAULT_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a box
#define STORAGE_BOX_DEFAULT_MAX_TOTAL_SPACE STORAGE_BOX_DEFAULT_MAX_ITEMS * STORAGE_BOX_DEFAULT_MAX_SIZE

/// How many items total fit in a bigbox
#define STORAGE_BIG_BOX_DEFAULT_MAX_ITEMS STORAGE_BOX_DEFAULT_MAX_ITEMS * 2
/// How big a thing can fit in a bigbox
#define STORAGE_BIG_BOX_DEFAULT_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a bigbox
#define STORAGE_BIG_BOX_DEFAULT_MAX_TOTAL_SPACE STORAGE_BIG_BOX_DEFAULT_MAX_ITEMS * STORAGE_BIG_BOX_DEFAULT_MAX_SIZE
/// How many rows in a bigbox
#define STORAGE_ROWS_BIGBOX 2

/// How many items total fit in a hugebox
#define STORAGE_HUGE_BOX_DEFAULT_MAX_ITEMS STORAGE_BIG_BOX_DEFAULT_MAX_ITEMS * 2
/// How big a thing can fit in a hugebox
#define STORAGE_HUGE_BOX_DEFAULT_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a hugebox
#define STORAGE_HUGE_BOX_DEFAULT_MAX_TOTAL_SPACE STORAGE_HUGE_BOX_DEFAULT_MAX_ITEMS * STORAGE_HUGE_BOX_DEFAULT_MAX_SIZE
/// How many rows in a hugebox
#define STORAGE_ROWS_HUGEBOX 3

/* * * * * * * * * *
 * Survival pouches
 * * * * * * * * * */

/// How many items total fit in a generic survival kit
#define STORAGE_BOX_SURVIVAL_GENERIC_DEFAULT_MAX_ITEMS 4
/// How big a thing can fit in a generic survival kit
#define STORAGE_BOX_SURVIVAL_GENERIC_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a generic survival kit
#define STORAGE_BOX_SURVIVAL_GENERIC_MAX_TOTAL_SPACE STORAGE_BOX_SURVIVAL_GENERIC_DEFAULT_MAX_ITEMS * STORAGE_BOX_SURVIVAL_GENERIC_MAX_SIZE

/// How many items total fit in a specialized survival kit
#define STORAGE_BOX_SURVIVAL_SPECIALIZED_DEFAULT_MAX_ITEMS 5
/// How big a thing can fit in a specialized survival kit
#define STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_SIZE WEIGHT_CLASS_SMALL
/// How much volume fits in a specialized survival kit
#define STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE STORAGE_BOX_SURVIVAL_SPECIALIZED_DEFAULT_MAX_ITEMS * STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_SIZE

/// How many items total fit in a triple survival kit
#define STORAGE_BOX_SURVIVAL_TRIPLE_DEFAULT_MAX_ITEMS 21
/// How big a thing can fit in a triple survival kit
#define STORAGE_BOX_SURVIVAL_TRIPLE_MAX_SIZE WEIGHT_CLASS_TINY
/// How much volume fits in a triple survival kit
#define STORAGE_BOX_SURVIVAL_TRIPLE_MAX_TOTAL_SPACE STORAGE_BOX_SURVIVAL_TRIPLE_DEFAULT_MAX_ITEMS * STORAGE_BOX_SURVIVAL_TRIPLE_MAX_SIZE
/// How many rows in a triple survival kit
#define STORAGE_ROWS_SURVIVAL_TRIPLE 3 // triple after all~

/* * * * * * *
 * Backpacks!
 * * * * * * */

/// How many items total fit in a backpack
#define STORAGE_BACKPACK_DEFAULT_MAX_ITEMS 8
/// How big a thing can fit in a backpack
#define STORAGE_BACKPACK_DEFAULT_MAX_SIZE WEIGHT_CLASS_NORMAL
/// How much volume fits in a backpack
#define STORAGE_BACKPACK_DEFAULT_MAX_TOTAL_SPACE STORAGE_BACKPACK_DEFAULT_MAX_ITEMS * STORAGE_BACKPACK_DEFAULT_MAX_SIZE

/// Duffel slowdown
#define DUFFELBAG_SLOWDOWN 0.75 // wear the fuckin bag
#define DUFFELBAG_SCAV_SLOWDOWN 1

/// How many items total fit in a duffel
#define STORAGE_DUFFEL_DEFAULT_MAX_ITEMS 12
/// How big a thing can fit in a duffel
#define STORAGE_DUFFEL_DEFAULT_MAX_SIZE WEIGHT_CLASS_NORMAL
/// How much volume fits in a duffel
#define STORAGE_DUFFEL_DEFAULT_MAX_TOTAL_SPACE STORAGE_DUFFEL_DEFAULT_MAX_ITEMS * WEIGHT_CLASS_NORMAL

/// How many items total fit in a duffel scav
#define STORAGE_DUFFEL_SCAV_DEFAULT_MAX_ITEMS 16
/// How big a thing can fit in a duffel scav
#define STORAGE_DUFFEL_SCAV_DEFAULT_MAX_SIZE WEIGHT_CLASS_NORMAL
/// How much volume fits in a duffel scav
#define STORAGE_DUFFEL_SCAV_DEFAULT_MAX_TOTAL_SPACE STORAGE_DUFFEL_SCAV_DEFAULT_MAX_ITEMS * WEIGHT_CLASS_NORMAL

/* * * * *
 * Wallet
 * * * * */

/// How many items total fit in a box
#define STORAGE_WALLET_DEFAULT_MAX_ITEMS 7
/// How big a thing can fit in a wallet
#define STORAGE_WALLET_DEFAULT_MAX_SIZE WEIGHT_CLASS_TINY
/// How much volume fits in a wallet
#define STORAGE_WALLET_DEFAULT_MAX_TOTAL_SPACE STORAGE_WALLET_DEFAULT_MAX_ITEMS * STORAGE_WALLET_DEFAULT_MAX_SIZE

/* * * * *
 * Brahmin
 * * * * */

/// How many items total fit in a brahmin
#define STORAGE_BRAHMIN_DEFAULT_MAX_ITEMS 5
/// How big a thing can fit in a brahmin
#define STORAGE_BRAHMIN_DEFAULT_MAX_SIZE WEIGHT_CLASS_HUGE
/// How much volume fits in a brahmin
#define STORAGE_BRAHMIN_DEFAULT_MAX_TOTAL_SPACE STORAGE_BRAHMIN_DEFAULT_MAX_ITEMS * STORAGE_BRAHMIN_DEFAULT_MAX_SIZE

//Internals checker
#define GET_INTERNAL_SLOTS(C) list(C.head, C.wear_mask)

//Slots that won't trigger humans' update_genitals() on equip().
GLOBAL_LIST_INIT(no_genitals_update_slots, list(SLOT_L_STORE, SLOT_R_STORE, SLOT_S_STORE, SLOT_IN_BACKPACK, SLOT_LEGCUFFED, SLOT_HANDCUFFED, SLOT_HANDS, SLOT_GENERC_DEXTROUS_STORAGE))
