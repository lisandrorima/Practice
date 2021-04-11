using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Prototype
{
	class ProtoAdmin
	{
		private Dictionary<char, IPrototype> prototipos = new Dictionary<char, IPrototype>();
	
	public ProtoAdmin()
		{
			Factura factura = new Factura("Juan",100,1,'A');
			prototipos.Add(factura.TipoFactura, factura);
		}

	public void AddProto(char key, Factura factura)
		{
			factura.Mes = -1;
			if (prototipos.ContainsKey(key))
			{
				prototipos[key] = factura;
			}
			else
			{
				prototipos.Add(key, factura);
			}
			
		}

	public IPrototype ObtainProto (char tipo)
		{
			return prototipos[tipo].Clone();
		}
	
	}
}
