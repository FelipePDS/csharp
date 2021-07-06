using System;
using PatternMatching.ConsumerVehicleRegistration;
using PatternMatching.CommercialRegistration;
using PatternMatching.LiveryRegistration;

namespace PatternMatching
{
    public class ToolCalculator
    {
        public ToolCalculator(object vehicle, DateTime timeOfTool, bool inbound)
        {
            Total = CalculateTool(vehicle) +
            PeakTimePremiumIfElse(timeOfTool, inbound);
        }

        public decimal Total { get; private set; }

        public decimal CalculateTool(object vehicle)
        {
            if (vehicle is Car c)
            {
                if (c.Passengers.Equals(0))
                    return 2.00m + 0.05m;

                else if (c.Passengers.Equals(1))
                    return 2.00m;

                else if (c.Passengers.Equals(2))
                    return 2.00m - 0.05m;

                else
                    return 2.00m - 1.00m;
            }

            else if (vehicle is Taxi t)
            {
                if (t.Fares.Equals(0))
                    return 3.50m + 1.00m;

                else if (t.Fares.Equals(1))
                    return 3.50m;

                else if (t.Fares.Equals(2))
                    return 3.50m - 0.50m;

                else
                    return 3.50m - 1.00m;
            }

            else if (vehicle is Bus b)
            {
                double busOccupation = (double)b.Riders / (double)b.Capacity;

                if (busOccupation < 0.50)
                    return 5.00m + 2.00m;

                else if (busOccupation > 0.90)
                    return 5.00m - 1.00m;

                else
                    return 5.00m;
            }

            else if (vehicle is DeliveryTruck d)
            {
                if (d.GrossWeightClass > 5000)
                    return 10.00m + 5.00m;

                else if (d.GrossWeightClass < 3000)
                    return 10.00m - 2.00m;

                else
                    return 10.00m;
            }

            else if (vehicle is null)
                throw new ArgumentNullException(nameof(vehicle));

            else
                throw new ArgumentException(message: "Not a Know vehicle type", paramName: nameof(vehicle));
        }

        public decimal PeakTimePremiumIfElse(DateTime timeOfTool, bool inbound)
        {
            bool isWeekDay = IsWeekDay(timeOfTool);
            TimeBand timeBand = GetTimeBand(timeOfTool);

            if (isWeekDay)
            {
                if (timeBand.Equals(TimeBand.MorningRush) && inbound)
                    return 2.00m;

                else if (timeBand.Equals(TimeBand.MorningRush) && !inbound)
                    return 1.00m;

                else if (timeBand.Equals(TimeBand.DayTime))
                    return 1.50m;

                else if (timeBand.Equals(TimeBand.EveningRush) && inbound)
                    return 1.00m;

                else if (timeBand.Equals(TimeBand.EveningRush) && !inbound)
                    return 2.00m;

                else
                    return 0.75m;
            }
            else
            {
                return 1.00m;
            }

        }

        private static bool IsWeekDay(DateTime timeOfTool)
        {
            switch (timeOfTool.DayOfWeek)
            {
                case DayOfWeek.Saturday:
                    return false;
                case DayOfWeek.Sunday:
                    return false;
                default:
                    return true;
            }
        }

        private enum TimeBand
        {
            MorningRush,
            DayTime,
            EveningRush,
            Overnight
        }

        private static TimeBand GetTimeBand(DateTime timeOfToll)
        {
            int hour = timeOfToll.Hour;

            if (hour < 6 || hour > 19)
                return TimeBand.Overnight;

            else if (hour < 10)
                return TimeBand.MorningRush;

            else if (hour < 16)
                return TimeBand.DayTime;

            else
                return TimeBand.EveningRush;
        }
    }
}
