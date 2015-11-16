gravityPoints = objects = world = void

init = ->
  window.b2Vec2 = Box2D.Common.Math.b2Vec2
  b2BodyDef = Box2D.Dynamics.b2BodyDef
  b2Body = Box2D.Dynamics.b2Body
  b2FixtureDef = Box2D.Dynamics.b2FixtureDef
  b2Fixture = Box2D.Dynamics.b2Fixture
  b2World = Box2D.Dynamics.b2World
  b2MassData = Box2D.Collision.Shapes.b2MassData
  b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape
  b2CircleShape = Box2D.Collision.Shapes.b2CircleShape
  b2DebugDraw = Box2D.Dynamics.b2DebugDraw
  world := new b2World(new b2Vec2(0, 0), true)
  window.world = world
  /*fixDef = new b2FixtureDef
  fixDef.density = 1.0
  fixDef.friction = 0.5
  fixDef.restitution = 0.2
  bodyDef = new b2BodyDef

  #create ground
  bodyDef.type = b2Body.b2_staticBody
  bodyDef.position.x = 10
  bodyDef.position.y = 13
  fixDef.shape = new b2PolygonShape
  fixDef.shape.SetAsBox 16, 0.5
  world.CreateBody(bodyDef).CreateFixture fixDef*/

  gravityPoints := [ new GravityPoint world, [8, 8], 2, 0.5 ]

  objects := for j from 1 to 10 => new Figure world, [Math.random!*10,Math.random!*10], [0.3,0.3], new b2Vec2 Math.random()*2, Math.random()*2
  window.abc = objects.0
  #obj = new Figure world, [2,5] [1,2], new b2Vec2 10, 5
  #create some objects
  #bodyDef.type = b2Body.b2_dynamicBody
  #i = 0
  /*while i < 10
    if Math.random() > 0.5
      fixDef.shape = new b2PolygonShape
      fixDef.shape.SetAsBox Math.random() + 0.1, Math.random() + 0.1
    else
      fixDef.shape = new b2CircleShape(Math.random() + 0.1)
    bodyDef.position.x = Math.random() * 10
    bodyDef.position.y = Math.random() * 10
    bodyDef.gravity = 10
    window.body =  world.CreateBody(bodyDef)
     ..CreateFixture fixDef

    ++i*/
  #setup debug draw
  debugDraw = new b2DebugDraw
  debugDraw.SetSprite document.getElementById('canvas').getContext('2d')
  debugDraw.SetDrawScale 30.0
  debugDraw.SetFillAlpha 0.3
  debugDraw.SetLineThickness 1.0
  debugDraw.SetFlags b2DebugDraw.e_shapeBit .|. b2DebugDraw.e_jointBit
  world.SetDebugDraw debugDraw
  window.setInterval update, 1000 / 60
  return

update = ->
  objects |> map (-> it.body.ApplyForce(gravityPoints.0.get-object-gravity-vector(it), it.body.GetWorldCenter! ))
#  console.log gravityPoints.0.get-object-gravity-vector(objects.0)

  world.Step 1 / 60, 10, 10
  world.DrawDebugData()
  world.ClearForces()
  return


window.onload = init
