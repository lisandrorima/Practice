using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Prototype
{
	public class Factura : IPrototype
	{
		public Factura(string receptor, int monto, int mes, char tipoFact)
		{
			this.Receptor = receptor;
			this.Monto = monto;
			this.Mes = mes;
			this.TipoFactura = tipoFact;
		}
		public string Receptor { get; set; } 
		public int Monto { get; set; }
		public int Mes { get; set; }
		public char TipoFactura { get; set;}

		public IPrototype Clone()
		{
			Factura clonFactura = new Factura(Receptor, Monto, Mes, TipoFactura);
			return clonFactura;
		}

		public void Imprimir()
		{
			Console.WriteLine("El Receptor de la factura es: {0} \n" +
				"El monto es : {1} \n" +
				"El mes de la factura es {2} \n y el tipo de factura es {3}", Receptor, Monto, Mes, TipoFactura);
		}
	}
}


