-----------------------------------------------------------------------------------------
--
-- main.lua
--By Davin Rousseau
--Made on Apr 25th 2019
-- Program is Assignment 5
-----------------------------------------------------------------------------------------
local scrollSpeed = 50

local addPoints = 0

local pointsText = display.newText("Points:", 100, 100 )
pointsText.x= 100
pointsText.y= -100
pointsText:setFillColor(0,255,0)

local Background = display.newImageRect( "assets/Background.png",600, 600 )
Background.x = 100
Background.y = 250

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 5) -- ( x, y )


--dpads/controls 
local dPad = display.newImageRect( "assets/d-pad.png", 100, 80 )
dPad.x = 270
dPad.y = 450
dPad.id = "d-pad"

local upArrow = display.newImageRect( "assets/upArrow.png", 30, 20 )
upArrow.x = 270
upArrow.y = 420
upArrow.id = "up arrow"

local downArrow = display.newImageRect( "assets/downArrow.png", 30, 20 )
downArrow.x = 270
downArrow.y = 480
downArrow.id = "down arrow"

local leftArrow = display.newImageRect( "assets/leftArrow.png", 30, 20 )
leftArrow.x = 240
leftArrow.y = 450
leftArrow.id = "left arrow"

local rightArrow = display.newImageRect( "assets/rightArrow.png", 30, 20 )
rightArrow.x = 300
rightArrow.y = 450
rightArrow.id = "right arrow"

local jumpButton = display.newImageRect( "assets/jumpButton.png", 30, 30 )
jumpButton.x = 270
jumpButton.y = 450
jumpButton.id = "jump button"
jumpButton.alpha = 1

--Walls/Borders
local leftWall = display.newRect( 1, 20, 2, 967 )
leftWall.alpha = 0
physics.addBody( leftWall, "static", { 
    friction = 1.5, 
    bounce = 0.
    } )

local rightWall = display.newRect( 335, 20, 2, 1600  )
rightWall.alpha = 0
physics.addBody( rightWall, "static", { 
    friction = 1.5, 
    bounce = 0.
    } )

local bottomWall = display.newRect( 0, 530, 5000, 1, display.contentHeight )
bottomWall.alpha = 0
physics.addBody( bottomWall, "static", { 
    friction = 1.5, 
    bounce = 0.
    } )

--Player and enemies
local PlayerBalloon = display.newImageRect( "assets/AirBalloon.png",120, 120 )
PlayerBalloon.x = 150
PlayerBalloon.y = 450
PlayerBalloon.id = "Player Balloon"
physics.addBody( PlayerBalloon, "dynamic", { 
    density = 5.0, 
    friction = 0.5, 
    bounce = 0.1 
    } )
PlayerBalloon.isFixedRotation = true

local asteroid1 = display.newImageRect( "assets/asteroid1.png",120, 100 )
asteroid1.x = 150
asteroid1.y = -550
asteroid1.id = "asteroid1"
physics.addBody( asteroid1, "static", { 
    density = 3.0, 
    friction = 0.7, 
    bounce = 0.3 
    } )

local asteroid2 = display.newImageRect( "assets/asteroid2.png",130, 100 )
asteroid2.x = 90
asteroid2.y = -450
asteroid2.id = "asteroid2"
physics.addBody( asteroid2, "static", { 
    density = 3.0, 
    friction = 0.7, 
    bounce = 0.3 
    } )

local asteroid3 = display.newImageRect( "assets/asteroid3.png",130, 100 )
asteroid3.x = 190
asteroid3.y = -650
asteroid3.id = "asteroid3"
physics.addBody( asteroid3, "static", { 
    density = 3.0, 
    friction = 0.7, 
    bounce = 0.3 
    } )

local asteroid4 = display.newImageRect( "assets/asteroid4.png",130, 100 )
asteroid4.x = 260
asteroid4.y = -450
asteroid4.id = "asteroid4"
physics.addBody( asteroid4, "static", { 
    density = 3.0, 
    friction = 0.7, 
    bounce = 0.3 
    } )

-- Powerup for points
local powerup = display.newImageRect( "assets/powerup.png",130, 100 )
powerup.x = 150
powerup.y = -700
powerup.id = "powerup"
physics.addBody( powerup, "static", { 
    density = 3.0, 
    friction = 0.7, 
    bounce = 0.3 
    } )

-- dpad functions
function upArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( PlayerBalloon, { 
        	x = 0, -- move 0 in the x direction 
        	y = -20, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function downArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy(PlayerBalloon, { 
        	x = 0, -- move 0 in the x direction 
        	y = 20, -- move down 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function leftArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( PlayerBalloon, { 
        	x = -20, -- move 50 pixels in the x direction "left" 
        	y = 0, -- move 0 pixels in y direction
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function rightArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( PlayerBalloon, { 
        	x = 20, -- move 50 pixels in the x direction "right" 
        	y = 0, -- move 0 pixels in y direction
        	time = 100 -- move in a 1/10 of a second
        	} )
    end
    

    return true
end

function jumpButton:touch( event )
    if ( event.phase == "ended" ) then
        -- make the character jump
        PlayerBalloon:setLinearVelocity( 0, -150 )
    end

    return true
end

-- moving enemies functions
function MoveImage(event)
	asteroid1.y = asteroid1.y + scrollSpeed
end

function MoveImage2(event)
	asteroid2.y = asteroid2.y + scrollSpeed
end

function MoveImage3(event)
	asteroid3.y = asteroid3.y + scrollSpeed
end

function MoveImage4(event)
	asteroid4.y = asteroid4.y + scrollSpeed
end

--move powerup function
function MovePowerup(event)
	powerup.y = powerup.y + scrollSpeed
end

-- collision function
function EnemyCollision(event)
	 if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
       
 
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": collision ended with " .. event.other.id )
    end
end

upArrow:addEventListener( "touch", upArrow )
downArrow:addEventListener( "touch", downArrow )
leftArrow:addEventListener( "touch", leftArrow )
jumpButton:addEventListener( "touch", jumpButton )
rightArrow:addEventListener( "touch", rightArrow )



PlayerBalloon.collision = EnemyCollision
PlayerBalloon:addEventListener( "collision" )