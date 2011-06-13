file = assert(io.open("prologue.txt", "r"))
prologue = file:read("*all")
--prologue = io.read("*all")
displayText = ""



for char in prologue:gmatch(".") do
	if char == "\n" or char == "." then
	--	os.execute("sleep .5")
	else
	--	os.execute("sleep .01")
	end
	
	--os.execute("clear")
	displayText = displayText..char
	print (displayText.."▍")
end
	
--print (prologue)
--▮▮❚❚∎┃┃██