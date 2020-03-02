-- Title: Drawing shapes
-- Name: Adam Winogron
-- Course: ICS2O/3C
-- This program displays a face using different shapes

-- create my local variable

-- to remove staus bar
display.setStatusBar(display.HiddenStatusBar)

-- vertices for head
local headVertices = {120, 140, 120, -40, 100, -80, 80, -100, 60, -120, 20, -140, -20, -140,
 -60, -120, -80, -100, -100, -80, -120, -40, -120, 140 }

-- draw the head
local head = display.newPolygon( 512, 400, headVertices)

-- flip the head vertically
head:scale(1,-1)

-- change the colour of the head
head:setFillColor( 255/255, 160/255, 122/255 )

-- vertices for nose
local noseVertices = {-40, 100, -20, 80, -20, 20, -40, 0, -40, -20, -20, -40, 20, -40, 40, -20,
40, 0, 20, 20, 20, 80, 40, 100 }

-- draw the nose
local nose = display.newPolygon( 512, 360, noseVertices)

-- flip the nose vertically
nose:scale(1,-1)

-- change the colour of the nose 
nose:setFillColor( 255/255, 160/255, 122/255 )

-- change the width of the border of the nose
nose.strokeWidth = 2

-- change the colour of the border of the nose
nose:setStrokeColor( 0/255, 0/255, 0/255 )

-- vertices for left eye
local leftEyeVertices = {-60, 40, -40, 60, -40, 80, -60, 100, -80, 100, -100, 80, -100, 60, -80, 40}

-- draw the left eye
local leftEye = display.newPolygon( 450, 330, leftEyeVertices)

-- change the width of the border of the left eye
leftEye.strokeWidth = 2

-- set the colour of the border of the nose
leftEye:setStrokeColor( 0/255, 0/255, 0/255 )

--vertices for right eye
local rightEyeVertices = {80, 40, 100, 60, 100, 80, 80, 100, 60, 100, 40, 80, 40, 60, 
60, 40}

-- draw the right eye
local rightEye = display.newPolygon( 570, 330, rightEyeVertices)

-- change the size of the bordes width of the right eye
rightEye.strokeWidth = 2

-- change the colour of the border of the right eye
rightEye:setStrokeColor ( 0, 0, 0 )

-- draw rectangle
local noseCover = display.newRect( 512, 285, 80, 10 )

-- change the colour of the rectangle
noseCover:setFillColor( 255/255, 160/255, 122/255 )

-- create the vertices for the mouth
local mouthVertices = { -80, -40, -80, -60, -60, -80, -20, -100, 20, -100, 60, -80, 80, -60, 
80, -40, 40, -60, -40, -60, }

-- draw the mouth
local mouth = display.newPolygon( 512, 470, mouthVertices )

-- flip the mouth vertically
mouth:scale(1,-1)

-- change the size of the mouth's borer
mouth.strokeWidth = 2

-- change the colour of the mouth's border
mouth:setStrokeColor(0,0,0)

-- draw the right pupil
local rightPupil = display.newCircle( 560, 325, 10, 10 )

-- change the colour of the right pupil
rightPupil:setFillColor( 0, 0, 0 )

-- draw the left pupil
local leftPupil = display.newCircle( 435, 325, 10, 10 )

-- change the colour of the left pupil
leftPupil:setFillColor( 0, 0, 0 )

-- set the vertices for the mouth line

local mouthLine = display.newLine( -80, -40, -60, -60, -20, -80, 20, -80, 60, 60, 80, 40 )