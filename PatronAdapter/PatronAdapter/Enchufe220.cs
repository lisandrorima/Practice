using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Xsl;

namespace PatronAdapter
{
	class Enchufe220 : IenchufeEspañol
	{
		public int Flujo220()
		{
			return 220;
		}
	}
}
