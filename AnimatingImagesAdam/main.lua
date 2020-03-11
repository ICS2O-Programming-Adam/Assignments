-----------------------------------------------------------------------------------------
-- Title: AnimatingImages 
-- Name: Adam Winogon
-- Course: ICS20/3C
-- Description:
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- set the background image
local backgroundImage = display.newImageRect("Images/background.jpg", 1024, 1000)

-- set the location of the background image
backgroundImage.x = 510
backgroundImage.y = 370

-- create the first character
local robloxPrisonMike = display.newImageRect("images/robloxprisonmike.png", 200, 200)

-- set the location of the character
robloxPrisonMike.x = 1024
robloxPrisonMike.y = 475

--set the image to transparent
robloxPrisonMike.alpha = 0

-- set the scroll speed
scrollSpeed = -3

-- function:MoveMike
-- input: this function accepts an event listener
-- output: none
-- description: this function adds the scroll speed to the x-value of the character
local function MoveMike(event)
	-- add the scroll speed to the x value of robloxPrisonMike
	robloxPrisonMike.x = robloxPrisonMike.x + scrollSpeed
	-- change the transparency of robloxPrisonMike every time it moves so that it fades input
	robloxPrisonMike.alpha = robloxPrisonMike.alpha + 0.01
	if (robloxPrisonMike.x <= 800) then
		scrollSpeed = 0
	end

end

-- MoveMike will be called over and over again
Runtime:addEventListener("enterFrame", MoveMike)

-- display a text box explaining the first part of the story
local text1 = display.newText( "One day, Mike was walking home and stumbled across \n".. 
	" an abandonned mayan temple...", 500, 200, nil, 35)

-- set the colour of the text
text1:setTextColor( 247/255, 60/255, 22/255 )

-- create the second character
local robloxCharlotte = display.newImageRect("Images/robloxcharlotte.png", 300, 300 )

-- set the location of the character
robloxCharlotte.x = 200
robloxCharlotte.y = 0

-- make the image transparent
robloxCharlotte.alpha = 0

-- make a second scroll speed
scrollSpeed2 = 5

-- function: MoveCharlotte
-- input: this function accepts an event listener
-- output: none
-- description: this function adds the scroll speed to the y-value of the character
local function MoveCharlotte(event)
	-- add the scroll speed to the x value of robloxPrisonMike
	robloxCharlotte.y = robloxCharlotte.y + scrollSpeed2
	-- change the transparency of robloxPrisonMike every time it moves so that it fades input
	robloxCharlotte.alpha = robloxCharlotte.alpha + 0.01
	if (robloxCharlotte.y >= 475) then
		scrollSpeed2 = 0
	end
end

-- MoveCharlotte will be called over and over again
Runtime:addEventListener("enterFrame", MoveCharlotte)