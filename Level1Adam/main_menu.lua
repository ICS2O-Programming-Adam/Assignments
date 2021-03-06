-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Adam Winogron
-- Date: june 4, 2020
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- LOCAL SOUNDS
-----------------------------------------------------------------------------------------
local sound = audio.loadStream("Sounds/bkgMusic.mp3")
local soundChannel 
-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local creditsButton
local instructionsButton
local shootingStar
local rocket

local starSpeedX = -15
local starSpeedY = 15

local muteButton
local unmuteButton


-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function ReStar(event)
    if (shootingStar.x <= 0) then
        shootingStar.x = math.random ( 1, 1024 )
        shootingStar.y = 0
    end
end

local function MoveStar(event)
    shootingStar.x = shootingStar.x + starSpeedX
    shootingStar.y = shootingStar.y + starSpeedY
    shootingStar.isVisible = true
end


-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "fromRight", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "transition_screen", {effect = "flipFadeOutIn", time = 1000})
end    

-----------------------------------------------------------------------------------------

-- creating the transition function to instructions Page
local function InstructionsTransition( )
    composer.gotoScene( "instructions_screen", {effect = "fromLeft", time = 1000})
end


local function Mute(touch)
    if (touch.phase == "ended") then
        -- pause the sound 
        audio.stop()
        -- hide the mute button
        muteButton.isVisible = false
        -- make the unmute button visible
        unmuteButton.isVisible = true
    end
end

local function Unmute(touch)
    if (touch.phase == "ended") then
        -- pause the sound 
        soundChannel = audio.play(sound)
        -- hide the mute button
        muteButton.isVisible = true
        -- make the unmute button visible
        unmuteButton.isVisible = false
    end
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen

    shootingStar = display.newImageRect("Images/shootstar.png", 210, 148.5)
    shootingStar.x = 700
    shootingStar.y = 0
    shootingStar.isVisible = false
    sceneGroup:insert( shootingStar )

    bkg_image = display.newImage("Images/MainMenu.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -- mute button
    muteButton = display.newImageRect ("Images/mute.png", 85, 85)
    muteButton.x = 75
    muteButton.y = 65
    muteButton.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    --sceneGroup:insert( muteButton )

    -- unmute button
    unmuteButton = display.newImageRect ("Images/unmute.png", 85, 85)
    unmuteButton.x = 75
    unmuteButton.y = 65
    unmuteButton.isVisible = false
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    --sceneGroup:insert( unmuteButton )

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*6.5/8,

            -- Set the width and height of the button
            width = 300,
            height = 150,

            -- Insert the images here
            defaultFile = "Images/GoButton.png",
            overFile = "Images/PlayButtonPressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*6.7/8,
            y = display.contentHeight*6.8/8,

            -- Set the width and height of the button
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/WhoButton.png",
            overFile = "Images/WhoButtonPressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 

    -----------------------------------------------------------------------------------------

    -- creating instructions button
    instructionsButton = widget.newButton(
                {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1.3/8,
            y = display.contentHeight*6.8/8,

            -- Set the width and height of the button
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/WhatButton.png",
            overFile = "Images/InstructionsButtonPressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = InstructionsTransition
        } ) 
    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton)

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then  

    -- play background music
    soundChannel = audio.play (sound, {loops = -1}, {channel = 4})
    Runtime:addEventListener( "enterFrame", MoveStar)    
    Runtime:addEventListener( "enterFrame", ReStar)

    muteButton:addEventListener("touch", Mute)
    unmuteButton:addEventListener("touch", Unmute)

    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        Runtime:removeEventListener( "enterFrame", MoveStar)    
        Runtime:removeEventListener( "enterFrame", ReStar)

        muteButton:removeEventListener("touch", Mute)
        unmuteButton:removeEventListener("touch", Unmute)

        audio.stop(soundChannel)
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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
