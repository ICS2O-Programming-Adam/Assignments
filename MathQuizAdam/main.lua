-----------------------------------------------------------------------------------------
-- Title: MathQuiz
-- Name: Adam Winogron
-- Course: ICS2O/3C
-- This program is a math game. It is the fifth assignment.
-----------------------------------------------------------------------------------------

-- hide the ststus bar
display.setStatusBar(display.HiddenStatusBar)

local bkg = display.newImageRect( "Images/bkg.svg", 1227, 842 )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES 
-----------------------------------------------------------------------------------------

--create local variables 
local randomChooser
local randomNumber1
local randomNumber2
local randomMulti1
local randomMulti2
local rightAnswer
local userAnswer
local questionText
local numericField
local incorrectText
local correctText

--create clock variables
local totalSeconds = 15
local secondsLeft = 15
local clockText
local timer

--create lives variables
local lives = 3
local life1
local life2
local life3

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- generate a question
local function AskQuestion()

	-- calculate a random number that determines the type of equation
	randomChooser = math.random(1, 6)

	-- calculate two random numbers between 1 and 20 that will be used in equations
	randomNumber1 = math.random(1, 20)
	randomNumber2 = math.random(1, 20)

	-- calculate two random numbers between 1 and 10 that will be used in equations
	randomMulti1 = math.random(1,10)
	randomMulti2 = math.random(1,10)

	-- function for addition
	if (randomChooser == 1) then

		-- calculate the correct answer
		rightAnswer = randomNumber1 + randomNumber2

		-- update the question text
		questionText.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

	-- function for subtraction
	elseif (randomChooser == 2) then

		-- if the first number is greater than the second, subtract the second number from the first
		-- and update the question text
		if (randomNumber1 >= randomNumber2) then
			rightAnswer = randomNumber1 - randomNumber2
			questionText.text = randomNumber1 .. " - " .. randomNumber2 .. " = " 

		-- if the second number is greater that the first, subtract the first number from the second	
		-- and update the question text 
		else rightAnswer = randomNumber2 - randomNumber1
			questionText.text = randomNumber2 .. " - " .. randomNumber1 .. " = "
		end	

	-- function for multiplication
	elseif (randomChooser == 3) then

		-- find the correct answer
		rightAnswer = math.round(randomMulti1 * randomMulti2)

		-- update the question text
		questionText.text = randomMulti1 .. " x " .. randomMulti2 .. " = "

	-- function for division
	elseif (randomChooser == 4) then

		rightAnswer = 

  		-- update the question text
		questionText.text = randomNumber1 .. " / " .. randomNumber2 .. " = "
	
	-- function for 
	elseif (randomChooser == 5) then
		rightAnswer = randomNumber1 ^ randomNumber2

		questionText.text = randomNumber1 .. " ^ " .. randomNumber2 .. "\n (To the power of...) "

	elseif (randomChooser == 6) then
		rightAnswer = math.sqrt(randomNumber1)

		questionText.text = " √" .. randomNumber1
	end
end

local function HideCorrect()
	correctText.isVisible = false
	AskQuestion()
end


local function HideIncorrect()
	incorrectText.isVisible = false
	AskQuestion()
end

local function LoseLives()
	if (lives == 2) then
		heart2.isVisible = false
	elseif (lives == 1) then
		heart1.isVisible = false
		Lose()
	end
end


local function NumericFieldListener( event )
	
	if ( event.phase == "began" ) then

		event.target.text = ""

	elseif event.phase == "submitted" then

		userAnswer = tonumber(event.target.text)

		event.target.text = ""

		if (userAnswer == rightAnswer) then
			correctText.isVisible = true
			timer.performWithDelay(1900, HideCorrect)
			secondsLeft = totalSeconds
		else

			incorrectText.isVisible = true
			timer.performWithDelay(1900, HideIncorrect)
			secondsLeft = totalSeconds
			lives = lives - 1
		end
	end
end

local function UpdateTime()

	--decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = "Time Left: " .. secondsLeft

	if (secondsLeft == 0 ) then
		-- reset the number of seconds left 
		secondsLeft = totalSeconds
		lives = lives - 1
		LoseLives()
	end
end

-- function that calls the timer
local function StartTimer()
	timer = timer.performWithDelay( 1000, UpdateTime, 0 )
end

-----------------------------------------------------------------------------------------
-- OBJECT CREATION
-----------------------------------------------------------------------------------------

questionText = display.newText("", display.contentWidth/3.5, display.contentHeight/3, nil, 50)
questionText:setTextColor( 1,1,1 )

numericField = native.newTextField( display.contentWidth/2, display.contentHeight/3, 200, 80 )
numericField.inputType = "decimal"
numericField:addEventListener( "userInput", NumericFieldListener )

correctText = display.newText( "Yup, You Got It!", display.contentWidth/2, display.contentHeight*1.5/3, nil, 50 )
correctText:setTextColor( 58/255, 227/255, 17/255 )
correctText.isVisible = false

incorrectText = display.newText( "Nope, Sorry!", display.contentWidth/2, display.contentHeight*1.5/3, nil, 50 )
incorrectText:setTextColor( 234/255, 16/255, 16/255  )
incorrectText.isVisible = false

heart1 = display.newImageRect("Images/life.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/life.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/life.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7

clockText = display.newText("Time Left: ", 200, 100, nil, 50)
clockText:setTextColor(0,1,1)
clockText.isVisible = true


-----------------------------------------------------------------------------------------
-- FUNCTION CALLS
-----------------------------------------------------------------------------------------

AskQuestion()

StartTimer()

LoseLives()