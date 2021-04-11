using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrategyPattern
{
    public class Context
    {
        private IStrategy strategy;

        public Context()
        { }

        public Context(IStrategy strategy)
        {
            this.strategy = strategy;
        }

        public void SetStrategy(IStrategy strategy)
        {
            this.strategy = strategy;
        }


        public int executeStrategy(int num1, int num2)
        {
            return strategy.realizarOperacion(num1, num2);
        }
    }
}
