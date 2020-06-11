-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local joystick = require( "joystick" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local plat1
local plat2
local plat3
local plat4
local plat5
local plat6

local platSpeed1 = -2
local platSpeed2 = 1

local facingWhichDirection = "right"
local joystickPressed = false

local astro

local muteButton
local unmuteButton

local motionx = 0
local SPEED = 7
local SPEED2 = -7
local LINEAR_VELOCITY = -175
local GRAVITY = 15

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function MovePlat3(event)
    plat3.y = plat3.y + platSpeed1
    if (plat3.y <= 500) then
        platSpeed1 = 2
    end
    if (plat3.y >= 750) then
        platSpeed1 = -2
    end
end


local function MovePlat5(event)
    plat5.y = plat5.y + platSpeed2
    if (plat5.y >= 750) then
        platSpeed2 = -1
    end
    if (plat5.y <= 450) then
        platSpeed2 = 1
    end
end

-- Creating a function which limits the astros' movement to the visible screen
local function ScreenLimit( astro )    

    -- Checking if the the astro is about to go off the right side of the screen
    if astro.x > ( display.contentWidth - astro.width / 2 ) then
            
        astro.x = astro.x - 7.5

    -- Checking if the astro is about to go off the left side of the screen
    elseif astro.x < ( astro.width / 2 ) then

        astro.x = astro.x + 7.5

    -----------------------------------------------------------------------------------------

    -- Checking if the astro is about to go off the bottom of the screen
    elseif astro.y > ( display.contentHeight - astro.height / 2 ) then

        astro.y = astro.y - 7.5

    -- Checking if the astro is about to off the top of the screen
    elseif astro.y < ( astro.height / 2 ) then

        astro.y = astro.y + 7.5

    end
end
    
-----------------------------------------------------------------------------------

-- Creating Joystick function that determines whether or not joystick is pressed
local function Movement( touch )

    if touch.phase == "began" then

        -- Setting a boolean to true to simulate the holding of a button
        joystickPressed = true

    elseif touch.phase == "ended" then

        -- Setting a boolean to false to simulate the release of a held button
        joystickPressed = false
    end
end --local function Movement( touch )

-----------------------------------------------------------------------------

-- Creating a function that holds all the runtime animations/events
local function RuntimeEvents( )

        -- Retrieving the properties of the joystick
        angle = analogStick:getAngle()
        distance = analogStick:getDistance() -- Distance from the center of the joystick background
        direction = analogStick.getDirection()

        -----------------------------------------------------------------------------------------

        -- Checking if the joystick is being held
        if joystickPressed == true then

            -- Applying the force of the joystick to move the astro
            analogStick:move( astro, 0.75 )

        end

        -----------------------------------------------------------------------------------------

        -- Limiting each astro's movement to the edge of the screen
        ScreenLimit( astro )

        -----------------------------------------------------------------------------------------

        -- Checking if the joystick is pointing the opposite direction of the astro
        if facingWhichDirection == "left" then
            
            -- Checking if the joystick is pointing to the right
            if direction == 1 or direction == 2 or direction == 8 then

                -- Flipping the controlled charcter's direction
                astro:scale( -1, 1 )

                -- Setting the status of the astro's directions
                facingWhichDirection = "right"

            end
        end

        -----------------------------------------------------------------------------------------

        -- Checking if the joystick is pointing the opposite direction of the astro
        if facingWhichDirection == "right" then


            -- Checking if the joystick is pointing to the right
            if direction == 4 or direction == 5 or direction == 6 then

                -- Flipping the controlled charcter's direction
                astro:scale( -1, 1 )

                -- Setting the status of the astro's directions
                facingWhichDirection = "left"

            end
        end

        -----------------------------------------------------------------------------------------

end -- local function RuntimeEvents( )

local function AddPhysicsBodies()
    --add to the physics engine
    physics.addBody( plat1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( plat2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( plat3, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( plat4, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( plat5, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( plat6, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( astro, "static", { density=0, friction=0.5, bounce=0, rotation=0 } )   

end

local function RemovePhysicsBodies()
    physics.removeBody(plat1)
    physics.removeBody(plat2)
    physics.removeBody(plat3)
    physics.removeBody(plat4)
    physics.removeBody(plat5)
    physics.removeBody(plat6)
    physics.removeBody(astro)

 
end

local function Mute(touch)
    if (touch.phase == "ended") then
        -- pause the sound 
        audio.stop(bkgSoundChannel)
        -- hide the mute button
        muteButton.isVisible = false
        -- make the unmute button visible
        unmuteButton.isVisible = true
    end
end

local function Unmute(touch)
    if (touch.phase == "ended") then
        -- pause the sound 
        bkgSoundChannel = audio.play(bkgSound)
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

    -- Insert the background image
    bkg_image = display.newImageRect("Images/level1_screen.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    


    plat1 = display.newImageRect("Images/platform1.png", 200, 85.084)
    plat1.x = 250
    plat1.y = 700
    


    plat2 = display.newImageRect("Images/platform2.png", 300, 99.75)
    plat2.x = 500
    plat2.y = 150
 

    plat3 = display.newImageRect("Images/platform5.png", 163.875, 109.25)
    plat3.x = 450
    plat3.y = 600
    
 

    plat4 = display.newImageRect("Images/platform4.png", 256, 205)
    plat4.x = 800
    plat4.y = 500


    plat5 = display.newImageRect("Images/platform5.png", 163.875, 109.25)
    plat5.x = 625
    plat5.y = 500


    plat6 = display.newImageRect("Images/platform6.png", 128, 102.5)
    plat6.x = 200
    plat6.y = 300

    -- Creating Joystick
    analogStick = joystick.new( 50, 75 ) 

        -- Setting Position
        analogStick.x = 850
        analogStick.y = display.contentHeight - 100

        -- Changing transparency
        analogStick.alpha = 0.5

    sceneGroup:insert( analogStick )

     astro = display.newImageRect("Images/astronaut.png", 77.875, 90.125)
        astro.x = display.contentCenterX
        astro.y = display.contentCenterY*4/3
        astro:scale(-1,1)

    -- mute button
    muteButton = display.newImageRect ("Images/mute.png", 85, 85)
    muteButton.x = 75
    muteButton.y = 65
    muteButton.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( muteButton )

    -- unmute button
    unmuteButton = display.newImageRect ("Images/unmute.png", 85, 85)
    unmuteButton.x = 75
    unmuteButton.y = 65
    unmuteButton.isVisible = false
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( unmuteButton )



end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- start physics
        physics.start()

        -- set gravity
        physics.setGravity( 0, GRAVITY )

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        Runtime:addEventListener("enterFrame", MovePlat3)
        Runtime:addEventListener("enterFrame", MovePlat5)

        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", Unmute)


        analogStick:activate()

        -- Listening for the usage of the joystick
        analogStick:addEventListener( "touch", Movement )
        Runtime:addEventListener("enterFrame", RuntimeEvents)

        -- add physics bodies to each object
        AddPhysicsBodies()
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

        -- Deactivating the Analog Stick
        analogStick:deactivate()

        -- Stopping the Runtime Events
        Runtime:removeEventListener( "enterFrame", RuntimeEvents )

        -- Removing the listener which listens for the usage of the joystick
        analogStick:removeEventListener( "touch", Movement )

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        muteButton:removeEventListener("touch", Mute)
        unmuteButton:removeEventListener("touch", Unmute)

        RemovePhysicsBodies()

        physics.stop()
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
