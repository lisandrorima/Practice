using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Memento
{
	public class Memento
	{
		private List<Partida> partidas = new List<Partida>();

		public void Guardar(Partida partida)
		{
			Partida temp = new Partida(partida.NombreJugador, partida.VidaJugador);
			partida.VecesGuardada += 1;
			temp.VecesGuardada = partida.VecesGuardada;
				partidas.Add(temp);
				Console.WriteLine("partida guardada");
			
		}

		public Partida Restaurar()
		{

			return partidas[0];
		}
	}
}
