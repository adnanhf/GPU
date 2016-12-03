#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

__global__ void FindMinMax(int *a, int *b, int *c) {   
	if(*a < *b){
	*b = *a;  
	}
	if(*a > *c){
	*c = *a;  
	}
}


int main(int argc, char *argv[]) {
//---------------------------------------------------------------------------------------------------------------------    
	//Deklarasi Variabel
    FILE *baca; //untuk membuka file txt
    char buf[4]; //digunakan pada sesi membaca file txt
	int a[100][100],b; //matriks yang akan diisi oleh variabel b
	int i,j,maks=0,min=9999; //variabel host lainnya
	int *d_a, *d_b, *d_c; //variabel device
	int size = sizeof(int); //ukuran data tiap variabel
//---------------------------------------------------------------------------------------------------------------------
	//Starting Clock Time 
	clock_t begin = clock();
//---------------------------------------------------------------------------------------------------------------------
    //Sesi 1: Alokasi ruang untuk variabel device
	cudaMalloc((void **)&d_a, size);
	cudaMalloc((void **)&d_b, size);
	cudaMalloc((void **)&d_c, size); 
//---------------------------------------------------------------------------------------------------------------------    
	
	//Sesi 2: Membaca txt File
    baca=fopen("MatrixTubes1.txt","r");
    if (!baca){
        printf("File tidak ditemukan"); //Cek File ada atau tidak (perlukah?)
    }

    i=0;j=0; //inisialisi indeks matriks

    if(!feof(baca)){ //jika belum mencapai akhir file, maka
        for(i = 0; i < 100; i++){
            for(j = 0; j < 100; j++){
                fscanf(baca,"%s",buf); //baca file per maksimal 4 karakter
                b=atoi(buf); //parsing data string ke integer
                a[i][j]=b; //simpan data integer ke matriks
            }
        }
    }
    fclose(baca);
    //isi file telah dibaca dan seluruh matriks telah terisi
    //saatnya menutup file
//---------------------------------------------------------------------------------------------------------------------
    //Sesi 2: Cetak Seluruh Elemen Matriks
    for (i = 0; i < 100; i++){
        for (j = 0; j < 100; j++){
            printf("%d\t",a[i][j]);
        }
    }
//---------------------------------------------------------------------------------------------------------------------
	for (i = 0; i < 100; i++){
        for (j = 0; j < 100; j++){
			//Copy data dari variabel host ke variabel device
			cudaMemcpy(d_a, &a[i][j], size, cudaMemcpyHostToDevice);   
			cudaMemcpy(d_b, &min, size, cudaMemcpyHostToDevice); 
			cudaMemcpy(d_c, &maks, size, cudaMemcpyHostToDevice);
			
			//Memanggil fungsi kernel
			FindMinMax<<<512,512>>>(d_a, d_b, d_c);

			//Copy data dari variabel device ke variabel host
			cudaMemcpy(&min, d_b, size, cudaMemcpyDeviceToHost);
			cudaMemcpy(&maks, d_c, size, cudaMemcpyDeviceToHost);
        }
    }
/*  cudaMemcpy(da, &a, size*sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(dmaks, &maks, sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(dmin, &minimal, sizeof(int), cudaMemcpyHostToDevice); */
//---------------------------------------------------------------------------------------------------------------------
/*	dim3 threadsPerBlock(100, 100);
    dim3 numBlocks(100 / threadsPerBlock.x, 100 / threadsPerBlock.y);
	FindMin<<<numBlocks, threadsPerBlock>>>(da,dmin);
	FindMin<<<numBlocks, threadsPerBlock>>>(da,dmaks); */
//---------------------------------------------------------------------------------------------------------------------
    //Sesi 7: Cetak data dari tiap variabel host yang sudah diolah oleh device
	printf("\n \n Angka Paling Kecil: %d \n \n Angka Paling Besar: %d \n\n",min,maks);
    //printf("\n Minimum Value = %d \n",min);
    //printf("\n Maximum Value = %d \n",maks);
//---------------------------------------------------------------------------------------------------------------------
    //Sesi 8: Bebaskan alokasi ruang dan akhiri program
	cudaFree(d_a);cudaFree(d_b);cudaFree(d_c);
//---------------------------------------------------------------------------------------------------------------------
	//Stop Clock Time
	clock_t end = clock();

	//Calculate Clock Time
	double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	printf("\n Clock Time = %g \n",time_spent);
//---------------------------------------------------------------------------------------------------------------------
	system("pause"); return 0;
}