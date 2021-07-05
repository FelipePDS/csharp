using System;

namespace ClassInheritance2
{
    class Program
    {
        static void Main(string[] args)
        {
            Shape[] shapes =
            {
                new Rectangle(10, 12),
                new Square(5),
                new Circle(3),
                new Triangle(3, 4, 5, 4)
            };

            foreach (var shape in shapes)
            {
                Console.WriteLine($"{shape}: area, {Shape.GetArea(shape)};" +
                    $"perimeter, {Shape.GetPerimeter(shape)}");

                var rect = shape as Rectangle;
                if (rect != null)
                {
                    Console.WriteLine($"    Is Square: {rect.IsSquare()}, Diagonal: {rect.Diagonal}");
                    continue;
                }

                var sq = shape as Square;
                if (sq != null)
                {
                    Console.WriteLine($"    Diagonal: {sq.Diagonal}");
                    continue;
                }

                var tri = shape as Triangle;
                if (tri != null)
                {
                    Console.WriteLine($"    IsTriangle: {(tri.IsTriangle() ? "True" : "False - non-congruent side values")}");
                    continue;
                }
            }

            Console.ReadKey();
        }
    }
}
