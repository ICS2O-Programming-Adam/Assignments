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

local koko
local kokoSpeed = 1

local muteButton
local unmuteButton

local motionx = 0
local SPEED = 7
local SPEED2 = -7
local LINEAR_VELOCITY = -175
local GRAVITY = 15

local rocket
local rocketSpeed = - 2

local comet
local cometSpeed = 5
local randomY = math.random( 200, 600 )

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function MoveRocket(event)
    rocket.x = rocket.x + rocketSpeed
    if (rocket.x <= -200) then
        rocket.x = 1400
    end
end

local function MoveKoko(event)
    koko.x = koko.x + kokoSpeed
    if (koko.x >= 550) then
        kokoSpeed = -1
        koko:scale(-1,1)
    end
    if (koko.x <= 450) then
        kokoSpeed = 1
        koko:scale(-1,1)
    end
end


local function MoveComet(event)
    comet.x = comet.x + cometSpeed
    if (comet.x >= 1100) then
        comet.x = -50
        comet.y = math.random( 200, 600 )
    end
end


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


local function GoToLose()
    composer.gotoScene( "you_lose", {effect = "fade", time = 500})
end

local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )

    if ( event.phase == "began" ) then

        if (event.target.myName == "plat4") then
            Runtime:addEventListener("enterFrame", Warning)
        end

        if (event.target.myName == "comet") then
            timer.perfromWithDelay(10, GoToLose)
        end

    end
end

local function AddPhysicsBodies()
    --add to the physics engine
    physics.addBody( plat1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( plat2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( plat3, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( plat4, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( plat5, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( plat6, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( rocket, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( comet, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( koko, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( astro, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )
    astro.isFixedRotation = true   

end

local function RemovePhysicsBodies()
    physics.removeBody(plat1)
    physics.removeBody(plat2)
    physics.removeBody(plat3)
    physics.removeBody(plat4)
    physics.removeBody(plat5)
    physics.removeBody(plat6)
    physics.removeBody(rocket)
    physics.removeBody(comet)
    physics.removeBody(astro)
    physics.removeBody(koko)

 
end


local function AddCollisionListeners()
    -- if character collides with plat, onCollision will be called
    plat1.collision = onCollision
    plat1:addEventListener( "collision" )
    plat2.collision = onCollision
    plat2:addEventListener( "collision" )
    plat3.collision = onCollision
    plat3:addEventListener( "collision" )
    plat4.collision = onCollision
    plat4:addEventListener( "collision" )
    plat5.collision = onCollision
    plat5:addEventListener( "collision" )
    plat6.collision = onCollision
    plat6:addEventListener( "collision" )
    rocket.collision = onCollision
    rocket:addEventListener( "collision" )
    comet.collision = onCollision
    comet:addEventListener( "collision" )
    astro.collision = onCollision
    astro:addEventListener( "collision" )
    koko.collision = onCollision
    koko:addEventListener( "collision" )

end

local function RemoveCollisionListeners()

    plat1:removeEventListener( "collision" )
    plat2:removeEventListener( "collision" )
    plat3:removeEventListener( "collision" )
    plat4:removeEventListener( "collision" )
    plat5:removeEventListener( "collision" )
    plat6:removeEventListener( "collision" )
    comet:removeEventListener( "collision" )
    rocket:removeEventListener( "collision" )
    astro:removeEventListener( "collision" )
    koko:removeEventListener( "collision" )

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
    sceneGroup:insert( plat1 )
    

    plat2 = display.newImageRect("Images/platform2.png", 300, 99.75)
    plat2.x = 500
    plat2.y = 150
    sceneGroup:insert( plat2 )

    plat3 = display.newImageRect("Images/platform5.png", 163.875, 109.25)
    plat3.x = 450
    plat3.y = 600
    sceneGroup:insert( plat3 )
 

    plat4 = display.newImageRect("Images/platform4.png", 225, 205)
    plat4.x = 825
    plat4.y = 500
    sceneGroup:insert( plat4 )

    plat5 = display.newImageRect("Images/platform5.png", 163.875, 109.25)
    plat5.x = 625
    plat5.y = 500
    sceneGroup:insert( plat5 )

    plat6 = display.newImageRect("Images/platform6.png", 128, 102.5)
    plat6.x = 200
    plat6.y = 300
    sceneGroup:insert( plat6 )

    -- Creating Joystick
    analogStick = joystick.new( 50, 75 ) 

        -- Setting Position
        analogStick.x = 850
        analogStick.y = display.contentHeight - 100

        -- Changing transparency
        analogStick.alpha = 0.5

    sceneGroup:insert( analogStick )

    astro = display.newImageRect("Images/astronaut.png", 77.875, 90.125)
        astro.x = 250
        astro.y = 650
        astro:scale(-1,1)
        astro.myName = "astro"
        sceneGroup:insert( astro )

    koko = display.newImageRect("Images/spacechimp2.png", 125, 108.33)
    koko.x = 500
    koko.y = 80
    sceneGroup:insert( koko )

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


    -- Insert the rocket image
    rocket = display.newImageRect("Images/rocket2.png", 110, 375)

    -- set the initial x and y position of the rocketS
    rocket.x = 1400
    rocket.y = 350

    rocket.rotation = -90

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rocket )    


    --insert meteor image
    comet = display.newImageRect("Images/meteor.png", 40.9375, 61.125)
    comet.y = randomY
    comet.x = -50
    comet.rotation = -90
    comet.myName = "comet"
    sceneGroup:insert( comet )




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
        Runtime:addEventListener("enterFrame", MoveRocket)
        Runtime:addEventListener("enterFrame", MoveComet)
        Runtime:addEventListener("enterFrame", MoveKoko)

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
        Runtime:removeEventListener( MoveRocket )


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
