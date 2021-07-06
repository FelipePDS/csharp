using System;

namespace PatternMatching.LiveryRegistration
{
    class Bus
    {
        public Bus(int capacity, int riders)
        {
            Capacity = capacity;
            Riders = riders;
        }

        public int Capacity { get; set; }
        public int Riders { get; set; }
    }
}
