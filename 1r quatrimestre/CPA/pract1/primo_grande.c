#include <stdio.h>
#include <math.h>
#include <limits.h>
#include <omp.h>

typedef unsigned long long Entero_grande;
#define ENTERO_MAS_GRANDE  ULLONG_MAX

#define likely(b) __builtin_expect(b, 1)

int primo(Entero_grande const n)
{
	int p;
	Entero_grande i;

	// Tècnicament n % 2 || n==2 seria el mateix, no?
	p = (n % 2 != 0 || n == 2);

  	if (likely(p)) {
		const Entero_grande s = sqrt(n);
		//const int th_max = omp_get_num_threads();

		#pragma omp parallel for shared(p)
		for(i = 3; i <= s ; i += 2){
			if (likely(n % i)) continue; 
			p = 0;
			
			// No deuria donar overflow, ja que s és sqrt de un número.
			// suposant que eixe número siga el últim antes del overflow, 
			// el numero de threads deuria ser s/2 per a que puguera donar el error
			i = s;
		}
  	}

  	return p;
}

int main()
{
	Entero_grande n;

	for (n = ENTERO_MAS_GRANDE; !primo(n); n -= 2) ;

	printf("El mayor primo que cabe en %lu bytes es %llu.\n",
			sizeof(Entero_grande), n);

	return 0;
}
