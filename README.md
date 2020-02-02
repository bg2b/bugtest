# bugtest
Test of iOS 13 physics body from texture bug avoidance

The issue: starting in iOS 13, SpriteKit's method for creating conforming physics bodies from textures
broke.  Sometimes it would give incorrect physics bodies, sometimes it would just fail to produce a
physics body at all.  It's been patched somewhat over time.  Various workarounds have also been
suggested.  This project shows some of the workarounds to check what currently works and what doesn't.

Built using Xcode version 11.3 (11C29)

Running this on an iPad Pro 11-inch (3rd generation, 2018), iOS versions 13.3 and 13.3.1
produces this console output:

```
2020-02-01 06:23:51.872975-0500 bugtest[14399:9898087] PhysicsBody: Could not create physics body.
simple atlas reference failed
2020-02-01 06:23:51.886387-0500 bugtest[14399:9898087] PhysicsBody: Could not create physics body.
atlas force load failed
2020-02-01 06:23:51.913927-0500 bugtest[14399:9898087] PhysicsBody: Could not create physics body.
reconstruct via cgImage failed
re-render using view worked
not in atlas worked
```

Here's a screen shot with the different attempts:

![Screen shot](images/screenshot.jpeg)

Summary: if you're running into this bug, you can avoid it either by creating the physics body from
a texture that's not part of an atlas, or by re-rendering the sprite to produce a new texture and
making the physics body from the rendered texture.

You will probably want to use atlas versions of textures for the sprites to keep the draw count
down.  Just make the physics bodies from one of these methods.  If you need lots of copies of a
physics body, you can save it and make copies with the (semi-undocumented) `copy()` method:
```
var bodies = [SKTexture: SKPhysicsBody]() // Cache of physics bodies
...
if let body = bodies[texture] {
  return body.copy() as! SKPhysicsBody
} else {
  // Create newBody using one of the working methods...
  bodies[texture] = newBody
  return newBody
}
```
