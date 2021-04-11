using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatronAdapter
{
	class E220a110Adapter : IEnchufeIngles
	{
		private IenchufeEspañol E220;


		public E220a110Adapter(IenchufeEspañol E220)
		{
			this.E220 = E220;
		}

		public int Flujo110()
		{
			return E220.Flujo220() / 2;
		}

		public IEnchufeIngles EnchufeIngles()
		{
			Enchufe110 enchufe110 = new Enchufe110();
			return enchufe110;
		}
	}
}
