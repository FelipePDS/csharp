using System;

namespace ClassInheritance2
{
    public class Triangle : Shape
    {
        public Triangle(double widthAsSide1, double side2, double side3, double height)
        {
            WidthAsSide1 = widthAsSide1;
            Height = height;

            Side2 = side2;
            Side3 = side3;
        }

        public override double Area
            => Math.Round((WidthAsSide1 * Height) / 2, 2);

        public override double Perimeter
            => Math.Round(WidthAsSide1 + Side2 + Side3);

        public double WidthAsSide1 { get; }

        public double Side2 { get; }

        public double Side3 { get; }

        public double Height { get; }

        public bool IsTriangle()
        {
            bool firstCondition = (Side2 - Side3 < WidthAsSide1) 
                && (Side2 - Side3 < Side2 + Side3);

            bool secondCondition = (WidthAsSide1 - Side3 < Side2)
                && (WidthAsSide1 - Side3 < WidthAsSide1 + Side3);

            bool thirdCondition = (WidthAsSide1 - Side2 < Side3)
                && (WidthAsSide1 - Side2 < WidthAsSide1 + Side2);

            return firstCondition && secondCondition && thirdCondition;
        }
    }
}
