-----------------------------------------------------------------------------------------
--
-- you_lose.lua
-- Created by: Adam Winogron
-- Date: june 4, 2020
-- Description: This is the lose screen.
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- LOCAL SOUNDS
-----------------------------------------------------------------------------------------

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
sceneName = "you_lose"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local againButton
local menuButton
local shootingStar
local rocket

local starSpeedX = -15
local starSpeedY = 15


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

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "flipFadeOutIn", time = 1000})
end    

-----------------------------------------------------------------------------------------

-- creating the transition function to instructions Page
local function MenuTransition( )
    composer.gotoScene( "main_menu", {effect = "fromLeft", time = 1000})
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

    bkg_image = display.newImage("Images/lose.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    againButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*6.5/8,

            -- Set the width and height of the button
            width = 300,
            height = 150,

            -- Insert the images here
            defaultFile = "Images/AgainButton.png",
            overFile = "Images/AgainButtonPressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------

    -- creating instructions button
    menuButton = widget.newButton(
                {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1.3/8,
            y = display.contentHeight*6.8/8,

            -- Set the width and height of the button
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/MenuButton.png",
            overFile = "Images/MenuButtonPressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = MenuTransition
        } ) 
    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( againButton )
    sceneGroup:insert( menuButton )

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
    --soundChannel = audio.play (sound, {loops = -1}, {channel = 4})
    Runtime:addEventListener( "enterFrame", MoveStar)    
    Runtime:addEventListener( "enterFrame", ReStar)

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
        Runtime:removeEventListener("enterFrame", MoveStar)
        Runtime:removeEventListener("enterFrame", ReStar)
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
