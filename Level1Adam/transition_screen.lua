-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Adam Winogron
-- Date: May 26, 2020
-- Description: This is the splash screen of the game. It displays the 
-- company logo that is a rocket that flies across the screen, until mario jumps on it.
-- The words in the logo: retro, games, and inc, proceed to come in from different parts of the screen.
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- create the background
local bkg

-- Name the Scene
sceneName = "transition_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local kingKoko
local kokoSpeed = 20
local speech1
local speech2
local speech3
local platShrink = 20
local kokoShrink = 15
local speechShrink = 10


--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

local function MoveKoko(event)
    kingKoko.y = kingKoko.y + kokoSpeed
    if (kingKoko.y >= 250) then
        speech1.isVisible = true
        kokoSpeed = 0
    end
end

local function TextDisplay()
    speech1.isVisible = false
    speech2.isVisible = true
end

local function TextDisplay2()
    speech2.isVisible = false
    speech3.isVisible = true
end

local function TextDisplay3()
    speech3.isVisible = false
    speech4.isVisible = true
end

local function Shrink()
    plat2.width = plat2.width - platShrink
    plat2.height = plat2.height - platShrink
    kingKoko.width = kingKoko.width - kokoShrink
    kingKoko.height = kingKoko.height - kokoShrink
    speech4.width = speech4.width - speechShrink
    speech4.height = speech4.height - speechShrink
    speech1.width = speech1.width - speechShrink
    speech1.height = speech1.height - speechShrink
end

local function CallShrink()
    Runtime:addEventListener("enterFrame", Shrink)
end

-- The function that will go to the main menu 
local function gotoLevel1()
    composer.gotoScene( "level1_screen", {effect = "fade", time = 9000})
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- create background
    bkg = display.newImageRect("Images/level1_screen.png", display.contentWidth, display.contentHeight)

    -- set x and y position
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY

    -- insert into scene group
    sceneGroup:insert( bkg )

    plat2 = display.newImageRect("Images/platform2.png", 1000, 299)
    plat2.x = 500
    plat2.y = 500
    sceneGroup:insert(plat2)

    kingKoko = display.newImageRect("Images/spacechimp.png", 360, 450)
    kingKoko.x = 500
    kingKoko.y = -200
    sceneGroup:insert(kingKoko)

    speech1 = display.newImageRect("Images/text1.png", 400, 200)
    speech1.y = 100
    speech1.x = 800
    speech1.isVisible = false
    sceneGroup:insert(speech1)

    speech2 = display.newImageRect("Images/text2.png", 400, 200)
    speech2.y = 100
    speech2.x = 800
    speech2.isVisible = false
    sceneGroup:insert(speech2)

    speech3 = display.newImageRect("Images/text3.png", 400, 200)
    speech3.y = 100
    speech3.x = 800
    speech3.isVisible = false
    sceneGroup:insert(speech3)

    speech4 = display.newImageRect("Images/text4.png", 400, 200)
    speech4.y = 100
    speech4.x = 800
    speech4.isVisible = false
    sceneGroup:insert(speech4)


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
        launchSoundChannel = audio.play(launchSound, {channel = 3})

        Runtime:addEventListener("enterFrame", MoveKoko)

        timer.performWithDelay ( 2500, TextDisplay )

        timer.performWithDelay ( 5000, TextDisplay2 )

        timer.performWithDelay ( 7000, TextDisplay3 )

        timer.performWithDelay ( 8000, CallShrink )

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 9000, gotoLevel1)     
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

        Runtime:removeEventListener(MoveKoko)
        Runtime:removeEventListener(Shrink)
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
