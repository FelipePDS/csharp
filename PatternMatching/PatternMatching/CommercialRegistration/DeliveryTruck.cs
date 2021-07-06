using System;

namespace PatternMatching.CommercialRegistration
{
    public class DeliveryTruck
    {
        public DeliveryTruck(int grossWeightClass)
        {
            GrossWeightClass = grossWeightClass;
        }

        public int GrossWeightClass { get; set; }
    }
}
