b2Object =
  spawn : (world) ->
    @body = @world.CreateBody(@b2.bodyDef)
    @fixture = @body.CreateFixture(@b2.fixDef)


export class GravityPoint implements b2Object
  (@world, position, radius, @gravity-power) ->
    @b2 = {}
    @b2.bodyDef = new Box2D.Dynamics.b2BodyDef
        ..type = Box2D.Dynamics.b2Body.b2_staticBody
        ..position<[x y]> = position
    @b2.fixDef = new Box2D.Dynamics.b2FixtureDef
        ..shape = new Box2D.Collision.Shapes.b2CircleShape radius
    @spawn!

  get-object-gravity-vector : (obj) ->

    vec = ^^@body.GetWorldCenter!
    vec.Subtract obj.body.GetWorldCenter!

    forceValue = obj.body.GetMass! * @gravity-power / vec.LengthSquared!
    maxForceValue =  obj.body.GetMass! * @gravity-power
    forceVec = new Box2D.Common.Math.b2Vec2 1, 1
      ..x = (-1) ** +(vec.x < 0) * forceValue * Math.abs(vec.x/vec.y)
      ..y = (-1) ** +(vec.y < 0) * forceValue * Math.abs(vec.y/vec.x)
    console.log vec.Length!
    forceVec
    #new Box2D.Common.Math.b2Vec2(objCenter.x - gravCenter.x, objCenter.y - gravCenter.y)


export class Figure implements b2Object
  (@world, position, size, impulse) ->
    @b2 = {}
    @b2.bodyDef = new Box2D.Dynamics.b2BodyDef
      ..type = Box2D.Dynamics.b2Body.b2_dynamicBody
      ..position<[x y]> = position

    @b2.fixDef = new Box2D.Dynamics.b2FixtureDef
      ..shape = new Box2D.Collision.Shapes.b2PolygonShape
      ..shape.SetAsBox size.0, size.1

    @spawn!
    @body.ApplyImpulse impulse, @body.GetPosition!
