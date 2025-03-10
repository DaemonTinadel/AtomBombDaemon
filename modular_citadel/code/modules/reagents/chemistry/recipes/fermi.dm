/datum/chemical_reaction/fermi
	mix_sound = 'sound/effects/bubbles.ogg'

//Called for every reaction step
/datum/chemical_reaction/proc/FermiCreate(datum/reagents/holder, added_volume, added_purity)
	return

//Called when reaction STOP_PROCESSING
/datum/chemical_reaction/proc/FermiFinish(datum/reagents/holder, atom/my_atom, reactVol)
	if(clear_conversion == REACTION_CLEAR_IMPURE | REACTION_CLEAR_INVERSE)
		for(var/id in results)
			var/datum/reagent/R = my_atom.reagents.has_reagent(id)
			if(!R || R.purity == 1)
				continue

			var/cached_volume = R.volume
			if(clear_conversion == REACTION_CLEAR_INVERSE && R.inverse_chem)
				if(R.inverse_chem_val > R.purity)
					my_atom.reagents.remove_reagent(R.type, cached_volume, FALSE)
					my_atom.reagents.add_reagent(R.inverse_chem, cached_volume, FALSE, other_purity = 1)

			else if (clear_conversion == REACTION_CLEAR_IMPURE && R.impure_chem)
				var/impureVol = cached_volume * (1 - R.purity)
				my_atom.reagents.remove_reagent(R.type, (impureVol), FALSE)
				my_atom.reagents.add_reagent(R.impure_chem, impureVol, FALSE, other_purity = 1)
				R.cached_purity = R.purity
				R.purity = 1

//Called when temperature is above a certain threshold, or if purity is too low.
/datum/chemical_reaction/proc/FermiExplode(datum/reagents/R0, atom/my_atom, volume, temp, pH, Exploding = FALSE)
	if (Exploding == TRUE)
		return

	if(!pH)//Dunno how things got here without a pH, but just in case
		pH = 7
	var/ImpureTot = 0
	var/turf/T = get_turf(my_atom)

	if(temp>500)//if hot, start a fire
		switch(temp)
			if (500 to 750)
				for(var/turf/turf in range(1,T))
					new /obj/effect/hotspot(turf)
				volume*=1.1

			if (751 to 1100)
				for(var/turf/turf in range(2,T))
					new /obj/effect/hotspot(turf)
				volume*=1.2

			if (1101 to 1500) //If you're crafty
				for(var/turf/turf in range(3,T))
					new /obj/effect/hotspot(turf)
				volume*=1.3

			if (1501 to 2500) //requested
				for(var/turf/turf in range(4,T))
					new /obj/effect/hotspot(turf)
				volume*=1.4

			if (2501 to 5000)
				for(var/turf/turf in range(5,T))
					new /obj/effect/hotspot(turf)
				volume*=1.5

			if (5001 to INFINITY)
				for(var/turf/turf in range(6,T))
					new /obj/effect/hotspot(turf)
				volume*=1.6


	message_admins("Fermi explosion at [T], with a temperature of [temp], pH of [pH], Impurity tot of [ImpureTot].")
	log_game("Fermi explosion at [T], with a temperature of [temp], pH of [pH], Impurity tot of [ImpureTot].")
	var/datum/reagents/R = new/datum/reagents(3000)//Hey, just in case.
	var/datum/effect_system/smoke_spread/chem/s = new()
	R.my_atom = my_atom //Give the gas a fingerprint

	for (var/A in R0.reagent_list) //make gas for reagents, has to be done this way, otherwise it never stops Exploding
		var/datum/reagent/R2 = A
		R.add_reagent(R2.type, R2.volume/3) //Seems fine? I think I fixed the infinite explosion bug.

		if (R2.purity < 0.6)
			ImpureTot = (ImpureTot + (1-R2.purity)) / 2

	if(pH < 4) //if acidic, make acid spray
		R.add_reagent(/datum/reagent/impure/fermiTox, (volume/3))
	if(R.reagent_list)
		s.set_up(R, (volume/5), my_atom)
		s.start()

	if (pH > 10) //if alkaline, small explosion.
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round((volume/28)*(pH-9)), T, 0, 0)
		e.start()

	if(!ImpureTot == 0) //If impure, v.small emp (0.6 or less)
		ImpureTot *= volume
		empulse(T, volume, 1)

	my_atom.reagents.clear_reagents() //just in case
	return



/datum/chemical_reaction/fermi/SDGF
	name = "Synthetic-derived growth factor"
	id = /datum/reagent/fermi/SDGF
	results = list(/datum/reagent/fermi/SDGF = 3)
	required_reagents = list(/datum/reagent/stable_plasma = 1.5, /datum/reagent/medicine/clonexadone = 1.5, /datum/reagent/uranium = 1.5, /datum/reagent/medicine/synthflesh = 1.5)
	mix_message = "the reaction gives off a blorble!"
	required_temp = 1
	//FermiChem vars:
	OptimalTempMin 		= 600 		// Lower area of bell curve for determining heat based rate reactions
	OptimalTempMax 		= 630 		// Upper end for above
	ExplodeTemp 		= 635 		// Temperature at which reaction explodes
	OptimalpHMin 		= 3 		// Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	OptimalpHMax 		= 3.5 		// Higest value for above
	ReactpHLim 			= 2 		// How far out pH wil react, giving impurity place (Exponential phase)
	CatalystFact 		= 0 		// How much the catalyst affects the reaction (0 = no catalyst)
	CurveSharpT 		= 4 		// How sharp the temperature exponential curve is (to the power of value)
	CurveSharppH 		= 4 		// How sharp the pH exponential curve is (to the power of value)
	ThermicConstant		= -10 		// Temperature change per 1u produced
	HIonRelease 		= 0.02 		// pH change per 1u reaction (inverse for some reason)
	RateUpLim 			= 1 		// Optimal/max rate possible if all conditions are perfect
	FermiChem 			= TRUE		// If the chemical uses the Fermichem reaction mechanics
	FermiExplode 		= TRUE		// If the chemical explodes in a special way
	PurityMin 			= 0.2

/datum/chemical_reaction/fermi/SDGF/FermiExplode(datum/reagents, atom/my_atom, volume, temp, pH)//Spawns an angery teratoma!
	var/turf/T = get_turf(my_atom)
	var/amount_to_spawn = round((volume/100), 1)
	if(amount_to_spawn <= 0)
		amount_to_spawn = 1
	for(var/i in 1 to amount_to_spawn)
		var/mob/living/simple_animal/slime/S = new(T,"pyrite")
		S.damage_coeff = list(BRUTE = 0.9 , BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 1)
		S.name = "Living teratoma"
		S.real_name = "Living teratoma"
		S.rabid = 1//Make them an angery boi
		S.color = "#810010"
	my_atom.reagents.clear_reagents()
	my_atom.visible_message(span_warning("An horrifying tumoural mass forms in [my_atom]!"))

/datum/chemical_reaction/fermi/astral
	name = "Astrogen"
	id = /datum/reagent/fermi/astral
	results = list(/datum/reagent/fermi/astral = 5)
	required_reagents = list(/datum/reagent/fermi/eigenstate = 1, /datum/reagent/toxin/plasma = 3, /datum/reagent/medicine/synaptizine = 1, /datum/reagent/aluminium = 5)
	//FermiChem vars:
	OptimalTempMin 			= 700
	OptimalTempMax			= 800
	ExplodeTemp 			= 1150
	OptimalpHMin 			= 10
	OptimalpHMax 			= 13
	ReactpHLim 				= 2
	CatalystFact 			= 0
	CurveSharpT 			= 1
	CurveSharppH 			= 1
	ThermicConstant 		= 25
	HIonRelease 			= 0.02
	RateUpLim 				= 15
	FermiChem				= TRUE
	FermiExplode 			= TRUE
	PurityMin 				= 0.25

//FOR INSTANT REACTIONS - DO NOT MULTIPLY LIMIT BY 10.
//There's a weird rounding error or something ugh.

//Nano-b-gone
/datum/chemical_reaction/fermi/nanite_b_gone//done test
	name = "Naninte bain"
	id = /datum/reagent/fermi/nanite_b_gone
	results = list(/datum/reagent/fermi/nanite_b_gone = 4)
	required_reagents = list(/datum/reagent/medicine/synthflesh = 1, /datum/reagent/uranium = 1, /datum/reagent/iron = 1, /datum/reagent/medicine/salglu_solution = 1)
	mix_message = "the reaction gurgles, encapsulating the reagents in flesh before the emp can be set off."
	required_temp = 450//To force fermireactions before EMP.
	//FermiChem vars:
	OptimalTempMin 	= 500
	OptimalTempMax 	= 600
	ExplodeTemp 	= 700
	OptimalpHMin 	= 6
	OptimalpHMax 	= 6.25
	ReactpHLim 		= 3
	//CatalystFact 	= 0 //To do 1
	CurveSharpT 	= 0
	CurveSharppH 	= 1
	ThermicConstant = 5
	HIonRelease 	= 0.01
	RateUpLim 		= 1
	FermiChem 		= TRUE

/datum/chemical_reaction/fermi/acidic_buffer//done test
	name = "Acetic acid buffer"
	id = /datum/reagent/fermi/acidic_buffer
	results = list(/datum/reagent/fermi/acidic_buffer = 10) //acetic acid
	required_reagents = list(/datum/reagent/medicine/salglu_solution = 1, /datum/reagent/consumable/ethanol = 3, /datum/reagent/oxygen = 3, /datum/reagent/water = 3)
	//FermiChem vars:
	OptimalTempMin 	= 250
	OptimalTempMax 	= 500
	ExplodeTemp 	= 9999 //check to see overflow doesn't happen!
	OptimalpHMin 	= 0
	OptimalpHMax 	= 14
	ReactpHLim 		= 0
	//CatalystFact 	= 0 //To do 1
	CurveSharpT 	= 4
	CurveSharppH 	= 0
	ThermicConstant = 0
	HIonRelease 	= -0.01
	RateUpLim 		= 20
	FermiChem 		= TRUE


/datum/chemical_reaction/fermi/acidic_buffer/FermiFinish(datum/reagents/holder, atom/my_atom) //might need this
	var/datum/reagent/fermi/acidic_buffer/Fa = locate(/datum/reagent/fermi/acidic_buffer) in my_atom.reagents.reagent_list
	if(!Fa)
		return
	Fa.data = 0.1//setting it to 0 means byond thinks it's not there.

/datum/chemical_reaction/fermi/basic_buffer//done test
	name = "Ethyl Ethanoate buffer"
	id = /datum/reagent/fermi/basic_buffer
	results = list(/datum/reagent/fermi/basic_buffer = 5)
	required_reagents = list(/datum/reagent/lye = 1, /datum/reagent/consumable/ethanol = 2, /datum/reagent/water = 2)
	required_catalysts = list(/datum/reagent/toxin/acid = 1) //vagely acetic
	//FermiChem vars:
	OptimalTempMin 	= 250
	OptimalTempMax 	= 500
	ExplodeTemp 	= 9999 //check to see overflow doesn't happen!
	OptimalpHMin 	= 0
	OptimalpHMax 	= 14
	ReactpHLim 		= 0
	//CatalystFact 	= 0 //To do 1
	CurveSharpT 	= 4
	CurveSharppH 	= 0
	ThermicConstant = 0
	HIonRelease 	= 0.01
	RateUpLim 		= 15
	FermiChem 		= TRUE

/datum/chemical_reaction/fermi/yamerol//done test
	name = "Yamerol"
	id = /datum/reagent/fermi/yamerol
	results = list(/datum/reagent/fermi/yamerol = 3)
	required_reagents = list(/datum/reagent/medicine/perfluorodecalin = 1, /datum/reagent/medicine/salbutamol = 1, /datum/reagent/water = 1)
	//FermiChem vars:
	OptimalTempMin 	= 300
	OptimalTempMax 	= 500
	ExplodeTemp 	= 800 //check to see overflow doesn't happen!
	OptimalpHMin 	= 6.8
	OptimalpHMax 	= 7.2
	ReactpHLim 		= 4
	//CatalystFact 	= 0 //To do 1
	CurveSharpT 	= 5
	CurveSharppH 	= 0.5
	ThermicConstant = -15
	HIonRelease 	= 0.1
	RateUpLim 		= 2
	FermiChem 		= TRUE

/datum/chemical_reaction/fermi/zeolites
	name = "Zeolites"
	id = /datum/reagent/fermi/zeolites
	results = list(/datum/reagent/fermi/zeolites = 5) //We make a lot!
	required_reagents = list(/datum/reagent/medicine/potass_iodide = 1, /datum/reagent/aluminium = 1, /datum/reagent/silicon = 1, /datum/reagent/oxygen = 1)
	//FermiChem vars:
	OptimalTempMin 	= 300
	OptimalTempMax 	= 900
	ExplodeTemp 	= 1000 //check to see overflow doesn't happen!
	OptimalpHMin 	= 4.0
	OptimalpHMax 	= 6.0
	ReactpHLim 		= 4
	//CatalystFact 	= 0
	CurveSharpT 	= 4
	CurveSharppH 	= 0
	ThermicConstant = 0
	HIonRelease 	= 0.01
	RateUpLim 		= 15
	FermiChem 		= TRUE

datum/chemical_reaction/fermi/eigenstate
	name = "Eigenstasium"
	id = /datum/reagent/fermi/eigenstate
	results = list(/datum/reagent/fermi/eigenstate = 1)
	required_reagents = list(/datum/reagent/bluespace = 1, /datum/reagent/stable_plasma = 1, /datum/reagent/consumable/caramel = 1)
	mix_message = "the reaction zaps suddenly!"
	//FermiChem vars:
	OptimalTempMin 		= 350 // Lower area of bell curve for determining heat based rate reactions
	OptimalTempMax		= 600 // Upper end for above
	ExplodeTemp			= 650 //Temperature at which reaction explodes
	OptimalpHMin		= 7 // Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	OptimalpHMax		= 9 // Higest value for above
	ReactpHLim			= 5 // How far out pH wil react, giving impurity place (Exponential phase)
	CatalystFact		= 0 // How much the catalyst affects the reaction (0 = no catalyst)
	CurveSharpT 		= 1.5 // How sharp the temperature exponential curve is (to the power of value)
	CurveSharppH 		= 3 // How sharp the pH exponential curve is (to the power of value)
	ThermicConstant		= 10 //Temperature change per 1u produced
	HIonRelease 		= -0.02 //pH change per 1u reaction
	RateUpLim 			= 3 //Optimal/max rate possible if all conditions are perfect
	FermiChem 			= TRUE//If the chemical uses the Fermichem reaction mechanics
	FermiExplode 		= FALSE //If the chemical explodes in a special way
	PurityMin			= 0.4 //The minimum purity something has to be above, otherwise it explodes.

/datum/chemical_reaction/fermi/eigenstate/FermiFinish(datum/reagents/holder, atom/my_atom)//Strange how this doesn't work but the other does.
	var/datum/reagent/fermi/eigenstate/E = locate(/datum/reagent/fermi/eigenstate) in my_atom.reagents.reagent_list
	if(!E)
		return
	var/turf/open/location = get_turf(my_atom)
	if(location)
		E.location_created = location
		E.data["location_created"] = location

/datum/chemical_reaction/fermi/plushmium // done
	name = "Plushification serum"
	id = /datum/reagent/fermi/plushmium
	results = list(/datum/reagent/fermi/plushmium = 5)
	required_reagents = list(/datum/reagent/medicine/strange_reagent = 5, /datum/reagent/drug/happiness = 3, /datum/reagent/blood = 10, /datum/reagent/consumable/laughter = 5, /datum/reagent/toxin/bad_food = 6)
	//mix_message = ""
	//FermiChem vars:
	OptimalTempMin 	= 400
	OptimalTempMax 	= 666
	ExplodeTemp 	= 800
	OptimalpHMin 	= 2
	OptimalpHMax 	= 5
	ReactpHLim 		= 6
	//CatalystFact 	= 0 //To do 1
	CurveSharpT 	= 8
	CurveSharppH 	= 0.5
	ThermicConstant = -2
	HIonRelease 	= -0.1
	RateUpLim 		= 2
	FermiChem 		= TRUE
	FermiExplode 	= TRUE
	PurityMin		= 0.6

/datum/chemical_reaction/fermi/plushmium/FermiExplode(datum/reagents, var/atom/my_atom, volume, temp, pH)
	if(volume < 20) //It creates a normal plush at low volume.. at higher amounts, things get slightly more interesting.
		new /obj/item/toy/plush/plushling(get_turf(my_atom))
	else
		new /obj/item/toy/plush/plushling(get_turf(my_atom))
	my_atom.visible_message("<span class='warning'>The reaction suddenly zaps, creating a plushie!</b></span>")
	my_atom.reagents.clear_reagents()

/datum/chemical_reaction/fermi/basic_buffer/FermiFinish(datum/reagents/holder, atom/my_atom) //might need this
	var/datum/reagent/fermi/basic_buffer/Fb = locate(/datum/reagent/fermi/basic_buffer) in my_atom.reagents.reagent_list
	if(!Fb)
		return
	Fb.data = 14
