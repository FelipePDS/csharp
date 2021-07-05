using System;

namespace ClassInheritance2
{
    public class Circle : Shape
    {
        public Circle(double radius)
        {

        }

        public override double Area
            => Math.Round(Math.PI * Math.Pow(Radius, 2), 2);

        public override double Perimeter
            => Math.Round(Math.PI * 2 * Radius, 2);

        public double circumference => Perimeter;

        public double Radius { get; }

        public double Diameter => Radius * 2;
    }
}
