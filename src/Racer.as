package {
	
	import ch.forea.racer.Car;
	import ch.forea.racer.CarController;
	
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	
	[SWF(width='1024', height='768', backgroundColor='#000000', frameRate='60')]
	public class Racer extends Sprite {
		
		public function Racer() {
			var car:Car = new Car();
			var controller:CarController = new CarController(stage, car);
			addChild(car);
			
			car.x = 1024 / 2;
			car.y = 768 / 2;
			
			var car:Car = new Car();
			var controller:CarController = new CarController(stage, car, Keyboard.W, Keyboard.S, Keyboard.A, Keyboard.D);
			addChild(car);
			
			car.x = 1024 / 2;
			car.y = 768 / 2;
		}
		
	}
	
}
