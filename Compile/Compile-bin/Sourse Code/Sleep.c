#include <windows.h>
int main(int argc, char *argv[])
{
	if( argc == 2 )
		Sleep(atoi(argv[1]));
	if(__SIZEOF_POINTER__== 4)
        return 32;
    else if(__SIZEOF_POINTER__ == 8)
        return 64;
    else return 0;
}
