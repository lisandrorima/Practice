using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrategyPattern
{
	public interface IStrategy
	{
		 int realizarOperacion(int num1, int num2);
	}
}
