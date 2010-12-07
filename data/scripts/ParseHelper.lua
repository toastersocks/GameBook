print ("Running helper script...")

assert( require "printT" )
assert( require "parseOption" )

section = {}
--section.left = nil
--section.right = nil
--section.spread = nil

spread = {}
left = {}
right = {}
	

------------ LEFT --------------
---TEXT---

left["text"] = function (pageText)
	if section.left == nil then
		section["left"] = {}
	end
	section.left["text"] = pageText
end

left["option"] = function (newOption)
	if section.left == nil then
		section["left"] = {}
	end
	if section.left.options == nil then
		section.left["options"] = {}
	end
	
	table.insert(section.left.options, parseOption(newOption))
	
end

---IMAGE---
left["baseImage"] = function (pageImage)
	if section.left == nil then
		section["left"] = {}
	end
	section.left["baseImage"] = UIImage:imageWithContentsOfFile(NSBundle:mainBundle():pathForResource_ofType(pageImage, "png"))
end

-- touchable? sceneObject? object?
left["touchable"] = function (newTouchable)
	if section.left == nil then
		section["left"] = {}
	end
	if section.left.touchables == nil then
		section.left["touchables"] = {}
	end
	--load
	table.insert(section.left.touchables, parseTouchable(newTouchable))
end
	
	







---------- RIGHT -------------
---TEXT---

right["text"] = function (sectionText)
	if section.right == nil then
		section["right"] = {}
	end
	section.right["text"] = sectionText
end

right["option"] = function (newOption)
	if section.right == nil then
		section["right"] = {}
	end
	if section.right.options == nil then
		section.right["options"] = {}
	end
		
	table.insert(section.right.options, parseOption(newOption))
	
end


---IMAGE---
right["baseImage"] = function (pageImage)
	if section.right == nil then
		section["right"] = {}
	end
	section.right["baseImage"] = UIImage:imageWithContentsOfFile(NSBundle:mainBundle():pathForResource_ofType(pageImage, "png"))
end

-- touchable? sceneObject? object?
right["touchable"] = function (newTouchable)
	if section.right == nil then
		section["right"] = {}
	end
	if section.right.touchables == nil then
		section.right["touchables"] = {}
	end
	table.insert(section.right.touchables, parseTouchable(newTouchable))
end




---------- SPREAD -----------
spread["baseImage"] = function (pageImage)
	if section.spread == nil then
		section["spread"] = {}
	end
	section.spread["baseImage"] = UIImage:imageWithContentsOfFile(NSBundle:mainBundle():pathForResource_ofType(pageImage, "png"))
end

-- touchable? sceneObject? object?
spread["touchable"] = function (newTouchable)
	if section.spread == nil then
		section["spread"] = {}
	end
	if section.spread.touchables == nil then
		section.spread["touchables"] = {}
	end
	table.insert(section.spread.touchables, parseTouchable(newTouchable))
end





dofile(sectionIndex)

--print "The section from lua: \n"
--printT(section)

--testTouchable = {





--[[

right.text "This is the main section text"
right.option {"go outside", "load outside_section", "log went_outside", "log used_superplooper"}
right.option {"watch tv", "load tv_section", "log watched_tv"}
left.baseImage "image"
left.touchable {"bird", 50, 50, "pop old_banana", "log looked_at_old_banana_westforrest"}
left.touchable {"fruit", 50, 75, "pop other_object_name", "log key_event_whathaveyou"}
left.touchable {"deer", 50, 75, "pop old_banana", "log saw_old_banana"}



--spread.baseImage "base_spread_image"
spread.touchable {"sprite3", 30, 20, "load yet_another_object", "log yo momma"} --maybe better to put "sprite" in the gameObject file along with the name/description and what-not. well, maybe not, since the stuff in the gameObject file doesn't get loaded until the player touches an object. Although, maybe it would be better to load all the info for all the objects in the scene... MAYBE INDEED
--so the touchable would be like so: spread.touchable {object_name, 30, 20, "log whatever"} so all the info about the touchables would have to be loaded and added to a touchable object (dictionary)
--touchables = { {sprite="sprite3", 

printT(section)

print(section.left.touchables[3].logs[1])
--]]
--[[

function mainText (sectionText)

	section.left["text"] = sectionText
end

--]]