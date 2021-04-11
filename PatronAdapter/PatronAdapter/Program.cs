using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatronAdapter
{
	class Program
	{
		static void Main(string[] args)
		{
			IenchufeEspañol enchufe220 = new Enchufe220();

			IEnchufeIngles adapter = new E220a110Adapter(enchufe220);
			Taladro110 taladro = new Taladro110(adapter);

			taladro.Encender();
			Console.ReadLine();
		}
	}
}
