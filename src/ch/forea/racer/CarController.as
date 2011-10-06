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
		
		private var car:Car;
		
		public function CarController(stage:Stage, car:Car) {
			this.car = car;
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
				case Keyboard.LEFT:
					this.left = true;
					break;
				case Keyboard.RIGHT:
					this.right = true;
					break;
				case Keyboard.UP:
					this.up = true;
					break;
				case Keyboard.DOWN:
					this.down = true;
					break;
			}
		}
		
		private function keyPressedUp(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.LEFT:
					this.left = false;
					break;
				case Keyboard.RIGHT:
					this.right = false;
					break;
				case Keyboard.UP:
					this.up = false;
					break;
				case Keyboard.DOWN:
					this.down = false;
					break;
			}
		}
		
	}
	
}
