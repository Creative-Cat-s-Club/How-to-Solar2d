-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	composer.gotoScene( "level1", "fade", 500 )
	
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view
		backGroup = display.newGroup()  
		sceneGroup:insert( backGroup )  

		mainGroup = display.newGroup()  
		sceneGroup:insert( mainGroup )

		uiGroup = display.newGroup() 
		sceneGroup:insert( uiGroup )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	
	--[[

	local background = display.newImageRect( "background.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "logo.png", 264, 42 )
	titleLogo.x = display.contentCenterX
	titleLogo.y = 100
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label = "Play Now",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "button.png",
		overFile = "button-over.png",
		width = 154, height = 40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentCenterX
	playBtn.y = display.contentHeight - 125
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( playBtn )

	]]--

	width = 160
	height = 160

	sky = display.newImageRect("bg/sky.png",1000, 500)
	sky.x = display.contentCenterX
	sky.y = display.contentCenterY/2

	clouds = display.newImageRect("bg/cloud.png",1000, 500)
	clouds.x = display.contentCenterX * 5
	clouds.y = display.contentCenterY/2

	ground = display.newImageRect("bg/bg1.png",500, 300)
	ground.x = display.contentCenterX
	ground.y = display.contentCenterY*2

	hero = display.newImageRect("character/boy.png",width,height)

	--Position that boi
	hero.x = display.contentCenterX
	hero.y = display.contentCenterY

	hero.myName = "hero"
	hero.kind = "character"
	hero.isAlive = true
	hero.health = 100
	hero.shield = 100
	hero.damage = 20
	hero.experience = 0
	

	local function moveClouds()
		if clouds.x < display.screenOriginX - 500 then
			clouds.x = display.viewableContentWidth*3
		end	
		
		transition.to(clouds, {time = 1000, x = clouds.x - 50})
	end
 
	local time = 1000 -- 1000 is 1 second
	loops = 0 -- 0 means infinite

	timer.performWithDelay(1000, moveClouds, 0)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
