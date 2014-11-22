chemistry = {}

minetest.register_node("chemistry:oil_source", {
	description = "Oil Source",
	inventory_image = minetest.inventorycube("chemistry_oil.png"),
	drawtype = "liquid",
	tiles = {
		{name="chemistry_oil_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name="chemistry_oil_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
			backface_culling = false,
		}
	},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:oil_flowing",
	liquid_alternative_source = "chemistry:oil_source",
	liquid_viscosity = WATER_VISC + 10,
	post_effect_color = {a=64, r=200, g=200, b=200},
	groups = {liquid=3, flammable=3},
})

minetest.register_node("chemistry:oil_flowing", {
	description = "Flowing Oil",
	inventory_image = minetest.inventorycube("chemistry_oil.png"),
	drawtype = "flowingliquid",
	tiles = {"chemistry_oil.png"},
	special_tiles = {
		{
			image="chemistry_oil_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="chemistry_oil_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:oil_flowing",
	liquid_alternative_source = "chemistry:oil_source",
	liquid_viscosity = WATER_VISC + 10,
	post_effect_color = {a=64, r=200, g=200, b=200},
	groups = {liquid=3, not_in_creative_inventory=1, flammable=3},
})

bucket.register_liquid(
	"chemistry:oil_source",
	"chemistry:oil_flowing",
	"chemistry:bucket_oil",
	"bucket_oil.png",
	"Oil Bucket"
)

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:oil_source",
	wherein        = "default:desert_stone",
	clust_scarcity = 7*7*7,
	clust_num_ores = 5,
	clust_size     = 3,
	height_min     = 0,
	height_max     = 10,
})

minetest.register_craftitem("chemistry:herbal_medicine", {
	description = "Herbal Medicine",
	inventory_image = "chemistry_medicine1.png",
	on_use = minetest.item_eat(6,"vessels:glass_bottle"),
})

minetest.register_craft({
	output = "chemistry:herbal_medicine",
	recipe = {{"default:leaves","default:apple","flowers:viola"},
			{"","vessels:glass_bottle",""}
	}
})

minetest.register_node("chemistry:plastic_block",{
	tiles = {"chemistry_plastic_block.png"},
	description = "Plastic Block",
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky=1},
})

minetest.register_craft({
	type = "cooking",
	output = "chemistry:bucket_plastic",
	recipe = "chemistry:bucket_oil",
})

minetest.register_craft({
	output = 'chemistry:plastic_block 30',
	recipe = {{"chemistry:bucket_plastic"}},
	replacements = {
		{"chemistry:bucket_plastic", "bucket:bucket_empty"}
	},
})

minetest.register_craftitem("chemistry:bucket_plastic", {
	description = "Bucket with Plastic",
	inventory_image = "chemistry_plasticbucket.png",
})

minetest.register_node("chemistry:chair",{
	description = "Plastic Chair",
	tiles = {"chemistry_plastic_block.png"},
	inventory_image = "chemistry_plastic_chair.png",
	paramtype = "light",
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.1, -0.5, 0.5, 0, 0.5},
			{-0.5, -0.1, 0.5, 0.5, 1, 0.4},
			{-0.5, -0.5, -0.5, -0.4, 0, -0.4},
			{0.5, -0.5, 0.5, 0.4, 0, 0.4},
			{-0.5, -0.5, 0.5, -0.4, 0, 0.4},
			{0.5, -0.5, -0.5, 0.4, 0, -0.4},
		},
	},
	groups = {cracky=1}, 
})

minetest.register_node("chemistry:toilet",{
	description = "Plastic Toilet?",
	tiles = {"chemistry_plastic_block.png"},
	inventory_image = "chemistry_plastic_toilet.png",
	paramtype = "light",
	drawtype = "nodebox",
	paramtype2 = "facedir",
	groups = {cracky=1}, 
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.5, -0.5, 0, 0.5},
			{0.4, -0.5, -0.5, -0.5, 0, -0.4},
			{0.5, -0.5, 0.5, 0.4, 0, -0.5},
			{0.5, -0.4, 0.5, -0.5, -0.5, -0.5},
			{-0.5, -0.5, 0.5, 0.5, 1, 0.4},
		},
	},
	mesecons = {effector = { -- play sound when activated
		action_on = function (pos, node)
				minetest.sound_play("flush",{pos = pos, gain = 1.0, max_hear_distance = 32,})
		end
	}}
})

minetest.register_node("chemistry:sink",{
	description = "Plastic Sink",
	tiles = {"chemistry_plastic_block.png"},
	inventory_image = "chemistry_plastic_sink.png",
	paramtype = "light",
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4, 0.5, -0.2, 0.4, 0.4, 0.5},
			{-0.05, 0.6, -0, 0.05, 0.7, 0.5},
			{-0.05, 0.5, 0.4, 0.05, 0.7, 0.5},
			{-0.2, 0.5, 0.4, -0.25, 0.7, 0.5},
			{0.2, 0.5, 0.4, 0.25, 0.7, 0.5},
		},
	},
	groups = {cracky=1}, 
})

minetest.register_node("chemistry:table",{
	description = "Plastic Table",
	tiles = {"chemistry_plastic_block.png"},
	inventory_image = "chemistry_plastic_table.png",
	paramtype = "light",
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.5, -0.5, 0.5, 0.4, 0.5},
			{-0.5, 0.5, -0.5, -0.3, -0.5, -0.3},
			{0.5, 0.5, -0.5, 0.3, -0.5, -0.3},
			{0.5, 0.5, 0.5, 0.3, -0.5, 0.3},
			{-0.5, 0.5, 0.5, -0.3, -0.5, 0.3},
		},
	},
	groups = {cracky=1}, 
})

minetest.register_craftitem("chemistry:plastic_stick", {
	description = "Plastic Stick",
	inventory_image = "chemistry_plastic_stick.png",
})

-- Plastics Crafting --

minetest.register_craft({
	output = "chemistry:plastic_stick 4",
	recipe = {{"chemistry:plastic_block"}},
})

minetest.register_craft({
	output = "chemistry:chair 2",
	recipe = {{"chemistry:plastic_block",""},
			{"chemistry:plastic_block","chemistry:plastic_block"},
			{"chemistry:plastic_stick","chemistry:plastic_stick"}
	}
})

minetest.register_craft({
	output = "chemistry:toilet 2",
	recipe = {{"chemistry:plastic_block",""},
			{"chemistry:plastic_block",""},
			{"chemistry:plastic_block","chemistry:plastic_block"}
	}
})

minetest.register_craft({
	output = "chemistry:sink 2",
	recipe = {{"chemistry:plastic_stick"},
			{"chemistry:plastic_block"},
	}
})

minetest.register_craft({
	output = "chemistry:table 2",
	recipe = {{"chemistry:plastic_block","chemistry:plastic_block","chemistry:plastic_block"},
			{"chemistry:plastic_stick","","chemistry:plastic_stick"},
			{"chemistry:plastic_stick","","chemistry:plastic_stick"}
	}
})

-- Synthetic Medicine --

minetest.register_craftitem("chemistry:raw_synthetic_medicine", {
	description = "Raw Synthetic Medicine",
	inventory_image = "chemistry_medicine2.png",
	stack_max = 2,
})

minetest.register_craftitem("chemistry:bottle_oil", {
	description = "Bottle with Oil",
	inventory_image = "chemistry_oilbottle.png",
})

minetest.register_craftitem("chemistry:apple_juice", {
	description = "Apple Juice/Flavoring",
	inventory_image = "chemistry_apple_juice.png",
	on_use = minetest.item_eat(2,"vessels:glass_bottle"),
})

minetest.register_craftitem("chemistry:synthetic_medicine", {
	description = "Synthetic Pill",
	inventory_image = "chemistry_medicine3.png",
	on_use = minetest.item_eat(10),
})

minetest.register_craft({
	type = "shapeless",
	output = 'chemistry:bottle_oil 3',
	recipe = {"chemistry:bucket_oil","vessels:glass_bottle","vessels:glass_bottle","vessels:glass_bottle"},
	replacements = {
		{"chemistry:bucket_oil", "bucket:bucket_empty"},
	},
})

minetest.register_craft({
	type = "shapeless",
	output = 'chemistry:raw_synthetic_medicine 2',
	recipe = {"chemistry:apple_juice","chemistry:bottle_oil"},
})

minetest.register_craft({
	type = "shapeless",
	output = 'chemistry:apple_juice',
	recipe = {"vessels:glass_bottle","default:apple"},
})

minetest.register_craft({
	type = "shapeless",
	output = 'chemistry:synthetic_medicine 4',
	recipe = {"chemistry:raw_synthetic_medicine","chemistry:raw_synthetic_medicine"},
	replacements = {
		{"chemistry:raw_synthetic_medicine","vessels:glass_bottle"},
		{"chemistry:raw_synthetic_medicine","vessels:glass_bottle"},
	},
})

minetest.register_abm({
	nodenames = {"default:dirt_with_grass"},
	neighbors = {"default:water_source"},
	interval = 20,
	chance = 100,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name == "air" then
			minetest.set_node(above, {name = "chemistry:mushroom1"})
		end
	end
})

minetest.register_abm({
	nodenames = {"chemistry:mushroom1"},
	interval = 10,
	chance = 1,
	action = function(pos, node)
		if not minetest.find_node_near(pos, 3, {"group:water"}) then
			minetest.set_node(pos, {name = "air"})
		end
	end
})

minetest.register_node("chemistry:mushroom1", {
	description = "Brown Mushroom",
	drawtype = "plantlike",
	tiles = {"chemistry_mushroom1.png"},
	inventory_image = "chemistry_mushroom1.png",
	wield_image = "chemistry_mushroom1.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:mushroom1",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:bucket_oil",
	burntime = 60,
	replacements = {{"chemistry:bucket_oil", "bucket:bucket_empty"}},
})

function fertilize(pointed_thing)
	pos = pointed_thing.under
	node = minetest.env:get_node(pos)
	if string.find(node.name, "farming:wheat_") ~= nil then
		minetest.env:set_node(pos,{name="farming:wheat_8"})
	elseif string.find(node.name, "farming:cotton_") ~= nil then
		minetest.env:set_node(pos,{name="farming:cotton_8"})
	-- Farming Plus Support!
	elseif string.find(node.name, "farming_plus:pumpkin_") ~= nil then
		minetest.env:set_node(pos,{name="farming_plus:pumpkin"})
	elseif string.find(node.name, "farming_plus:rhubarb_") ~= nil then
		minetest.env:set_node(pos,{name="farming_plus:rhubarb"})
	elseif string.find(node.name, "farming_plus:strawberry_") ~= nil then
		minetest.env:set_node(pos,{name="farming_plus:strawberry"})
	elseif string.find(node.name, "farming_plus:tomato_") ~= nil then
		minetest.env:set_node(pos,{name="farming_plus:tomato"})
	elseif string.find(node.name, "farming_plus:potato_") ~= nil then
		minetest.env:set_node(pos,{name="farming_plus:potato"})
	elseif string.find(node.name, "farming_plus:orange_") ~= nil then
		minetest.env:set_node(pos,{name="farming_plus:orange"})
	elseif string.find(node.name, "farming_plus:carrot_") ~= nil then
		minetest.env:set_node(pos,{name="farming_plus:carrot"})
	elseif node.name == "default:sapling" then
		treetop = math.random(3,6)
		for lx = -2,2 do
			for lz = -2,2 do
				for ly = treetop-1,treetop+2 do
					lpos = {x=pos.x+lx,y=pos.y+ly,z=pos.z+lz,}
					if math.random(1,10) == 10 then
						minetest.set_node(lpos,{name="default:apple"})
					else
						minetest.set_node(lpos,{name="default:leaves"})
					end
				end
			end
		end
		for i = 0,treetop do
			treepos = {x=pos.x,y=pos.y+i,z=pos.z}
			minetest.set_node(treepos,{name="default:tree"})
		end
	elseif node.name == "default:junglesapling" then
		treetop = math.random(6,10)
		for lx = -2,2 do
			for lz = -2,2 do
				for ly = treetop-1,treetop+2 do
					lpos = {x=pos.x+lx,y=pos.y+ly,z=pos.z+lz,}
					minetest.set_node(lpos,{name="default:jungleleaves"})
				end
			end
		end
		for i = 0,treetop do
			treepos = {x=pos.x,y=pos.y+i,z=pos.z}
			minetest.set_node(treepos,{name="default:jungletree"})
		end
		for rx = -1,1 do
			for rz = -1,1 do
				rootpos = {x=pos.x+rx,y=pos.y,z=pos.z+rz}
				if math.random(1,2) == 2 then
					minetest.set_node(rootpos,{name="default:jungletree"})
				end
			end
		end
	-- And now, farming plus trees!
	elseif node.name == "farming_plus:cocoa_sapling" then
		treetop = math.random(3,6)
		for lx = -2,2 do
			for lz = -2,2 do
				for ly = treetop-1,treetop+2 do
					lpos = {x=pos.x+lx,y=pos.y+ly,z=pos.z+lz,}
					if math.random(1,10) == 10 then
						minetest.set_node(lpos,{name="farming_plus:cocoa"})
					else
						minetest.set_node(lpos,{name="farming_plus:cocoa_leaves"})
					end
				end
			end
		end
		for i = 0,treetop do
			treepos = {x=pos.x,y=pos.y+i,z=pos.z}
			minetest.set_node(treepos,{name="default:tree"})
		end
	elseif node.name == "farming_plus:banana_sapling" then
		treetop = math.random(3,6)
		for lx = -2,2 do
			for lz = -2,2 do
				for ly = treetop-1,treetop+2 do
					lpos = {x=pos.x+lx,y=pos.y+ly,z=pos.z+lz,}
					if math.random(1,10) == 10 then
						minetest.set_node(lpos,{name="farming_plus:banana"})
					else
						minetest.set_node(lpos,{name="farming_plus:banana_leaves"})
					end
				end
			end
		end
		for i = 0,treetop do
			treepos = {x=pos.x,y=pos.y+i,z=pos.z}
			minetest.set_node(treepos,{name="default:tree"})
		end
	end
end


minetest.register_craftitem("chemistry:fertilizer", {
	description = "Synthetic Fertilizer",
	inventory_image = "chemistry_bottletan.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			local inv = user:get_inventory()
			fertilize(pointed_thing)
			itemstack:take_item()
			if inv:room_for_item("main", {name="vessels:glass_bottle", count=1, wear=0, metadata=""}) then
				inv:add_item("main", {name="vessels:glass_bottle", count=1, wear=0, metadata=""})
			end
			return itemstack
		end
	end,
})

minetest.register_craft({
	type = "shapeless",
	output = 'chemistry:fertilizer 2',
	recipe = {"vessels:glass_bottle","chemistry:bottle_oil","default:dirt","default:papyrus"},
})

-- Alchemy

-- In the minetest world, blocks are made of molecules made of letters.
-- You remove the letters from the chemicals, and add new ones.

minetest.register_craftitem("chemistry:letter_remover", {
	description = "Letter Remover",
	inventory_image = "chemistry_bottlebrown.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:letter_remover",
	recipe = {"chemistry:mushroom1","vessels:glass_bottle"},
})

minetest.register_craftitem("chemistry:raw_letter_adder", {
	description = "Letter Adder (Raw)",
	inventory_image = "chemistry_bottleorange.png",
})

-- Mysterious mushrooms, eh?

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:raw_letter_adder",
	recipe = {"chemistry:mushroom1","chemistry:mushroom1","vessels:glass_bottle"},
})

minetest.register_craftitem("chemistry:molten", {
	description = "Molten (Blank)",
	inventory_image = "chemistry_bottlecyan.png",
})

-- Gold
minetest.register_craftitem("chemistry:molten_gold", {
	description = "Molten Gold",
	inventory_image = "chemistry_bottlegold.png",
})

minetest.register_craft({
	output = "default:gold_ingot",
	recipe = {{"chemistry:molten_gold"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:gold",
	recipe = {"default:gold_lump","vessels:glass_bottle"},
})

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:gold",
	recipe = {"default:gold_ingot","vessels:glass_bottle"},
})

minetest.register_craft({
	type = "cooking",
	output = "chemistry:molten_gold",
	recipe = "chemistry:gold",
})

minetest.register_craftitem("chemistry:gold", {
	description = "Gold in a bottle",
	inventory_image = "chemistry_bottlegold.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:molten 5",
	recipe = {"chemistry:letter_remover","chemistry:letter_remover","chemistry:letter_remover","chemistry:letter_remover","chemistry:molten_gold"},
})

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:molten_gold 5",
	recipe = {"chemistry:molten","chemistry:letter_adder_g","chemistry:letter_adder_o","chemistry:letter_adder_l","chemistry:letter_adder_d"},
})

-- Letter Adders

l = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","a"}

for i = 1,26 do
	minetest.register_craftitem("chemistry:letter_adder_" ..l[i], {
		description = "Letter Adder (" ..l[i].. ")",
		inventory_image = "chemistry_bottlered.png",
		groups = {not_in_creative_inventory=1},
	})
	minetest.register_craft({
		output = "chemistry:letter_adder_" ..l[i+1],
		recipe = {{"chemistry:letter_adder_" ..l[i]}},
	})
end

minetest.register_craft({
	output = "chemistry:letter_adder_a",
	recipe = {{"chemistry:raw_letter_adder"}},
})		
		
-- Mese

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:molten_mese 5",
	recipe = {"chemistry:molten","chemistry:letter_adder_m","chemistry:letter_adder_e","chemistry:letter_adder_s","chemistry:letter_adder_e"},
})

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:molten 5",
	recipe = {"chemistry:molten_mese","chemistry:letter_remover","chemistry:letter_remover","chemistry:letter_remover","chemistry:letter_remover"},
})

minetest.register_craftitem("chemistry:molten_mese",{
	description = "Molten Mese",
	inventory_image = "chemistry_bottleyellow.png",
})

minetest.register_craft({
	output = "default:mese_crystal",
	recipe = {{"chemistry:molten_mese"}},
	replacements = {
		{"chemistry:molten_mese","vessels:glass_bottle"},
	}
})

minetest.register_craftitem("chemistry:mese", {
	description = "Mese in a bottle",
	inventory_image = "chemistry_bottleyellow.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:mese",
	recipe = {"default:mese_crystal","vessels:glass_bottle"},
})

minetest.register_craft({
	type = "cooking",
	output = "chemistry:molten_mese",
	recipe = "chemistry:mese",
})

-- Diamond

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:molten_diamond 8",
	recipe = {"chemistry:molten","chemistry:letter_adder_d","chemistry:letter_adder_i","chemistry:letter_adder_a","chemistry:letter_adder_m","chemistry:letter_adder_o","chemistry:letter_adder_n","chemistry:letter_adder_d"},
})

minetest.register_craftitem("chemistry:molten_diamond",{
	description = "Molten Diamond",
	inventory_image = "chemistry_bottleblue.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:molten 8",
	recipe = {"chemistry:molten_diamond","chemistry:letter_remover","chemistry:letter_remover","chemistry:letter_remover","chemistry:letter_remover","chemistry:letter_remover","chemistry:letter_remover","chemistry:letter_remover"},
})

minetest.register_craft({
	output = "default:diamond",
	recipe = {{"chemistry:molten_diamond"}},
	replacements = {
		{"chemistry:molten_diamond","vessels:glass_bottle"},
	}
})

minetest.register_craftitem("chemistry:diamond", {
	description = "Diamond in a bottle",
	inventory_image = "chemistry_bottleblue.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "chemistry:diamond",
	recipe = {"default:diamond","vessels:glass_bottle"},
})

minetest.register_craft({
	type = "cooking",
	output = "chemistry:molten_diamond",
	recipe = "chemistry:diamond",
})

-- For any more of these, here is a function for shortness:

function chemistry:alchemitize(name,material,description,bottlecolor)
	minetest.register_craft({
		output = "default:" ..material,
		recipe = {{"chemistry:molten_"..name}},
		replacements = {
			{"chemistry:molten_"..name,"vessels:glass_bottle"},
		}
	})

	minetest.register_craftitem("chemistry:"..material, {
		description = description.. " in a bottle",
		inventory_image = "chemistry_bottle"..bottlecolor..".png",
	})

	minetest.register_craft({
		type = "shapeless",
		output = "chemistry:"..material,
		recipe = {"default:"..material,"vessels:glass_bottle"},
	})

	minetest.register_craft({
		type = "cooking",
		output = "chemistry:molten_"..name,
		recipe = "chemistry:"..material,
	})

	minetest.register_craftitem("chemistry:molten_"..name,{
		description = "Molten " ..description,
		inventory_image = "chemistry_bottle"..bottlecolor..".png",
	})
end

-- The recipes to make the molten blank and molten, whatever, are not here becuase you can use any number of letters.
-- Put your alchemize functions here!




-- But not past here.
-- U is for Uranium!

minetest.register_node("chemistry:stone_with_uranium", {
	description = "Uranium Ore",
	tiles = {"default_stone.png^chemistry_mineral_uranium.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = "chemistry:uranium_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:uranium_lump", {
	description = "Uranium Lump",
	tiles = {"chemistry_uranium.png"},
	inventory_image = "chemistry_uranium_lump.png",
	groups = {cracky=2},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, 0, 0.2},
		},
	},
})

minetest.register_node("chemistry:uranium_block", {
	description = "Uranium Block",
	tiles = {"chemistry_uranium.png"},
	groups = {cracky=2},
})

minetest.register_node("chemistry:mineral_detector", {
	description = "Mineral Detector",
	tiles = {"default_wood.png^chemistry_uranium_lump.png"},
	groups = {crumbly=3},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		mesetable = minetest.find_nodes_in_area({x=pos.x-8,y=pos.y-8,z=pos.z-8},{x=pos.x+8,y=pos.y+8,z=pos.z+8},"default:stone_with_mese")
		diamondtable = minetest.find_nodes_in_area({x=pos.x-8,y=pos.y-8,z=pos.z-8},{x=pos.x+8,y=pos.y+8,z=pos.z+8},"default:stone_with_diamond")
		meta:set_string("infotext", "Mese at "..tostring(dump(mesetable)).." Diamond at "..tostring(dump(diamondtable)))
	end,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "chemistry:uranium_block",
	recipe = {{"chemistry:uranium_lump","chemistry:uranium_lump","chemistry:uranium_lump"},
			{"chemistry:uranium_lump","chemistry:uranium_lump","chemistry:uranium_lump"},
			{"chemistry:uranium_lump","chemistry:uranium_lump","chemistry:uranium_lump"}
	}
})

minetest.register_craft({
	output = "chemistry:mineral_detector",
	recipe = {{"default:wood","default:wood","default:wood"},
			{"default:wood","chemistry:uranium_block","default:wood"},
			{"default:wood","default:wood","default:wood"}
	}
})

for i = 1,5 do
	minetest.register_abm({
		nodenames = {"default:grass_" ..i},
		interval = 2,
		chance = 1,
		action = function(pos, node)
			if minetest.find_node_near(pos, 5, {"chemistry:uranium_lump"}) then
				minetest.set_node(pos, {name = "air"})
			end
		end
	})
end

minetest.register_abm({
	nodenames = {"flowers:rose"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		if minetest.find_node_near(pos, 5, {"chemistry:uranium_lump"}) then
			minetest.set_node(pos, {name = "air"})
		end
	end
})

minetest.register_abm({
	nodenames = {"flowers:dandelion_white"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		if minetest.find_node_near(pos, 5, {"chemistry:uranium_lump"}) then
			minetest.set_node(pos, {name = "air"})
		end
	end
})

minetest.register_abm({
	nodenames = {"flowers:viola"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		if minetest.find_node_near(pos, 5, {"chemistry:uranium_lump"}) then
			minetest.set_node(pos, {name = "air"})
		end
	end
})

minetest.register_abm({
	nodenames = {"flowers:dandelion_yellow"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		if minetest.find_node_near(pos, 5, {"chemistry:uranium_lump"}) then
			minetest.set_node(pos, {name = "air"})
		end
	end
})

minetest.register_abm({
	nodenames = {"flowers:geranium"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		if minetest.find_node_near(pos, 5, {"chemistry:uranium_lump"}) then
			minetest.set_node(pos, {name = "air"})
		end
	end
})

minetest.register_abm({
	nodenames = {"flowers:tulip"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		if minetest.find_node_near(pos, 5, {"chemistry:uranium_lump"}) then
			minetest.set_node(pos, {name = "air"})
		end
	end
})

minetest.register_abm({
	nodenames = {"flowers:junglegrass"},
	interval = 5,
	chance = 2,
	action = function(pos, node)
		if minetest.find_node_near(pos, 5, {"chemistry:uranium_lump"}) then
			minetest.set_node(pos, {name = "air"})
		end
	end
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_uranium",
	wherein        = "default:stone",
	clust_scarcity = 10*10*10,
	clust_num_ores = 5,
	clust_size     = 7,
	height_min     = -31000,
	height_max     = -50,
})
