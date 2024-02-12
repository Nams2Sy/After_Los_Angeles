-- https://textkool.com/fr/ascii-art-generator?hl=full&vl=full&font=ANSI%20Regular&text=PROP%20Toit
return {
	-- ██████  ██████   ██████  ██████      ████████  ██████  ██ ████████ 
	-- ██   ██ ██   ██ ██    ██ ██   ██        ██    ██    ██ ██    ██    
	-- ██████  ██████  ██    ██ ██████         ██    ██    ██ ██    ██    
	-- ██      ██   ██ ██    ██ ██             ██    ██    ██ ██    ██    
	-- ██      ██   ██  ██████  ██             ██     ██████  ██    ██ 

	-- ██████  ██████   ██████  ██████      ███████  ██████  ██      
	-- ██   ██ ██   ██ ██    ██ ██   ██     ██      ██    ██ ██      
	-- ██████  ██████  ██    ██ ██████      ███████ ██    ██ ██      
	-- ██      ██   ██ ██    ██ ██               ██ ██    ██ ██      
	-- ██      ██   ██  ██████  ██          ███████  ██████  ███████ 
	--                                                               
	-- ██████  ██████   ██████  ██████      ███    ███ ██    ██ ██████  
	-- ██   ██ ██   ██ ██    ██ ██   ██     ████  ████ ██    ██ ██   ██ 
	-- ██████  ██████  ██    ██ ██████      ██ ████ ██ ██    ██ ██████  
	-- ██      ██   ██ ██    ██ ██          ██  ██  ██ ██    ██ ██   ██ 
	-- ██      ██   ██  ██████  ██          ██      ██  ██████  ██   ██ 
	['prop_fncwood_10d'] = {
		label = 'Barrière en bois',
		metadata = {
			placable = true,
			name = 'prop_fncwood_10d',
		},
		client = {
			export = "grvsc_faction.prop_fncwood_10d"
		}
	},
	['prop_fncres_09a'] = {
		label = 'Grande barrière en bois',
		metadata = {
			placable = true,
			name = 'prop_fncres_09a'
		},
		client = {
			export = "grvsc_faction.prop_fncres_09a"
		}
	},
	--  ██████  ██████   ██████  ██████      ██    ██ ████████ ██ ██      ██ ████████  █████  ██ ██████  ███████ 
	--	██   ██ ██   ██ ██    ██ ██   ██     ██    ██    ██    ██ ██      ██    ██    ██   ██ ██ ██   ██ ██      
	--	██████  ██████  ██    ██ ██████      ██    ██    ██    ██ ██      ██    ██    ███████ ██ ██████  █████   
	--	██      ██   ██ ██    ██ ██          ██    ██    ██    ██ ██      ██    ██    ██   ██ ██ ██   ██ ██      
	--	██      ██   ██  ██████  ██           ██████     ██    ██ ███████ ██    ██    ██   ██ ██ ██   ██ ███████ 
	-- --- PORTE & PORTAILLE --- --
	['prop_fncres_08gatel'] = {
		label = 'Portillon en bois',
		metadata = {
			placable = true,
			door = {
				type = 'normal',
				open = false
			},
			name = 'prop_fncres_08gatel'
		},
		client = {
			export = "grvsc_faction.prop_fncres_08gatel"
		}
	},
	-- --- COFFRE --- --
	['prop_ld_int_safe_01'] = {
		label = 'Petit Coffre',
		metadata = {
			placable = true,
			chest = {
				weight = 15000,
				slot = 20
			},
			name = 'prop_ld_int_safe_01'
		},
		client = {
			export = "grvsc_faction.prop_ld_int_safe_01"
		}
	},
	-- --- GENERATOR --- --
	['prop_generator_01a'] = {
		label = 'Générateur Niveau 1',
		description = 'Puissance: 250W | Réservoir: 5L (0.25L/H)',
		metadata = {
			placable = true,
			generator = {
				watt =  250, -- Énergie fournie
				maxfuel = 5, -- Réservoir d'essence en L
				consum = 0.25, -- consommation par heure
			},
			name = 'prop_generator_01a'
		},
		client = {
			export = "grvsc_faction.prop_generator_01a"
		}
	},
	['prop_generator_02a'] = {
		label = 'Générateur Niveau 2',
		description = 'Puissance: 600W | Réservoir: 12L (0.50L/H)',
		metadata = {
			placable = true,
			generator = {
				watt =  600, -- Énergie fournie
				maxfuel = 12, -- Réservoir d'essence en L
				consum = 0.50, -- consommation par heure
			},
			name = 'prop_generator_02a'
		},
		client = {
			export = "grvsc_faction.prop_generator_02a"
		}
	},
	['prop_generator_04'] = {
		label = 'Générateur Niveau 3',
		description = 'Puissance: 1400W | Réservoir: 25L (0.95L/H)',
		metadata = {
			placable = true,
			generator = {
				watt =  1400, -- Énergie fournie
				maxfuel = 25, -- Réservoir d'essence en L
				consum = 0.95, -- consommation par heure
			},
			name = 'prop_generator_04'
		},
		client = {
			export = "grvsc_faction.prop_generator_04"
		}
	},

	-- 	█████  ██    ██ ████████ ██████  ███████     ██ ████████ ███████ ███    ███ ███████ 
	-- ██   ██ ██    ██    ██    ██   ██ ██          ██    ██    ██      ████  ████ ██      
	-- ███████ ██    ██    ██    ██████  █████       ██    ██    █████   ██ ████ ██ ███████ 
	-- ██   ██ ██    ██    ██    ██   ██ ██          ██    ██    ██      ██  ██  ██      ██ 
	-- ██   ██  ██████     ██    ██   ██ ███████     ██    ██    ███████ ██      ██ ███████ 
	-- --- TRACTAGE --- --
	['kq_tow_rope'] = {
		label = 'Corde de remorquage',
	},
	['kq_winch'] = {
		label = 'Treuil',
	},

}
