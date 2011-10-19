package {
	
	import ch.forea.racer.Car;
	import ch.forea.racer.CarController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	[SWF(width='1024', height='768', backgroundColor='#000000', frameRate='60')]
	public class Racer extends Sprite {
		
		private var cars:Vector.<CarController> = new Vector.<CarController>();
		
		public function Racer() {
			var car:Car = new Car();
			var controller:CarController = new CarController(stage, car);
			cars.push(controller);
			addChild(car);
			
			car.x = 1024 / 2;
			car.y = 768 / 2;
			
			car = new Car();
			controller = new CarController(stage, car, Keyboard.W, Keyboard.S, Keyboard.A, Keyboard.D);
			cars.push(controller);
			addChild(car);
			
			car.x = 1024 / 2 + 100;
			car.y = 768 / 2;
			
			gameLoop();
		}
		
		private function gameLoop():void {
			// TODO Check collisions against the track.
			
			// TODO Check collisions between cars.
			var test:Vector.<String> = Vector.<String>(['A', 'B', 'C', 'D']);
			for (var i:uint = 0; i < test.length - 1; i++) {
				for (var j:uint = i + 1; j < test.length; j++) {
					trace('Testing: ' + test[i] + ' and ' + test[j]); 
				}
			}
			// TODO Move cars.
		}
		
	}
	
}
