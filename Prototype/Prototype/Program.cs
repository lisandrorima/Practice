using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Prototype
{
	class Program
	{
		static void Main(string[] args)
		{
			ProtoAdmin admin = new ProtoAdmin();

			Factura factura2 = (Factura)admin.ObtainProto('A');

			factura2.Imprimir();

			Console.WriteLine("-------");

			Factura factura1 = new Factura("PEPE", 200, 2, 'A');

			factura1.Imprimir();

			Console.WriteLine("-------");

			admin.AddProto(factura1.TipoFactura, factura1);

			Factura factura3 = (Factura)admin.ObtainProto('A');

			factura3.Imprimir();

			Console.WriteLine("-------");


			Factura factura4 = new Factura("factura b", 50, 3, 'B');
			admin.AddProto(factura4.TipoFactura, factura4);

			Factura factura5 = (Factura)admin.ObtainProto('B');


			factura5.Imprimir();
			Console.WriteLine("-------"); 

			factura5.Mes = 5;

			factura5.Imprimir();
			Console.ReadLine();
		}
	}
}
