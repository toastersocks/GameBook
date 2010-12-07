--functions to read the game object chunks and create the gameObject dictionary objects when needed

require "printT"
require "parseOption"

print "Running the objectHelper"

objectList = assert(loadfile("gameObjectList.lua"))
--print ("gameObjectList.lua")

objectList()

sceneObject ={}


sprite = function (objectSprite)
	sceneObject["objectSprite"] = UIImage:imageWithContentsOfFile(NSBundle:mainBundle():pathForResource_ofType(objectSprite, "png"))
end


name = function (objectName)
	print "getting the object name"
	sceneObject["name"] = objectName
end


description = function (objectDescripton)
	print "getting object description"
	sceneObject["text"] = objectDescripton
end




popupOption = function (newPopupOption)
	if sceneObject.options == nil then
		sceneObject["options"] = {}
	end
		
	table.insert(sceneObject.options, parseOption(newPopupOption))
	
end
print (objectIndex)

print (shadow)
objectToFetch = _G[objectIndex]
print(objectToFetch)

fetchedObject = assert( loadstring(objectToFetch) )

fetchedObject()

--touchedObject = old_banana_westforrest
--fetchedObject = loadstring(touchedObject)
--printT(sceneObject)
