using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrategyPattern
{
	class Program
	{
		static void Main(string[] args)
		{
			Context context = new Context();

			Console.WriteLine("Ingrese 1er numero");
			int num1 = Convert.ToInt32(Console.ReadLine());
			Console.WriteLine("Ingrese 2do numero");
			int num2 = Convert.ToInt32(Console.ReadLine());
			Console.WriteLine("Ingrese 1 para suma, 2 para resta, 3 para multiplicar, 4 para dividir");
			int op = Convert.ToInt32(Console.ReadLine());

			switch (op)
			{
				case 1:
					context.SetStrategy(new StrategySuma());
					break;
				case 2:
					context.SetStrategy(new StrategyResta());
					break;
				case 3:
					context.SetStrategy(new StrategyMult());
					break;

				case 4:
					context.SetStrategy(new StrategyDiv());
					break;
				default:
					Console.WriteLine("El operador ingresado no es correcto");
					break;
			}
			var resultado = context.executeStrategy(num1, num2);
			Console.WriteLine(resultado);
			Console.ReadLine();
		}
	}
}
