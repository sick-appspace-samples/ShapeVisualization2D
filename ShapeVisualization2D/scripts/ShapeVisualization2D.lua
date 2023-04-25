
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

local DELAY = 100 -- ms between each type for demonstration purpose

-- Creating viewer
local viewer = View.create()

-- Setting up graphical overlay attributes
local shapeDecoration = View.ShapeDecoration.create()
shapeDecoration:setPointSize(16):setLineColor(0, 255, 0) -- Green
shapeDecoration:setLineWidth(5):setFillColor(0, 255, 0, 60) -- Transparent green

local intersectionDecoration = View.ShapeDecoration.create()
intersectionDecoration:setLineColor(255, 0, 0) -- Red
intersectionDecoration:setPointType('DOT'):setPointSize(16)

local pointDecoration = View.ShapeDecoration.create():setPointSize(16)
pointDecoration:setPointType('DOT'):setLineColor(0, 0, 255) -- Blue

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  local img = Image.create(800, 600, 'UINT16')
  local W, H = img:getSize() -- get image height and width
  img:setAll(0.0)
  viewer:clear()
  viewer:addImage(img)
  viewer:present()
  Script.sleep(DELAY)

  -- Line
  local startLine = Point.create(0, 330)
  local endLine = Point.create(W, 50)
  local line = Shape.createLineSegment(startLine, endLine)
  viewer:addShape(line, shapeDecoration)
  viewer:addShape(startLine, pointDecoration)
  viewer:addShape(endLine, pointDecoration)

  -- Circle
  local circleCenter = Point.create(100, 100)
  local circle = Shape.createCircle(circleCenter, 50)
  viewer:addShape(circle, shapeDecoration)
  viewer:addShape(circleCenter, pointDecoration)

  -- Ellipse
  local ellipseCenter = Point.create(180, 320)
  local ellipse = Shape.createEllipse(ellipseCenter, 40, 200, 0.7)
  viewer:addShape(ellipse, shapeDecoration)
  viewer:addShape(ellipseCenter, pointDecoration)

  -- Intersections between line and ellipse
  local intersections1 = Shape.getIntersectionPoints(line, ellipse)
  viewer:addShape(intersections1, intersectionDecoration)

  -- Rectangle
  local rectCenter = Point.create(450, 80)
  local rect = Shape.createRectangle(rectCenter, 150, 40, 0.2)
  viewer:addShape(rect, shapeDecoration)
  viewer:addShape(rectCenter, pointDecoration)

  -- Polygon
  local polyPoints = {Point.create(600, 200),
                     Point.create(530, 300),
                     Point.create(620, 505),
                     Point.create(650, 250),
                     Point.create(700, 300),
                     Point.create(720, 200)}
  local polygon = Shape.createPolyline(polyPoints, true)
  viewer:addShape(polygon, shapeDecoration)
  viewer:addShape(polyPoints, pointDecoration)

  -- Polyline
  local polyPoints2 = {Point.create(395, 300),
                       Point.create(345, 345),
                       Point.create(340, 470),
                       Point.create(430, 550),
                       Point.create(505, 550),}
  local polyline = Shape.createPolyline(polyPoints2, false)
  viewer:addShape(polyline, shapeDecoration)
  viewer:addShape(polyPoints2, pointDecoration)

  -- Arc
  local arcCenter = Point.create(550, 460)
  local arc = Shape.createArc(arcCenter, 120, -2.5, 2.5)
  viewer:addShape(arc, shapeDecoration)
  viewer:addShape(arcCenter, pointDecoration)

  -- Intersections between polygon and arc
  local intersections2 = Shape.getIntersectionPoints(polygon, arc)
  viewer:addShape(intersections2, intersectionDecoration)

  -- Sector
  local sectorCenter = Point.create(250, 470)
  local sector = Shape.createSector(sectorCenter, 50, 90, 1.2, 2)
  viewer:addShape(sector, shapeDecoration)
  viewer:addShape(sectorCenter, pointDecoration)

  viewer:present()
  print('App finished.')
end

Script.register('Engine.OnStarted', main)

--End of Function and Event Scope--------------------------------------------------
