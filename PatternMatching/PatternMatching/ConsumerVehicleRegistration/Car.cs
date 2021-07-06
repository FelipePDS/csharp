using System;

namespace PatternMatching.ConsumerVehicleRegistration
{
    public class Car
    {
        public Car(int passengers)
        {
            Passengers = passengers;
        }

        public int Passengers { get; set; }
    }
}
