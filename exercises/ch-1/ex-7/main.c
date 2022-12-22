/*
Reads a source file and inverts the characters in the destnation file.
*/

#include <stdio.h>
#include <ctype.h>

int main()
{
		FILE *src_fp, *dst_fp;
		char ch;
		char src_file[] = "src_file.txt";
		char dst_file[] = "dst_file.txt";

		src_fp = fopen(src_file, "r");
		dst_fp = fopen(dst_file, "w");

		if (src_fp == NULL || dst_fp == NULL)
		{
				printf("src or dst files not found");
		}
		else
		{
				while((ch = fgetc(src_fp)) != EOF)
				{
						printf("%c", ch);
						if (islower(ch))
						{
								fputc(toupper(ch), dst_fp);
						}
						else if(isupper(ch)) {
								fputc(tolower(ch), dst_fp);
						}
						else {
								fputc(ch, dst_fp);
						}
				}
		}
		fclose(src_fp);
		fclose(dst_fp);
		return 0;
}
