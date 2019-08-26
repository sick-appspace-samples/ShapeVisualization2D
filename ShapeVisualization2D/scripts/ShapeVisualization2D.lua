--[[----------------------------------------------------------------------------

  Application Name:
  ShapeVisualization2D

  Summary:
  Creation and overlay visualization of various 2D shape types.

  How to Run:
  Starting this sample is possible either by running the app (F5) or
  debugging (F7+F10). Setting breakpoint on the first row inside the 'main'
  function allows debugging step-by-step after 'Engine.OnStarted' event.
  Results can be seen in the image viewer on the DevicePage.
  Restarting the Sample may be necessary to show images after loading the webpage.
  To run this Sample a device with SICK Algorithm API and AppEngine >= V2.5.0 is
  required. For example SIM4000 with latest firmware. Alternatively the Emulator
  in AppStudio 2.3 or higher can be used.

  More Information:
  Tutorial "Algorithms - Data Types".

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

-- Creating viewer
local viewer = View.create()

-- Setting up graphical overlay attributes
local shapeDecoration = View.ShapeDecoration.create()
shapeDecoration:setLineColor(0, 255, 0) -- Green
shapeDecoration:setPointSize(16)
shapeDecoration:setLineWidth(5)
shapeDecoration:setFillColor(0, 255, 0, 60) -- Transparent green

local intersectionDecoration = View.ShapeDecoration.create()
intersectionDecoration:setLineColor(255, 0, 0) -- Red
intersectionDecoration:setPointType('DOT')
intersectionDecoration:setPointSize(16)

local pointDecoration = View.ShapeDecoration.create()
pointDecoration:setLineColor(0, 0, 255) -- Blue
pointDecoration:setPointType('DOT')
pointDecoration:setPointSize(16)

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  local img = Image.create(800, 600, 'UINT16')
  local W, H = img:getSize() -- get image height and width
  img:setAll(0.0)
  viewer:clear()
  local imageID = viewer:addImage(img)
  viewer:present()
  Script.sleep(100)

  -- Line
  local startLine = Point.create(0, 330)
  local endLine = Point.create(W, 50)
  local line = Shape.createLineSegment(startLine, endLine)
  viewer:addShape(line, shapeDecoration, nil, imageID)
  viewer:addShape(startLine, pointDecoration, nil, imageID)
  viewer:addShape(endLine, pointDecoration, nil, imageID)

  -- Circle
  local circleCenter = Point.create(100, 100)
  local circle = Shape.createCircle(circleCenter, 50)
  viewer:addShape(circle, shapeDecoration, nil, imageID)
  viewer:addShape(circleCenter, pointDecoration, nil, imageID)

  -- Ellipse
  local ellipseCenter = Point.create(180, 320)
  local ellipse = Shape.createEllipse(ellipseCenter, 40, 200, 0.7)
  viewer:addShape(ellipse, shapeDecoration, nil, imageID)
  viewer:addShape(ellipseCenter, pointDecoration, nil, imageID)

  -- Intersections between line and ellipse
  local intersections1 = Shape.getIntersectionPoints(line, ellipse)
  for _, point in ipairs(intersections1) do
    viewer:addShape(point, intersectionDecoration, nil, imageID)
  end

  -- Rectangle
  local rectCenter = Point.create(450, 80)
  local rect = Shape.createRectangle(rectCenter, 150, 40, 0.2)
  viewer:addShape(rect, shapeDecoration, nil, imageID)
  viewer:addShape(rectCenter, pointDecoration, nil, imageID)

  -- Polygon
  local polyPoints = {Point.create(600, 200),
                     Point.create(530, 300),
                     Point.create(620, 505),
                     Point.create(650, 250),
                     Point.create(700, 300),
                     Point.create(720, 200)}
  local polygon = Shape.createPolyline(polyPoints, true)
  viewer:addShape(polygon, shapeDecoration, nil, imageID)
  for _, point in ipairs(polyPoints) do
    viewer:addShape(point, pointDecoration, nil, imageID)
  end

  -- Polyline
  local polyPoints2 = {Point.create(395, 300),
                       Point.create(345, 345),
                       Point.create(340, 470),
                       Point.create(430, 550),
                       Point.create(505, 550),}
  local polyline = Shape.createPolyline(polyPoints2, false)
  viewer:addShape(polyline, shapeDecoration, nil, imageID)
  for _, point in ipairs(polyPoints2) do
    viewer:addShape(point, pointDecoration, nil, imageID)
  end

  -- Arc
  local arcCenter = Point.create(550, 460)
  local arc = Shape.createArc(arcCenter, 120, -2.5, 2.5)
  viewer:addShape(arc, shapeDecoration, nil, imageID)
  viewer:addShape(arcCenter, pointDecoration, nil, imageID)

  -- Intersections between polygon and arc
  local intersections2 = Shape.getIntersectionPoints(polygon, arc)
  for _, point in ipairs(intersections2) do
    viewer:addShape(point, intersectionDecoration, nil, imageID)
  end

  -- Sector
  local sectorCenter = Point.create(250, 470)
  local sector = Shape.createSector(sectorCenter, 50, 90, 1.2, 2)
  viewer:addShape(sector, shapeDecoration, nil, imageID)
  viewer:addShape(sectorCenter, pointDecoration, nil, imageID)

  viewer:present()
  print('App finished.')
end

Script.register('Engine.OnStarted', main)

--End of Function and Event Scope--------------------------------------------------
