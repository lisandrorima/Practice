using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StatePattern
{
	class CalderaCalentando : IestadoCaldera
	{
		private readonly Caldera _caldera;

		public CalderaCalentando(Caldera caldera)
		{
			_caldera = caldera;
		}
		public void CortarFuego()
		{
			ToString();
			_caldera.EstadoActual = _caldera.EstadoEspera;
			Console.WriteLine("El fuego ha sido cortado y la caldera puesta en espera");
			
		}

		public void ForzarFuego()
		{
			Console.WriteLine("No es posible forzar el fuego porque ya esta encendido");
			ToString();
		}

		public void PonerCombustible()
		{

			Console.WriteLine("No es posible poner combustible porque la caldera esta calentando");

		}

		public void Trabajar()
		{
			ToString();
			if (_caldera.Combustible>=3)
			{
				_caldera.Temperatura += 10;
				_caldera.Combustible -= 3;
				
				if (_caldera.Temperatura>100)
				{
					_caldera.EstadoActual = _caldera.EstadoAlarma;
				}
				else if (_caldera.Temperatura > 80 )
				{

					_caldera.EstadoActual = _caldera.EstadoEspera;
				}
			}
			else
			{
				ToString();

				_caldera.EstadoActual = _caldera.EstadoEspera;
			}
			ToString();
		}
		public override string ToString()
		{
			return $"Temperatura del agua: {_caldera.Temperatura}, el combustible esta en {_caldera.Combustible}";
		}
	}
}
