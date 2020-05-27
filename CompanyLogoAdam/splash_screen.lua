-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Adam Winogron
-- Date: May 26, 2020
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

local bkg

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local rocket
local retro
local games
local inc
local mario
local scrollXSpeed = 2
local scrollYSpeed = -2
local mSpeedY = -10
local mSpeedX = -10

local launchSound = audio.loadSound("Sounds/launch.mp3")
local launchSoundChannel
local jumpSound = audio.loadSound("Sounds/mario.mp3")
local jumpSoundChannel
--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------


-- The function that moves the rocket across the screen
local function moveRocket(event)
    rocket.x = rocket.x + scrollXSpeed
    rocket.y = rocket.y + scrollYSpeed
    if (rocket.x >= 450) then
        scrollYSpeed = 0
        scrollXSpeed = 0
        mario.y = mario.y + mSpeedY
        audio.stop(launchSoundChannel)
    end
end

local function MoveMario(event)
    if (rocket.x >= 400) then
        mario.x = mario.x + mSpeedX
        mario.isVisible = true
    end
    if (rocket.x >= 445) then
        jumpSoundChannel = audio.loadSound(jumpSound)
    end
end


-- The function that will go to the main menu 
--local function gotoMainMenu()
   -- composer.gotoScene( "main_menu", {effect = "fade", time = 500})
--end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- create background
    bkg = display.newImageRect("Images/Background.png", 2048, 1536)

    -- set x and y position
    bkg.x = display.contentWidth
    bkg.y = display.contentHeight

    -- insert into scene group
    sceneGroup:insert( bkg )

    -- Insert the rocket image
    rocket = display.newImageRect("Images/rocket.png", 536.5, 505)

    -- set the initial x and y position of the rocket
    rocket.x = 125
    rocket.y = 768

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rocket )

    -- insert retro image
    retro = display.newImageRect("Images/retro.png", 193.45, 129.57)

    -- set the x and y positions
    retro.x = 512
    retro.y = 256

    --retro.isVisible = false

    -- insert insto scene group
    sceneGroup:insert( retro )

    -- insert games image
    games = display.newImageRect("Images/games.png", 275.58, 269.005)

    -- set the x and y positions
    games.x = 512
    games.y = 426

    --games.isVisible = false

    -- insert insto scene group
    sceneGroup:insert( games )

    -- insert inc image
    inc = display.newImageRect("Images/inc.png", 84.98, 83.005)

    -- set the x and y positions
    inc.x = 512
    inc.y = 591

    --inc.isVisible = false

    -- insert insto scene group
    sceneGroup:insert( inc )

    -- insert mario image
    mario = display.newImageRect("Images/mariocape.png", 150, 120)

    -- set the x and y positions
    mario.x = 1024
    mario.y = 145

    mario.isVisible = false

    mario:scale(-1,1)

    -- insert insto scene group
    sceneGroup:insert( mario )


end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        launchSoundChannel = audio.play(launchSound)

        -- Call the MoveRocket function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveRocket)

        --call the MoveMario function
        Runtime:addEventListener("enterFrame", MoveMario)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
