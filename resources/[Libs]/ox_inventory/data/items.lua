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

	-- 	█████  ██    ██ ████████ ██████  ███████     ██ ████████ ███████ ███    ███ ███████ 
	-- ██   ██ ██    ██    ██    ██   ██ ██          ██    ██    ██      ████  ████ ██      
	-- ███████ ██    ██    ██    ██████  █████       ██    ██    █████   ██ ████ ██ ███████ 
	-- ██   ██ ██    ██    ██    ██   ██ ██          ██    ██    ██      ██  ██  ██      ██ 
	-- ██   ██  ██████     ██    ██   ██ ███████     ██    ██    ███████ ██      ██ ███████ 
	['kq_tow_rope'] = {
		label = 'Corde de remorquage',
	},
	['kq_winch'] = {
		label = 'Treuil',
	},

}
