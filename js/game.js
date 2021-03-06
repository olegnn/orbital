// Generated by LiveScript 1.4.0
(function(){
  var b2Object, GravityPoint, Figure, out$ = typeof exports != 'undefined' && exports || this;
  b2Object = {
    spawn: function(world){
      this.body = this.world.CreateBody(this.b2.bodyDef);
      return this.fixture = this.body.CreateFixture(this.b2.fixDef);
    }
  };
  out$.GravityPoint = GravityPoint = (function(){
    GravityPoint.displayName = 'GravityPoint';
    var prototype = GravityPoint.prototype, constructor = GravityPoint;
    importAll$(prototype, arguments[0]);
    function GravityPoint(world, position, radius, gravityPower){
      var x$, ref$, y$;
      this.world = world;
      this.gravityPower = gravityPower;
      this.b2 = {};
      x$ = this.b2.bodyDef = new Box2D.Dynamics.b2BodyDef;
      x$.type = Box2D.Dynamics.b2Body.b2_staticBody;
      (ref$ = x$.position)['x'] = position[0], ref$['y'] = position[1];
      y$ = this.b2.fixDef = new Box2D.Dynamics.b2FixtureDef;
      y$.shape = new Box2D.Collision.Shapes.b2CircleShape(radius);
      this.spawn();
    }
    prototype.getObjectGravityVector = function(obj){
      var vec, forceValue, maxForceValue, x$, forceVec;
      vec = clone$(this.body.GetWorldCenter());
      vec.Subtract(obj.body.GetWorldCenter());
      forceValue = obj.body.GetMass() * this.gravityPower / vec.LengthSquared();
      maxForceValue = obj.body.GetMass() * this.gravityPower;
      x$ = forceVec = new Box2D.Common.Math.b2Vec2(1, 1);
      x$.x = Math.pow(-1, +(vec.x < 0)) * forceValue * Math.abs(vec.x / vec.y);
      x$.y = Math.pow(-1, +(vec.y < 0)) * forceValue * Math.abs(vec.y / vec.x);
      console.log(vec.Length());
      return forceVec;
    };
    return GravityPoint;
  }(b2Object));
  out$.Figure = Figure = (function(){
    Figure.displayName = 'Figure';
    var prototype = Figure.prototype, constructor = Figure;
    importAll$(prototype, arguments[0]);
    function Figure(world, position, size, impulse){
      var x$, ref$, y$;
      this.world = world;
      this.b2 = {};
      x$ = this.b2.bodyDef = new Box2D.Dynamics.b2BodyDef;
      x$.type = Box2D.Dynamics.b2Body.b2_dynamicBody;
      (ref$ = x$.position)['x'] = position[0], ref$['y'] = position[1];
      y$ = this.b2.fixDef = new Box2D.Dynamics.b2FixtureDef;
      y$.shape = new Box2D.Collision.Shapes.b2PolygonShape;
      y$.shape.SetAsBox(size[0], size[1]);
      this.spawn();
      this.body.ApplyImpulse(impulse, this.body.GetPosition());
    }
    return Figure;
  }(b2Object));
  function importAll$(obj, src){
    for (var key in src) obj[key] = src[key];
    return obj;
  }
  function clone$(it){
    function fun(){} fun.prototype = it;
    return new fun;
  }
}).call(this);
