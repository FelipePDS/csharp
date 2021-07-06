using System;
using PatternMatching.ConsumerVehicleRegistration;
using PatternMatching.CommercialRegistration;
using PatternMatching.LiveryRegistration;

namespace PatternMatching
{
    class Program
    {
        static void Main(string[] args)
        {
            Car car = new Car(2);
            //Taxi taxi = new Taxi(2);
            //Bus bus = new Bus(20, 10);
            //DeliveryTruck truck = new DeliveryTruck(4000);

            ToolCalculator toolForCar = new ToolCalculator(car, DateTime.Now, true);

            Console.WriteLine($"The tool for a car is {toolForCar.Total}");

            Console.ReadKey();
        }
    }
}
