using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StatePattern
{
	class Caldera 
	{
		private const int TEMP_IN = 20;
		private const int COMB_IN = 50;


		public int Combustible { get; set; }
		public int Temperatura { get; set; }

		public IestadoCaldera EstadoActual { get; set; }
		public IestadoCaldera EstadoAlarma { get; set; }
		public IestadoCaldera EstadoEspera { get; set; }
		public IestadoCaldera EstadoCalentando { get; set; }

		public Caldera()
		{
			this.Combustible = COMB_IN;
			this.Temperatura = TEMP_IN;
			
			EstadoAlarma = new CalderaAlarma(this);
			EstadoEspera = new CalderaEspera(this);
			EstadoCalentando = new CalderaCalentando(this);
			EstadoActual = EstadoEspera;
		}

		public void CortarFuego()
		{
			EstadoActual.CortarFuego();
		}

		public void ForzarFuego()
		{
			EstadoActual.ForzarFuego();
		}

		public void Trabajar()
		{
			EstadoActual.Trabajar();
		}

		public void PonerCombustible()
		{
			EstadoActual.PonerCombustible();
		}

		public override string ToString()
		{
			return EstadoActual.ToString();
		}
	}
}
