using System;
using System.Drawing;
using System.IO;
using System.Text;

namespace ReadImageFile
{
	class Program
	{
		static void Main(string[] args)
		{
			File.Delete("mapdata.csv");

			Bitmap img = new Bitmap("Splat_Original.png");
			for (int j = 0; j < img.Height; j+=8)
//			int j = 55;
			{
				StringBuilder str = new StringBuilder();
				for (int i = 0; i < img.Width; i+=8)
				{
					Color pixel0 = img.GetPixel(i, j); // Origin seems to be top-left
					var num0 = pixel0.ToArgb();
					Color pixel1 = img.GetPixel(i+4, j+5); // Origin seems to be top-left
					var num1 = pixel1.ToArgb();
//					Color pixel2 = img.GetPixel(i+5, j+0); // Origin seems to be top-left
//					var num2 = pixel2.ToArgb();

					if (num0 == -16777216 || num1 == -16777216) // Black
					{
						str.Append("W,");
					}
					else if (num0 == -1 && num1 == -1) // White
					{
						str.Append(" ,");
					}
					else if (num1 == -16713728) // Green
					{
						str.Append("G,");
					}
					else if (num1 == -524040) // Magenta
					{
						str.Append("P,");
					}
					else if (num1 == -16713480) // Cyan, always water
					{
						str.Append("C,");
					}
					else if (num0 == -524288 && num1 == -524288) // Solid red
					{
						str.Append("L,");
					}
					else if (num0 == -460800 && num1 == -460800) // Solid yellow
					{
						str.Append("Y,");
					}
					else if (num0 == -16776968 && num1 == -16776968) // Solid Dark blue
					{
						str.Append("B,");
					}
					else if (num0 == -1 && num1 == -524288) // Curved Red again
					{
						str.Append("L,");
					}
					else if (num0 == -1 && num1 == -460800) // curved Yellow
					{
						str.Append("Y,");
					}
					else if (num0 == -524288 && num1 == -1) // Spikes
					{
						str.Append("S,");
					}
/*					else if (num0 == -16777216 && num1 == -1) // 1
					{
						str.Append("1,");
					}*/
					else
					{
						Console.WriteLine($"Unknown code: {num0}/{num1}");
						str.Append("?,");
					}
				}
				str.Append("END");
				File.AppendAllLines(@"mapdata.csv", new[] { str.ToString() });
			}
			Console.WriteLine($"Finished");
		}
	}
}
