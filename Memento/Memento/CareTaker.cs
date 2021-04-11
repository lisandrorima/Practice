using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Memento
{
	public class CareTaker
	{
		
			private Memento _memento;
			public Memento Memento { get => _memento; set => _memento = value; }
		
	}
}
