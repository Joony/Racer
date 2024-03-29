package ch.forea.racer {
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;
	
	public class Car extends Sprite {
		
		private static const RADIAN_CONVERSION:Number = 0.0174532925;
		
		protected var acceleration:Number = 1.05;
		protected var deceleration:Number = .86;
		protected var friction:Number = .96;
		protected var rotationStep:uint = 5;
		protected var maximumSpeed:uint = 8;
		protected var maximumReverseSpeed:uint = 4;
		protected var minimumSpeed:Number = .3;
		
		private var odometer:Number = 0;
		
		private var velocity:Number = 0; 
		private var pointTop:Point;
		private var pointRight:Point;
		private var pointBottom:Point;
		private var pointLeft:Point;
		
		public function Car (width:uint = 24, height:uint = 35, offset:uint = 5) {
			// Calculate the positions of the collision points.
			this.pointTop = new Point(0, -(height / 2 + offset));
			this.pointRight = new Point(width / 2, -offset);
			this.pointBottom = new Point(0, (height / 2 - offset));
			this.pointLeft = new Point(-(width / 2), -offset);
			
			// Draw a debug graphic.
			this.graphics.beginFill(0xff00ff);
			this.graphics.drawRect(-(width / 2), -(height / 2 + offset), width, height);
			
			// Draw the collision points for debugging.
			this.graphics.beginFill(0x00ffff);
			this.graphics.drawCircle(pointTop.x, pointTop.y, 3);
			this.graphics.drawCircle(pointRight.x, pointRight.y, 3);
			this.graphics.drawCircle(pointBottom.x, pointBottom.y, 3);
			this.graphics.drawCircle(pointLeft.x, pointLeft.y, 3);
		}
		
		public function move (direction:Number, acceleratorPressed:Boolean, brakePressed:Boolean):void {
			// TODO Check to see if direction is a normalised number between -1 and 1
			
			if (acceleratorPressed && this.velocity < this.maximumSpeed) {
				if (this.velocity * this.acceleration > this.maximumSpeed) // About to hit the maximum forward speed.
					this.velocity = this.maximumSpeed;
				else if (this.velocity >= this.minimumSpeed) // At or going faster than the forward minimum speed.
					this.velocity *= this.acceleration;
				else if (this.velocity == 0) // Not moving.
					this.velocity = this.minimumSpeed;
				else  if (this.velocity <= -this.minimumSpeed) // At or going faster than the minumum backwards speed. 
					this.velocity *= this.deceleration;
				else if (this.velocity < 0 && this.velocity > -this.minimumSpeed) // Going forward but below the minimum speed.
					this.velocity = 0;
			}
			
			if (brakePressed && this.velocity > -this.maximumReverseSpeed) {
				if (this.velocity * this.acceleration < -this.maximumReverseSpeed) // About to hit the maximum reverse speed.
					this.velocity = -this.maximumReverseSpeed;
				else if (this.velocity >= this.minimumSpeed) // At or going faster than the forward minimum speed.
					this.velocity *= this.deceleration;
				else  if (this.velocity <= -this.minimumSpeed) // At or going faster than the minumum backwards speed. 
					this.velocity *= this.acceleration;
				else if (this.velocity > 0 && this.velocity < this.minimumSpeed) // Going forward but below the minimum speed.
					this.velocity = 0;
				else if (this.velocity == 0) // Not moving.
					this.velocity = -this.minimumSpeed;
			}
			
			if (!acceleratorPressed && !brakePressed) {
				if (this.velocity > this.minimumSpeed || this.velocity < -this.minimumSpeed)
					this.velocity *= this.friction;
				else
					this.velocity = 0;
			}
			
			// Move the car.
			this.rotation += (rotationStep * direction) * (this.velocity / this.maximumSpeed);
			this.x += Math.sin(this.rotation * (RADIAN_CONVERSION)) * this.velocity;
			this.y += Math.cos(this.rotation * (RADIAN_CONVERSION)) * this.velocity * -1;
			
			// Keep track of how far the car has travelled.
			this.odometer += this.velocity;
			//trace((((this.odometer / 35) * 5) / 1000) * .621 + " Miles, " + ((((this.velocity / 35) * 5) / 1000) * .621) * 60 * 60 * 60 + " MPH");
		}
		
		public function get globalTopPoint ():Point {
			return this.localToGlobal(pointTop);
		}
		
		public function get globalRightPoint ():Point {
			return this.localToGlobal(pointRight);
		}
		
		public function get globalBottomPoint ():Point {
			return this.localToGlobal(pointBottom);
		}
		
		public function get globalLeftPoint ():Point {
			return this.localToGlobal(pointLeft);
		}
		
	}
	
	/*
	collisionDistance# = c\radius+c2\radius
	actualDistance# = Sqr((c2\x-c\x)^2+(c2\y-c\y)^2)
	
	;Collided or not?
	If actualDistance<collisionDistance Then
	
	collNormalAngle#=ATan2(c2\y-c\y, c2\x-c\x)
	
	;Position exactly touching, no intersection
	moveDist1#=(collisionDistance-actualDistance)*(c2\mass/Float((c\mass+c2\mass)))
	moveDist2#=(collisionDistance-actualDistance)*(c\mass/Float((c\mass+c2\mass)))
	c\x=c\x + moveDist1*Cos(collNormalAngle+180)
	c\y=c\y + moveDist1*Sin(collNormalAngle+180)
	c2\x=c2\x + moveDist2*Cos(collNormalAngle)
	c2\y=c2\y + moveDist2*Sin(collNormalAngle)
	
	
	;------------------------------------------
	;COLLISION RESPONSE
	;------------------------------------------
	;n = vector connecting the centers of the circles.
	;we are finding the components of the normalised vector n
	nX#=Cos(collNormalAngle)
	nY#=Sin(collNormalAngle)
	
	;now find the length of the components of each movement vectors
	;along n, by using dot product.
	a1# = c\dx*nX  +  c\dy*nY
	a2# = c2\dx*nX +  c2\dy*nY
	
	;optimisedP = 2(a1 - a2)
	;             ----------
	;              m1 + m2
	optimisedP# = (2.0 * (a1-a2)) / (c\mass + c2\mass)
	
	;now find out the resultant vectors
	;r1 = c1\v - optimisedP * mass2 * n
	c\dx = c\dx - (optimisedP*c2\mass*nX)
	c\dy = c\dy - (optimisedP*c2\mass*nY)
	
	;r2 = c2\v - optimisedP * mass1 * n
	c2\dx = c2\dx + (optimisedP*c\mass*nX)
	c2\dy = c2\dy + (optimisedP*c\mass*nY)
	
	End If
	*/
	
}
