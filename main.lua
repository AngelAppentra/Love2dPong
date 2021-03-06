--Basic pong love2d tutorial

local player_x=0
local player_y=0
local cpu_x=0
local cpu_y=0
local ball_x=0
local ball_y=0
local ball_mov=0

local ball_rad=10
local rectangleh=60
local rectanglew=20
local gameOver=false
local ball_delta_y=0

function love.load()
  player_x=80
  player_y=300

  cpu_x=700
  cpu_y=300

  ball_x=200
  ball_y=300
  ball_mov=1

  gameOver=false
end



function love.update(dt)
  local step=200*dt
  local x_contained=false
  local y_contained=false
  local x1A=0
  local x2A=0
  local x1B=0
  local x2B=0
  local y1A=0
  local y2A=0
  local y1B=0
  local y2B=0
  local delta_y_player=0
  local delta_y_cpu=0

  if gameOver==true then
    return nil
  end
  --implement player movement
  if love.keyboard.isDown("up") then
    if player_y-step > 0 then
      player_y=player_y-step  
      delta_y_player=-0.5  
    end
  end
  if love.keyboard.isDown("down") then
    if player_y+step+rectangleh< 600 then
      player_y=player_y+step
      delta_y_player=0.5
    end
  end
  
  --implement cpu movement
  if math.abs(cpu_y-ball_y)>0 then
    if cpu_y>ball_y then
      if cpu_y-step > 0 then 
        cpu_y=cpu_y-step
        delta_y_cpu=-0.5
      end
    else
      if cpu_y+step<600 then
        cpu_y=cpu_y+step
        delta_y_cpu=0.5
      end
    end
  end
  
  --implement ball movement collision checks...
  ball_x=ball_x+step*ball_mov
  ball_y=ball_y+ball_delta_y

  x1A=ball_x
  x2A=ball_x+ball_rad
  y1A=ball_y
  y1B=ball_y+ball_rad

    --collision with cpu
  x1B=cpu_x
  x2B=cpu_x+rectanglew
  y1B=cpu_y
  y2B=cpu_y+rectangleh

   x_contained=(( x1B>=x1A and x1B<=x2A ) or (x2B>=x1A and x2B<=x2A) ) or (( x1A>=x1B and x1A<=x2B ) or (x2A>=x1B and x2A<=x2B) )
   y_contained=(( y1B>=y1A and y1B<=y2A ) or (y2B>=y1A and y2B<=y2A) ) or (( y1A>=y1B and y1A<=y2B ) or (y2A>=y1B and y2A<=y2B) )

  if x_contained and y_contained then
    ball_mov=ball_mov*-1
    ball_delta_y=delta_y_cpu
  end

--collision with player
    x1B=player_x
    x2B=player_x+rectanglew
    y1B=player_y
    y2B=player_y+rectangleh


   
   x_contained=(( x1B>=x1A and x1B<=x2A ) or (x2B>=x1A and x2B<=x2A) ) or (( x1A>=x1B and x1A<=x2B ) or (x2A>=x1B and x2A<=x2B) )
   y_contained=(( y1B>=y1A and y1B<=y2A ) or (y2B>=y1A and y2B<=y2A) ) or (( y1A>=y1B and y1A<=y2B ) or (y2A>=y1B and y2A<=y2B) )
   
   if x_contained and y_contained then
    ball_mov=ball_mov*-1
    ball_delta_y=delta_y_player
   end

   if ball_x<0 or ball_x>800 then
      gameOver=true
   end
   if ball_y<0 or ball_y>600 then
      gameOver=true
   end


end

function love.draw()

  if gameOver then
    love.graphics.print("GameOver!!", 400, 200)
    return nil
  end
  --draw player
  love.graphics.rectangle( "fill", player_x, player_y, rectanglew, rectangleh )

  --draw cpu
  love.graphics.rectangle( "fill", cpu_x, cpu_y, rectanglew, rectangleh )

   --draw ball
   love.graphics.circle( "fill", ball_x, ball_y, ball_rad, 100 )
end

function love.keypressed(key, unicode)

    
end
