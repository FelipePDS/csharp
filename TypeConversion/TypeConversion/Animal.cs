using System;

namespace TypeConversion
{
    public class Animal
    {
        public void Eat()
        {
            Console.WriteLine("Eating.");
        }

        public override string ToString()
        {
            return "I am an animal.";
        }
    }
}
