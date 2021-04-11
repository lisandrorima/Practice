using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatronAdapter
{
	class Taladro110
	{
		IEnchufeIngles Enchufe;

		public Taladro110(IEnchufeIngles enchufeIngles)
		{
			this.Enchufe = enchufeIngles;
		}
		public void Encender()
		{
			Console.WriteLine(Enchufe.Flujo110());
		}
	}
}
