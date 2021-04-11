using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrategyPattern
{
	class StrategySuma : IStrategy
	{
		public int realizarOperacion(int num1, int num2)
		{
			return num1 + num2;
		}
	}

	class StrategyResta : IStrategy
	{
		public int realizarOperacion(int num1, int num2)
		{
			return num1 - num2;
		}
	}
	class StrategyMult : IStrategy
	{
		public int realizarOperacion(int num1, int num2)
		{
			return num1 * num2;
		}
	}

	class StrategyDiv : IStrategy
	{
		public int realizarOperacion(int num1, int num2)
		{
			int resultado = 0;
			if (num2!=0)
			{
				resultado = num1 / num2;
			}
			else
			{
				resultado = -9999999;
			}
			return resultado;
		}
	}
}
