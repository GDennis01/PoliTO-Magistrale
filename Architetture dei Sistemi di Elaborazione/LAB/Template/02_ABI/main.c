
extern int ASM_funct(int, int, int, int, int, int);

int main(void){

	int i=0xFFFFFFFF, j=2, k=3, l=4, m=5, n=6;
	volatile int r=0;

	r = ASM_funct(i, j, k, l, m, n);
		
	while(1);
}
