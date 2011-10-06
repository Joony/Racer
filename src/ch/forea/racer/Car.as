package ch.forea.racer {
	
	import flash.display.Sprite;
	
	public class Car extends Sprite {
		
		private static const RADIAN_CONVERSION:Number = 0.0174532925;
		
		protected var acceleration:Number = 1.05;
		protected var deceleration:Number = .9;
		protected var friction:Number = .96;
		protected var rotationStep:uint = 5;
		protected var maximumSpeed:uint = 8;
		protected var maximumReverseSpeed:uint = 3;
		protected var minimumSpeed:Number = .3
		
		private var velocity:Number = 0; 
		
		public function Car () {
			this.graphics.beginFill(0xff00ff);
			this.graphics.drawRect(-10, -25, 20, 35);
		}
		
		public function move (direction:Number, acceleratorPressed:Boolean, brakePressed:Boolean):void {
			// TODO Check to see if direction is a normalised number between -1 and 1
			
			if (acceleratorPressed && velocity < this.maximumSpeed) {
				if (this.velocity * this.acceleration > this.maximumSpeed)
					this.velocity = this.maximumSpeed;
				else if (this.velocity < this.minimumSpeed)
					this.velocity = this.minimumSpeed;
				else
					this.velocity *= this.acceleration;
			}
			
			if (brakePressed) {
				if (this.velocity > this.minimumSpeed || this.velocity < -this.minimumSpeed)
					this.velocity *= this.deceleration;
				else
					this.velocity = 0;
			}
			
			if (!acceleratorPressed && !brakePressed) {
				if (this.velocity > this.minimumSpeed || this.velocity < -this.minimumSpeed)
					this.velocity *= this.friction;
				else
					this.velocity = 0;
			}
			
			
			this.rotation += (rotationStep * direction) * (this.velocity / this.maximumSpeed);
			
			this.x += Math.sin(this.rotation * (RADIAN_CONVERSION)) * this.velocity;
			this.y += Math.cos(this.rotation * (RADIAN_CONVERSION)) * this.velocity * -1;
			
		}
		
	}
	
}
