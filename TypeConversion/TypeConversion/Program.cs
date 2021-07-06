using System;

namespace TypeConversion
{
    class Program
    {
        static void Main(string[] args)
        {
            Giraffe giraffe = new Giraffe();
            Animal animal = new Animal();

            FeedMammals(giraffe);
            FeedMammals(animal);

            Supernova supernova = new Supernova();
            TestForMammals(giraffe);
            TestForMammals(supernova);

            Console.ReadKey();
        }

        static void FeedMammals(Animal animal)
        {
            if (animal is Mammal mammal)
                mammal.Eat();
            else
                Console.WriteLine($"{animal.GetType().Name} is not a Mammal");
        }

        static void TestForMammals(object o)
        {
            Mammal mammal = o as Mammal;

            if (mammal != null)
                Console.WriteLine(mammal.ToString());
            else
                Console.WriteLine($"{o.GetType().Name} is not a Mammal");
        }
    }
}
