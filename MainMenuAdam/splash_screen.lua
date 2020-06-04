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

-- speed variables
local scrollXSpeed = 2
local scrollYSpeed = -2
local mSpeedY = -10
local mSpeedX = -10
local retroSpeed = 20
local gamesSpeed = -20
local incSpeed = -20
local incRotate = 40


-- local sounds and channels
local launchSound = audio.loadSound("Sounds/launch.mp3")
local launchSoundChannel
local jumpSound = audio.loadSound("Sounds/mario.mp3")
local jumpSoundChannel
local logoSound = audio.loadSound("Sounds/retrogames.MOV")
local logoSoundChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- moves "inc" across the screen from the bottom while it spins
local function MoveInc(event)
    --make inc visible
    inc.isVisible = true
    --make inc move up
    inc.y = inc.y + incSpeed
    --make inc fade in
    inc.alpha = inc.alpha + 0.1
    --make inc rotate
    inc:rotate(incRotate)
    --make inc stop moving when it reaches a certain point
    if (inc.y <= 591) then
        incSpeed = 0
        incRotate = 0
    end
end

-- moves "games" across the screen
local function MoveGames(event)
    --make games visible
    games.isVisible = true
    --move games left
    games.x = games.x + gamesSpeed
    --make games fade in
    games.alpha = games.alpha + 0.05
    --make games stop moving when it reaches a certain point
    if (games.x <= 512) then
        gamesSpeed = 0
        -- call the function that moves inc 
        timer.performWithDelay( 500, MoveInc)
    end
end

-- moves "retro" across the screen
local function MoveRetro(event)
    --make retro visible
    retro.isVisible = true
    --move retro right
    retro.x = retro.x + retroSpeed
    --make retro fade in
    retro.alpha = retro.alpha + 0.05
    --make retro stop moving when it reaches a certain point
    if (retro.x >= 500) then
        retroSpeed = 0
        timer.performWithDelay( 500, MoveGames)
    end
end


-- The function that moves the rocket across the screen
local function moveRocket(event)
    --move the rocket diagonally
    rocket.x = rocket.x + scrollXSpeed
    rocket.y = rocket.y + scrollYSpeed
    --make the rocket stop moving when it reaches a certain point
    if (rocket.x >= 450) then
        scrollYSpeed = 0
        scrollXSpeed = 0
        --make Mario move up
        mario.y = mario.y + mSpeedY
        --stop the rocket sounds
        audio.stop(launchSoundChannel)
        --call the function that moves retro
        timer.performWithDelay(200, MoveRetro)
    end
end

-- play the jump sound 
local function MarioSound()
    jumpSoundChannel = audio.play(jumpSound, { channel = 1})
end

-- play the "retro games" sound 
local function FinalSound()
    logoSoundChannel = audio.play(logoSound, {channel = 2})
end

--move mario left
local function MoveMario(event)
    if (rocket.x >= 400) then
        mario.x = mario.x + mSpeedX
        --make mario visible 
        mario.isVisible = true
    end
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu", {effect = "fade", time = 2000})
end

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
    retro.x = 0
    retro.y = 256

    --make retro invisible
    retro.isVisible = false

    -- set retro's alpha
    retro.alpha = 0

    -- insert insto scene group
    sceneGroup:insert( retro )



    -- insert games image
    games = display.newImageRect("Images/games.png", 275.58, 269.005)

    -- set the x and y positions
    games.x = 1024
    games.y = 426

    --make games invisible
    games.isVisible = false

    -- set gams's alpha
    games.alpha = 0

    -- insert insto scene group
    sceneGroup:insert( games )



    -- insert inc image
    inc = display.newImageRect("Images/inc.png", 84.98, 83.005)

    -- set the x and y positions
    inc.x = 512
    inc.y = 768

    -- make inc invisible
    inc.isVisible = false

    --set inc's alpha
    inc.alpha = 0

    -- insert insto scene group
    sceneGroup:insert( inc )



    -- insert mario image
    mario = display.newImageRect("Images/mariocape.png", 150, 120)

    -- set the x and y positions
    mario.x = 1024
    mario.y = 145

    --make mario invisible
    mario.isVisible = false

    --flip the mario image
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
        launchSoundChannel = audio.play(launchSound, {channel = 3})

        -- Call the MoveRocket function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveRocket)

        --call the MoveMario function
        Runtime:addEventListener("enterFrame", MoveMario)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 5000, gotoMainMenu)     

        -- play the jump sound after 2.225 seconds
        timer.performWithDelay ( 2225, MarioSound)     
        
        -- play the "retro games" sound after 2.5 seconds
        timer.performWithDelay ( 2500, FinalSound)
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
        Runtime:removeEventListener(moveRocket)
        Runtime:removeEventListener(MoveMario)
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
