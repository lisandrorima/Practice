using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StatePattern
{
	class CalderaAlarma : IestadoCaldera
	{

		private readonly Caldera _caldera;
		private const int TRABAJO_ALARMA = -5;

		public CalderaAlarma(Caldera caldera)
		{
			_caldera = caldera;
		}
		public void CortarFuego()
		{
			Console.WriteLine("Estado de alarma, solo se puede ejecutar trabajo");
		}

		public void ForzarFuego()
		{
			Console.WriteLine("Estado de alarma, solo se puede ejecutar trabajo");
		}

		public void PonerCombustible()
		{
			Console.WriteLine("Estado de alarma, solo se puede ejecutar trabajo");
		}

		public void Trabajar()
		{
			_caldera.Temperatura += TRABAJO_ALARMA;
			if (_caldera.Temperatura<=90 | _caldera.Combustible<=3)
			{
				_caldera.EstadoActual = _caldera.EstadoEspera;
			}
		}

		public override string ToString()
		{
			return $" Estado de alarma, Temperatura del agua: {_caldera.Temperatura}, el combustible esta en {_caldera.Combustible}";
		}
	}
}
