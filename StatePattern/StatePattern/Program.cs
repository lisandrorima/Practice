using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StatePattern
{
	class Program
	{
		static void Main(string[] args)
		{
			Caldera caldera = new Caldera();
			string opcion;

			do
			{

				Console.WriteLine("1- Trabajar, 2-Forzar Fuego, 3- Apagar, 4 - Poner Comb, 5 -Salir");
				opcion = Console.ReadLine();
				

				switch (opcion)
				{
					case "1":
						caldera.Trabajar();
						Console.WriteLine(caldera.ToString());
						break;
					case "2":
						caldera.Trabajar();
						caldera.ForzarFuego();
						Console.WriteLine(caldera.ToString());
						break;
					case "3":
						caldera.Trabajar();
						caldera.CortarFuego();
						Console.WriteLine(caldera.ToString());
						break;
					case "4":
						caldera.Trabajar();
						caldera.PonerCombustible();
						Console.WriteLine(caldera.ToString());
						break;
					default:
						Console.WriteLine("opcion incorrecta");
						break;
				}

			} while (opcion != "5");
		}
	}
}
