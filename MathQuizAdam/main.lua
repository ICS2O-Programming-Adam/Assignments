-----------------------------------------------------------------------------------------
-- Title: MathQuiz
-- Name: Adam Winogron
-- Course: ICS2O/3C
-- This program is a math game. It is the fifth assignment.
-----------------------------------------------------------------------------------------

-- hide the ststus bar
display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES 
-----------------------------------------------------------------------------------------

-- create the background colour ( fade )
local paint = {
    type = "gradient",
    color1 = { 240/255, 6/255, 6/255 },
    color2 = { 240/255, 215/255, 6/255 },
    direction = "right"
}

-- set the background
local rect = display.newRect( 768, 1024, 1536, 2048 )
rect.fill = paint

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
local placeHolder
local randomFact
local counter = 1
local loseText
local loseImage
local points = 5
local scrollSpeed = 4

--create clock variables
local totalSeconds = 16
local secondsLeft = 16
local clockText
local countDownTimer

--create lives variables
local lives = 3
local life1
local life2
local life3

-- create the sound variables
local correctSound1 = audio.loadSound("Sounds/alright.m4a")
local correctSound2 = audio.loadSound("Sounds/nice.m4a")
local correctSound3 = audio.loadSound("Sounds/welldone.m4a")
local correctSoundChannel
local incorrectSound1 = audio.loadSound("Sounds/uhoh.m4a")
local incorrectSound2 = audio.loadSound("Sounds/yikes.m4a")
local incorrectSound3 = audio.loadSound("Sounds/mm.m4a")
local incorrectSoundChannel
local loseSound = audio.loadSound("Sounds/lose.m4a")
local loseSoundChannel
local winSound = audio.loadSound("Sounds/win.m4a")
local winSoundChannel
local randomWinSound
local randomLoseSound

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- generate a question
local function AskQuestion()

	-- calculate a random number that determines the type of equation
	randomChooser = math.random(1, 7)

	-- calculate two random numbers between 1 and 20 that will be used in equations
	randomNumber1 = math.random(1, 20)
	randomNumber2 = math.random(1, 20)

	-- calculate two random numbers between 1 and 10 that will be used in equations
	randomMulti1 = math.random(1,10)
	randomMulti2 = math.random(1,10)

	-- random number between 1 and 5
	randomFact1 = math.random(1,5)
	randomFact2 = math.random(1,5)

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

		placeHolder = randomMulti1 * randomMulti2
		rightAnswer = placeHolder / randomMulti1

  		-- update the question text
		questionText.text = placeHolder .. " / " .. randomMulti1 .. " = "
	
	-- function for exponents.
	elseif (randomChooser == 5) then
		--calculate the correct answer
		rightAnswer = randomFact1 ^ randomFact2

		-- update the question text
		questionText.text = randomFact1 .. " ^ " .. randomFact2 .. " = "

	--function for square roots	
	elseif (randomChooser == 6) then
		--calculate the right answer
		placeHolder = randomNumber1 * randomNumber1
		rightAnswer = placeHolder / randomNumber1

		-- update the question text
		questionText.text = " √" .. placeHolder

	--function for factorials
	elseif (randomChooser == 7) then
		-- set the placeHolder
		rightAnswer = 1

		--calculate the answer using a while loop
		while (counter <= randomFact1) do 
			rightAnswer = counter * rightAnswer
			counter = counter + 1
		end

		--update the question text
		questionText.text = randomFact1 .. "! = "
	end
end

-- generates a random number between 1 and 3 that will be used to determine which
--sound is played
local function RandomSoundChooser()
	randomSound = math.random(1,3)
end

-- hides correct text and asks another question
local function HideCorrect()
	correctText.isVisible = false
	AskQuestion()
end

-- hides incorrect text and asks another question
local function HideIncorrect()
	incorrectText.isVisible = false
	AskQuestion()
end

--moves picture until it reaches a certain point
local function MoveDrake(event)
	winImage.isVisible = true
	if (winImage.y <=357) then
		winImage.y = winImage.y + scrollSpeed
		winImage:rotate(20)
	end
end

-- function for when you win
-- makes everything invisible, cancels the timer, shows text, and plays the win sound
local function Win()
	if (points == 5) then
		questionText.isVisible = false
		clockText.isVisible = false
		numericField.isVisible = false
		correctText.isVisible = false
		incorrectText.isVisible = false
		heart1.isVisible = false
		heart2.isVisible = false
		heart3.isVisible = false
		winSoundChannel = audio.play(winSound)
		timer.cancel(countDownTimer)
		winText.isVisible = true
		winImage.isVisible = true
		Runtime:addEventListener("enterFrame", MoveDrake)
	end
end

-- moves picture until it reaches a certain point
local function MoveJordan(event)
	loseImage.isVisible = true
	if (loseImage.y <= 357) then
		loseImage.y = loseImage.y + scrollSpeed
		loseImage:rotate(20)
	end
end

-- function for when you win
-- makes everything invisible, cancels the timer, shows text, and plays the lose sound
-- also calls MoveJordan
local function Lose()
	questionText.isVisible = false
	clockText.isVisible = false
	numericField.isVisible = false
	correctText.isVisible = false
	incorrectText.isVisible = false
	loseSoundChannel = audio.play(loseSound)
	timer.cancel(countDownTimer)
	loseText.isVisible = true
	Runtime:addEventListener("enterFrame", MoveJordan)
end

-- turns heart images invisible as you lose lives.
-- when you hit 0 lives it calls the lose function
local function LoseLives()
	if (lives == 2) then
		heart3.isVisible = false
	elseif (lives == 1) then
		heart2.isVisible = false
	elseif (lives == 0) then
		heart1.isVisible = false
		Lose()
	end
end

-- listens to numeriuc field and reacts
local function NumericFieldListener( event )
	
	--user edits the field
	if ( event.phase == "began" ) then

		--clear the numeric field
		event.target.text = ""

	elseif event.phase == "submitted" then

		-- if answer is input and enter key is pressed update variable with user's answer
		userAnswer = tonumber(event.target.text)

		--clear field
		event.target.text = ""

		-- if the user's answer and the correct answer are the same
		if (userAnswer == rightAnswer) then

			-- show correct text
			correctText.isVisible = true

			-- hide correct text
			timer.performWithDelay(2500, HideCorrect)

			--reset timer
			secondsLeft = totalSeconds

			--add a point 
			points = points + 1

			-- call win function
			Win()

			--pick a random number that determines the sound played
			RandomSoundChooser()
			if (randomSound == 1) then
				correctSoundChannel = audio.play(correctSound1)
			elseif (randomSound == 2) then
				correctSoundChannel = audio.play(correctSound2)
			elseif (randomSound == 3) then 
				correctSoundChannel = audio.play(correctSound3)
			end
		else

			-- if the user's answer is different from the correct answer

			-- show incorrect text
			incorrectText.isVisible = true

			--hide incorrect text
			timer.performWithDelay(2500, HideIncorrect)

			--reset timer
			secondsLeft = totalSeconds

			--take away a life
			lives = lives - 1

			--call the LoseLives function	
			LoseLives()

			--pick a random number that determines the sound played
			RandomSoundChooser()
			if (randomSound == 1) then
				incorrectSoundChannel = audio.play(incorrectSound1)
			elseif (randomSound == 2) then
				incorrectSoundChannel = audio.play(incorrectSound2)
			elseif (randomSound == 3) then 
				incorrectSoundChannel = audio.play(incorrectSound3)
			end

			-- update incorrect text to display the correct answer
			incorrectText.text = "     Nope, Sorry! \n We were lookin' for: \n              " .. rightAnswer
		end
	end
end

-- function that updates the timer
local function UpdateTime()

	--decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = "Time Left: " .. secondsLeft

	-- if the timer runs out
	if (secondsLeft == 0 ) then

		-- reset the number of seconds left 
		secondsLeft = totalSeconds

		-- take away a life
		lives = lives - 1

		--call the LoseLives function
		LoseLives()

		--pick a random number that determines the sound played
		RandomSoundChooser()
		if (randomSound == 1) then
			incorrectSoundChannel = audio.play(incorrectSound1)
		elseif (randomSound == 2) then
			incorrectSoundChannel = audio.play(incorrectSound2)
		elseif (randomSound == 3) then 
			incorrectSoundChannel = audio.play(incorrectSound3)
		end

		-- update incorrect text to display the correct answer
		incorrectText.text = "Nope, Sorry! \n We were lookin' for: \n" .. rightAnswer

		-- make the incorrect text visible 
		incorrectText.isVisible = true

		-- hide the incorrect text
		timer.performWithDelay(2500, HideIncorrect)
	end
end

-- function that calls the timer
local function StartTimer()
	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0 )
end

-----------------------------------------------------------------------------------------
-- OBJECT CREATION
-----------------------------------------------------------------------------------------

-- create the question text
questionText = display.newText("", display.contentWidth/3.5, display.contentHeight/3, nil, 50)
-- set the colour of the question text
questionText:setTextColor( 1,1,1 )
-- create the numeric field
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/3, 200, 80 )
-- this is unnecessary but just in case :)
numericField.inputType = "decimal"
-- makes the numeric field function
numericField:addEventListener( "userInput", NumericFieldListener )


-- create the correct text 
correctText = display.newText( "Yup, You Got It!", display.contentWidth/2, display.contentHeight*1.5/3, nil, 50 )
-- change the colour of the correct text
correctText:setTextColor( 58/255, 227/255, 17/255 )
-- make the text invisible
correctText.isVisible = false


-- make the incorrect text
incorrectText = display.newText( "", display.contentWidth/2, display.contentHeight*1.6/3, nil, 50 )
-- set the colour of the text
incorrectText:setTextColor( 234/255, 16/255, 16/255  )
-- make the text invisible
incorrectText.isVisible = false


-- create the first heart 
heart1 = display.newImageRect("Images/life.png", 100, 100)
-- set it's x and y position
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7


-- create the second heart 
heart2 = display.newImageRect("Images/life.png", 100, 100)
--set it's x and y position
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7


-- create the third heart 
heart3 = display.newImageRect("Images/life.png", 100, 100)
-- set it's x and y position
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7


-- create the clock text
clockText = display.newText("Time Left: ", 200, 100, nil, 50)
-- change it's colour
clockText:setTextColor(0,1,1)
-- make the clock text visible
clockText.isVisible = true


-- create the lose text
loseText = display.newText(" HAHAHAHAHAHA\n HAHAHAHAHAHA\n HAHAHAHAHAHA", 
	display.contentWidth/2, display.contentHeight/2, nil, 100)
-- make the lose text invisible
loseText.isVisible = false
-- set the colour of the text
loseText:setTextColor( 182/255, 0/255, 255/255 )


-- create the lose image 
loseImage = display.newImageRect("Images/loseimage.png", 325, 400)
--set it's x and y positions
loseImage.x = display.contentWidth/2
loseImage.y = 0
-- make it invisible
loseImage.isVisible = false


--create the win text
winText = display.newText(" YAAAAAAAAAAA\n AAAAAAAAAAAA\n AAAAAAAAAAAY", 
	display.contentWidth/2, display.contentHeight/2, nil, 100)
-- make the win text invisible
winText.isVisible = false
-- set the colour of the win text 
winText:setTextColor( 6/255, 240/255, 215/255 )


-- create the win image 
winImage = display.newImageRect("Images/winimage.png", 320, 518)
-- set it's x and y positions
winImage.x = display.contentWidth/2
winImage.y = 0
-- make it invisible
winImage.isVisible = false


-----------------------------------------------------------------------------------------
-- FUNCTION CALLS
-----------------------------------------------------------------------------------------

--call the AskQuestion function
AskQuestion()

-- call the StartTimer function
StartTimer()

-- call the LoseLives function 
LoseLives()

-- call the win function 
Win()