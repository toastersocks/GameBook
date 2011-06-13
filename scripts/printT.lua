function printT(thingToBePrinted)
	if type(thingToBePrinted) ~= 'table' then
		print (thingToBePrinted)
	else
		for key, value in pairs(thingToBePrinted) do
			print(key, value)
			if type(value) == 'table' then
				printT(value)
			end
		end
	end
		
end



--testTable = {{"1st table, 1st value", "1st table, second value"},{"2nd table, 1st value", "2nd table, 2nd value"}, "hanging string", 4}
--
--printT(testTable)