﻿using System;
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

			Bitmap img = new Bitmap("Splat.png");
//			for (int j = 5; j < img.Height; j+=8)
//			for (int j = 5; j < img.Height; j+=8)
			int j = 5;
			{
				StringBuilder str = new StringBuilder();
//				for (int i = 5; i < img.Width; i+=8)
				for (int i = 5; i < img.Width; i+=8)
				{
					Color pixel = img.GetPixel(i, j); // Origin seems to be top-left
					var num = pixel.ToArgb();
					if (num == -16777216) // Black
					{
						str.Append("W,");
					}
					else if (num == -1) // White
					{
						str.Append(" ,");
					}
					else
					{
						Console.WriteLine($"Unknown code: {num}");
						str.Append("?,");
					}
				}
				str.Append("END");
//				str.Remove(str.Length - 1, 1);
//				str.Append("\n");
				File.AppendAllLines(@"mapdata.csv", new[] { str.ToString() });
			}
			Console.WriteLine($"Finished");
		}
	}
}
