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
	" an abandonned mayan temple, where 2 giants appeared, \n"
	.. "so he had to fight them off! Luckily, \n" 
	.. "he knows how to shoot lasers with his eyes!", 500, 100, nil, 35)

-- set the colour of the text
text1:setTextColor( 247/255, 60/255, 22/255 )

-- create the second character
local robloxCharlotte = display.newImageRect("Images/robloxcharlotte.png", 300, 300 )

-- set the location of the character
robloxCharlotte.x = 150
robloxCharlotte.y = 0

-- make the image transparent
robloxCharlotte.alpha = 0

-- make a second scroll speed
scrollSpeed2 = 10

-- function: MoveCharlotte
-- input: this function accepts an event listener
-- output: none
-- description: this function adds the scroll speed to the y-value of the character
local function MoveCharlotte(event)
	-- add the scroll speed to the x value of robloxPrisonMike
	robloxCharlotte.y = robloxCharlotte.y + scrollSpeed2
	-- change the transparency of robloxPrisonMike every time it moves so that it fades input
	robloxCharlotte.alpha = robloxCharlotte.alpha + 0.02
	if (robloxCharlotte.y >= 475) then
		scrollSpeed2 = 0
	end
end

-- MoveCharlotte will be called over and over again
Runtime:addEventListener("enterFrame", MoveCharlotte)

-- flip the character horizontally
robloxCharlotte:scale(-1,1)

-- create the third character
local robloxPeter = display.newImageRect("Images/robloxpetergriffin.png", 300, 300 )

-- set the location of the character
robloxPeter.x = 400
robloxPeter.y = 800

--make the image transparent
robloxPeter.alpha = 0

-- flip the character horizontally
robloxPeter:scale(-1,1)

-- set the scroll speed
scrollSpeed3 = -10

-- function: MovePeter
-- input: this function accepts an event listener
-- output: none
-- description: this function adds the scroll speed to the y-value of the character
local function MovePeter(event)
	-- add the scroll speed to the x value of robloxPrisonMike
	robloxPeter.y = robloxPeter.y + scrollSpeed3
	-- change the transparency of robloxPrisonMike every time it moves so that it fades input
	robloxPeter.alpha = robloxPeter.alpha + 0.02
	if (robloxPeter.y <= 475) then
		scrollSpeed3 = 0
	end
end

-- MovePeter will be called over and over again
Runtime:addEventListener("enterFrame", MovePeter)

-- create the laser
local laser = display.newRect( 610, 400, 350, 10)

-- change the colour of the laser
laser:setFillColor(1, 0, 0)

-- make the laser invisible
laser.alpha = 0

-- function: ShootLaser
-- input: this function accepts an event listener
-- output: none
-- description: this function makes the laser appear
local function ShootLaser(event)
	if (robloxPrisonMike.x <= 800) then
		laser.alpha = 1
	end
end

Runtime:addEventListener("enterFrame", ShootLaser)

local function StopLaser(event)
	if (laser.alpha == 1) then
		laser.alpha = laser.alpa
	end
end

Runtime:addEventListener("enterFrame", StopLaser)