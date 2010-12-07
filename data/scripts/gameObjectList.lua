-- sprites are defined here AND in the section file. this one goes into the database, the other one gets displayed in the scene. usually they are the same, but can be different. ie a clear sprite for the scene, but a sprite cropped from the base image for the database for instance

-- there's a variety of ways to do the various things you might want to do here. very flexible. JUST ASK!
print "Running the object list"

-- the name before the equals is the script name for the object. this is what you would would tell the parser to 'pop' in the section file
fruity_pinecone_moldy =[[ -- an informative popup
sprite "fruity_pinecone" --the object sprite
name "Moldy Pinecone" --the object_name gets stored in the datebase/inventory. the 'name' property is what the player actually sees when they look at the the datebase/inventory, and when they click the name in the database they see the 'description'
description "A pinecone. It's pretty moldy"
]]

fruity_pinecone_healthy =[[ -- an informative popup
sprite "fruit"
name "Pinecone" --the object_name gets stored in the datebase/inventory. the 'name' property is what the player actually sees when they look at the the datebase/inventory, and when they click the name in the database they see the 'description'
description "A Pinecone."
popupOption{"Kick it", "log kicked_pinecone"}
]]

old_banana_westforrest = [[ -- a popup as an item that can be taken

sprite "banana" -- the sprite a player would see in their database/inventory

name "Old Banana" -- the name a player would see in their database/inventory

description "A banana that is just right for eating. Too bad you are a robot. You picked it up in the west forrest" -- same as above

popupOption {"Take it", "log item old_banana_westforrest", "log took_old_banana"}
popupOption {"Step on it", "log broken arm", "log slipped_on_banana"} -- the popups are dismissed by touching outside of them so probably not much reason to have more than one option in these popups, but you can if you want.
]]

secret_spaceport_door = [[ -- a popup that can load a new section
sprite "spaceportBoulder"
name "boulder"
description "You moved the rock and found an entrance to the port. The interior is dark. The relative humidity is 28% higher than outside."
popupOption{"Go inside", "load port_inside_secretentrance", "log used_secret_entrance"}
]]


bird = [[
name "Small Bird"
sprite "bird"
description "It's a really small bird"
popupOption{"Take it", "log took bird"}

]]



shadow = [[
sprite "silhouette2"
name "Tree Shadow"
description "It's the shadow of a tree. Is it even real?"
]]

