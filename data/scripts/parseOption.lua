local tempOption = {}

function parseOption(optionToParse)
	tempOption = {}
	tempOption["optionText"]=table.remove(optionToParse, 1)
	return parseActions(optionToParse)
end


function parseTouchable(optionToParse)
	tempOption = {}
	tempOption["sceneSprite"] = UIImage:imageWithContentsOfFile(NSBundle:mainBundle():pathForResource_ofType(table.remove(optionToParse, 1), "png"))
	
	--[UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: [self.section valueForKey:@"baseImage"] 
	--																					ofType:@"png"]];
	
	tempOption["position"] = {x=optionToParse[1] / 100, y=optionToParse[2] / 100}
	--tempOption["position"]=CGPoint(optionToParse[1] / 100, optionToParse[2] / 100) -- can't store structs directly in dictionaries...
	table.remove(optionToParse, 1)
	table.remove(optionToParse, 1)
	return parseActions(optionToParse)

end


function parseActions(actions)
	for key, value in ipairs(actions) do
		
		if string.find(value, "^log .+") then
			if not tempOption["logs"] then
				tempOption["logs"] = {}
			end
			
		table.insert(tempOption.logs, select(3, string.find(value, "^log (.+)")))
		
		elseif string.find(value, "^load .+") then
			tempOption["load"] = select(3, string.find(value, "^load (.+)"))
			
		elseif string.find(value, "^pop .+") then
			tempOption["pop"] = select(3, string.find(value, "^pop (.+)"))


			
		end
	end
	return tempOption
end
