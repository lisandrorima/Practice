using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StatePattern
{
	class CalderaEspera : IestadoCaldera
	{
		private readonly Caldera _caldera;
		private const int AGREGAR_COMB = 28;
		private const int TRABAJO_ESPERA = -5;
		public CalderaEspera(Caldera caldera)
		{
			_caldera = caldera;
		}

		public void CortarFuego()
		{
			Console.WriteLine("No se puede apagar fuego porque ya esta en estado de espera");
			ToString();		
		}

		public void ForzarFuego()
		{
			if (_caldera.Combustible>=3)
			{
				_caldera.Temperatura += 10;
				_caldera.Combustible -= 3;
				ToString();
				if (_caldera.Temperatura>100)
				{
					_caldera.EstadoActual = _caldera.EstadoAlarma;
					ToString();
				}
			}
		}

		public void PonerCombustible()
		{
			_caldera.Combustible += AGREGAR_COMB;
			Console.WriteLine("Se ha agregado {0} unidades de combustible",AGREGAR_COMB);
			ToString();
		}

		public void Trabajar()
		{				
			ToString();
			_caldera.Temperatura += TRABAJO_ESPERA;
			Console.WriteLine("Caldera en espera, La caldera bajo {0} grados, su temp actual es {1}", TRABAJO_ESPERA, _caldera.Temperatura);
			if (_caldera.Temperatura<60 & _caldera.Combustible>=3)
			{
				_caldera.EstadoActual = _caldera.EstadoCalentando;
				Console.WriteLine("La caldera se encendió");
			}
	
		}

		public override string ToString()
		{
			return $"Temperatura del agua: {_caldera.Temperatura}, el combustible esta en {_caldera.Combustible}";
		}
	}
}
