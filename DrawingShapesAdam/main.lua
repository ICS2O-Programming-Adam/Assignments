--------------------------------------------------------
-- Title: Drawing shapes
-- Name: Adam Winogron
-- Course: ICS2O/3C
-- This program displays a face using different shapes
--------------------------------------------------------

-- to remove staus bar
display.setStatusBar(display.HiddenStatusBar)

-- set the background colour
local paint = {
    type = "gradient",
    color1 = { 73/255, 196/255, 11/255 },
    color2 = { 11/255, 97/255, 196/255 },
    direction = "right"
}

local rect = display.newRect( 768, 1024, 1536, 2048 )
rect.fill = paint

-- vertices for head
local headVertices = {120, 140, 120, -40, 100, -80, 80, -100, 60, -120, 20, -140, -20, -140,
 -60, -120, -80, -100, -100, -80, -120, -40, -120, 140 }

-- draw the head
local head = display.newPolygon( 512, 400, headVertices)

-- flip the head vertically
head:scale(1,-1)

-- change the colour of the head
head:setFillColor( 255/255, 160/255, 122/255 )

-- change the width of the head's border
head.strokeWidth = 2

-- set the colour of the head's border
head:setStrokeColor(0,0,0)

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
local noseCover = display.newRect( 512, 285, 80, 12 )

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
local mouthLine = display.newLine( -80, 40, -60, 60, -20, 80, 20, 80, 60, 60, 80, 40, 80, 40)

-- set the position of the mouthLine
mouthLine.x = 433
mouthLine.y = 445

-- set the width of the mouthLine's border
mouthLine.strokeWidth = 3

-- set the colour of the mouthLine
mouthLine:setStrokeColor( 0, 0, 0 )

-- set the vertices for the left eyebrow
local leftEyebrowVertices = { -60, 105, -60, 115, -80, 115, -100, 105, -100, 95, -80, 105 }

-- draw the right eyebrow
local leftEyebrow = display.newPolygon( 437, 295, leftEyebrowVertices )

-- flip the left eyebrow vertically
leftEyebrow:scale(1,-1)

-- change the colour of the left eyebrow
leftEyebrow:setFillColor( 139/255, 69/255, 19/255 )

-- change the width of the left eyebrow's border
leftEyebrow.strokeWidth = 1

-- change the colour of the left eyebrow's border
leftEyebrow: setStrokeColor( 0,0,0 )

-- set the vertices for the right eyebrow
local rightEyebrowVertices = { 60, 105, 60, 115, 80, 115, 100, 105, 100, 95, 80, 105 }

-- draw the right eyebrow
local rightEyebrow = display.newPolygon( 586, 295, rightEyebrowVertices )

-- flip the right eyebrow vertically
rightEyebrow:scale(1,-1)

-- change the colour of the right eyebrow
rightEyebrow:setFillColor( 139/255, 69/255, 19/255)

-- change the width of the right eyebrow's border's width
rightEyebrow.strokeWidth = 1

-- change the colour of the right eyebrow's border
rightEyebrow:setStrokeColor(0,0,0)

-- set the vertices for the hair
local hairVertices = { -120,140, -140,120, -120,160, -140,180, -120,180,  -140,220,
-100,200, -80,230, -60,180, -40,220, -30,200, 0,240, 20,180, 30,220, 40,200, 
80,240, 70,200, 100,220, 100,200, 140,210, 120,180, 160,160, 140,150, 150,120, 
120, 140, 90, 120, 80, 140, 60, 140, 55, 160, 40, 140, 30, 120, 10, 150, -20, 120, 
-30, 140, -40, 110, -70, 150, -80, 120, -90, 140, -100, 120 }

-- draw the hair
local hair = display.newPolygon(520, 240, hairVertices)

-- flip the hair vertically
hair:scale(1,-1)

-- change the colour of the hair
hair:setFillColor( 139/255, 69/255, 19/255 )

-- change the width of the hair's border
hair.strokeWidth = 2

-- change the colour of the hair's border's colour
hair:setStrokeColor(0,0,0)

-- set the vertices for the right ear 
local rightEarVertices = {120, 100, 140, 90, 150, 70, 150, 40, 130, 20, 120, 20 }

-- draw the right ear 
local rightEar = display.newPolygon( 648, 350, rightEarVertices)

-- flip the right ear vertically
rightEar:scale(1,-1)

-- change the colour of the right ear
rightEar:setFillColor( 255/255, 160/255, 122/255 )

-- change the width of the right ear's border
rightEar.strokeWidth = 1

-- change the colour of the right aer's border
rightEar:setStrokeColor(0,0,0)

-- flip the right ear vertically
rightEar:scale(1,-1)

-- set the vertices for the left ear
local leftEarVertices = { -120, 100, -140, 90, -150, 70, -150, 40, -130, 20, -120, 20 }

-- draw the left ear
local leftEar = display.newPolygon( 376, 350, leftEarVertices )

-- change the width of the left ear's border
leftEar.strokeWidth = 1

-- change the colour of the left ear's border
leftEar:setStrokeColor(0,0,0)

-- change the colour of the left ear
leftEar:setFillColor( 255/255, 160/255, 122/255 )

-- set the vertices for the mouth line
local leftEarLine = display.newLine( -130, 80, -140, 70, -140, 50, -130, 40 )

-- set the position of the mouthLine
leftEarLine.x = 385
leftEarLine.y = 367

-- set the width of the mouthLine's border
leftEarLine.strokeWidth = 3

-- set the colour of the mouthLine
leftEarLine:setStrokeColor( 0, 0, 0 )

local rightEarLine = display.newLine( 130, 80, 140, 70, 140, 50, 130, 40 )

-- set the position of the mouthLine
rightEarLine.x = 638
rightEarLine.y = 367

-- set the width of the mouthLine's border
rightEarLine.strokeWidth = 3

-- set the colour of the mouthLine
rightEarLine:setStrokeColor( 0, 0, 0 )
--I added this text line just so I could say I wrote 250 ligns of code because it sounds so much more impressive than 249 ;)