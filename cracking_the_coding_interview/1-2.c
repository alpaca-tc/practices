/* [todo] - 残念ながら理解出来なかった */

#include <stdio.h>

void reverse(char *str) {
	char* end = str;
	char tmp;

	if (str) {
		while (*end) {
			++end;
		}
		--end;

		while (str < end) {
			tmp = *str;
			*str++ = *end;
			*end-- = tmp;
		}
	}
}

int main(int argc, char const* argv[])
{
	char* string = "string\0";
	reverse(string);
	printf("%s", string);
	return 0;
}
