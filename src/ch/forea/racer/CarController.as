package ch.forea.racer {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class CarController {
		
		private var up:Boolean = false;
		private var down:Boolean = false;
		private var left:Boolean = false;
		private var right:Boolean = false;
		
		private var upKey:uint;
		private var downKey:uint;
		private var leftKey:uint;
		private var rightKey:uint;
		
		private var car:Car;
		
		public function CarController(stage:Stage, car:Car, upKey:uint = Keyboard.UP, downKey:uint = Keyboard.DOWN, leftKey:uint = Keyboard.LEFT, rightKey:uint = Keyboard.RIGHT) {
			this.car = car;
			this.upKey = upKey;
			this.downKey = downKey;
			this.leftKey = leftKey;
			this.rightKey = rightKey;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			stage.addEventListener(Event.ENTER_FRAME, moveCar);
		}
		
		private function moveCar(event:Event):void {
			var direction:Number = left ? -1 : right ? 1 : 0;
			this.car.move(direction, up, down);
		}
		
		private function keyPressedDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case leftKey:
					this.left = true;
					break;
				case rightKey:
					this.right = true;
					break;
				case upKey:
					this.up = true;
					break;
				case downKey:
					this.down = true;
					break;
			}
		}
		
		private function keyPressedUp(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case leftKey:
					this.left = false;
					break;
				case rightKey:
					this.right = false;
					break;
				case upKey:
					this.up = false;
					break;
				case downKey:
					this.down = false;
					break;
			}
		}
		
	}
	
}
