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
sceneName = "final_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local astro
local kingKoko
local kokoArms
local blaster
local kokoSpeed = 20
local kokoSpeed2 = 10
local glueSpeed = 15
local lastSpeed = 5
local shrinkSpeed = 10
local superShrinkSpeed = 20
local alphaSpeed = 0.001
local heightSpeed = 5
local widthSpeed = 10
local starSpeedX = -15
local starSpeedY = 15
local speech1
local speech2
local speech3
local platShrink = 20
local kokoShrink = 15
local speechShrink = 10
local astroSpeed = 10

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

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

local function CallStar()
    Runtime:addEventListener( "enterFrame", MoveStar)    
    Runtime:addEventListener( "enterFrame", ReStar)
end

local function MoveKoko(event)
    kingKoko.y = kingKoko.y + kokoSpeed
    if (kingKoko.y >= 250) then
        speech1.isVisible = true
        kokoSpeed = 0
    end
end

local function TextDisplay()
    speech1.x = 1400
    speech1.isVisible = false
    speech2.isVisible = true
    kingKoko.isVisible = false
    kokoArms.isVisible = true
    moonGlue.isVisible = true
end

local function TextDisplay2()
    speech2.isVisible = false
    speech3.isVisible = true
    kokoArms:scale(-1,1)
    kokoArms.x = kokoArms.x + 200
    moonGlue.width = moonGlue.width / 2
    moonGlue.height = moonGlue.height / 2
    moonGlue.x = moonGlue.x + 200
end

local function MoveAstro(event)
    astro.x = astro.x + lastSpeed
    if (astro.x >= 500) then
        lastSpeed = 0
        moonGlue.x = 390
        moonGlue.y = 270
    end
end

local function TurnGlue()
    moonGlue:rotate(90)
end

local function Shrink(event)
    astro.width = astro.width - shrinkSpeed
    astro.height = astro.height - shrinkSpeed
    moonGlue.width = moonGlue.width - shrinkSpeed
    moonGlue.height = moonGlue.height - shrinkSpeed
    platform.width = platform.width - superShrinkSpeed
    platform.height = platform.height - shrinkSpeed
end

local function CallShrink()
    Runtime:addEventListener("enterFrame", Shrink)
end

local function Hooray(event)
    winText.alpha = winText.alpha + alphaSpeed
    winText.width = winText.width + widthSpeed
    winText.height = winText.height + heightSpeed
    if (winText.width >= 990) and (winText.height >= 495) then
        alphaSpeed = 0
        widthSpeed = 0
        heightSpeed = 0
    end
end



local function CallHooray()
    Runtime:addEventListener("enterFrame", Hooray)
end

local  function CallAstro()
    Runtime:addEventListener("enterFrame", MoveAstro)
    timer.performWithDelay(600, TurnGlue)
    timer.performWithDelay(2000, CallShrink)
    timer.performWithDelay(2500, CallHooray)
    timer.performWithDelay(3000, CallStar)
end

local function ByeKoko(event)
    speech3.isVisible = false
    kokoArms.x = kokoArms.x + kokoSpeed2
    kokoArms.y = kokoArms.y - kokoSpeed2
    kokoArms:rotate(10)
    blaster.isVisible = false
    moonGlue.y = moonGlue.y + glueSpeed
    if (moonGlue.y >= 400) then
        glueSpeed = 0
    end
end

local function QueueKoko()
    Runtime:addEventListener("enterFrame", ByeKoko)
end

local function OffLazer()
    laser.isVisible = false
    timer.performWithDelay(10, QueueKoko)
end

local function ShootLazer(event)
    Runtime:removeEventListener(StopMSM)
    laser.isVisible = true
    timer.performWithDelay(500, OffLazer)
end

local function StopMSM()
    Runtime:removeEventListener(CallMSM)
    Runtime:removeEventListener(MoveKoko)
    Runtime:removeEventListener(MoveSpaceMan)
end

local  function MoveSpaceMan()
    astro.isVisible = true
    astro.x = astro.x + astroSpeed
    if (astro.x >= 300) then
        astroSpeed = 0
        blaster.isVisible = true
        StopMSM()
    end
end

local function CallMSM()
    Runtime:addEventListener("enterFrame", MoveSpaceMan)
end


-- The function that will go to the main menu 
local function gotoLevel2()
    composer.gotoScene( "level1_screen", {effect = "fade", time = 1000})
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

    platform = display.newImageRect("Images/platform2.png", 1000, 299)
    platform.x = 500
    platform.y = 500
    sceneGroup:insert(platform)

    kingKoko = display.newImageRect("Images/spacechimp.png", 360, 450)
    kingKoko.x = 500
    kingKoko.y = -200
    sceneGroup:insert(kingKoko)

    kokoArms = display.newImageRect("Images/spacechimp2.png", 526.5, 487.5)
    kokoArms.x = 500
    kokoArms.y = 250
    kokoArms.isVisible = false
    sceneGroup:insert(kokoArms)

    astro = display.newImageRect("Images/astronaut.png", 311.5, 360.5)
    astro.x = -100
    astro.y = 250
    astro:scale(-1,1)
    astro.isVisible = false
    sceneGroup:insert( astro )

    blaster = display.newImageRect("Images/lasergun.png", 214.5, 88.5)
    blaster.x = 150
    blaster.y = 250
    blaster.isVisible = false
    sceneGroup:insert( blaster )

    moonGlue = display.newImageRect("Images/moonglue.png", 174, 174)
    moonGlue.x = 320
    moonGlue.y = 210
    moonGlue:rotate(-45)
    moonGlue.isVisible = false
    sceneGroup:insert(moonGlue)

    shootingStar = display.newImageRect("Images/shootstar.png", 210, 148.5)
    shootingStar.x = 700
    shootingStar.y = 0
    shootingStar.isVisible = false
    sceneGroup:insert( shootingStar )

    winText = display.newImageRect("Images/CompleteText.png", 10, 5)
    winText.x = 512
    winText.y = 300
    winText.aplha = 0
    sceneGroup:insert(winText)

    laser = display.newImageRect("Images/lazer.png", 163, 528)
    laser.x = 480
    laser.y = 230
    laser:rotate(90)
    laser.isVisible = false
    sceneGroup:insert( laser )

    speech1 = display.newImageRect("Images/NewText1.png", 400, 200)
    speech1.y = 100
    speech1.x = 800
    speech1.isVisible = false
    sceneGroup:insert(speech1)

    speech2 = display.newImageRect("Images/NewText2.png", 400, 200)
    speech2.y = 100
    speech2.x = 800
    speech2.isVisible = false
    sceneGroup:insert(speech2)

    speech3 = display.newImageRect("Images/NewText3.png", 400, 200)
    speech3.y = 100
    speech3.x = 870
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

        timer.performWithDelay ( 7000, CallMSM ) 

        timer.performWithDelay ( 8000, ShootLazer ) 

        timer.performWithDelay ( 9000, CallAstro )  
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
        Runtime:removeEventListener(MoveStar)
        Runtime:removeEventListener(ReStar)
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
