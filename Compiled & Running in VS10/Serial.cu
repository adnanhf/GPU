#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
//#include <sys/time.h>

//variabel global
int i,j,maks=0,minimal=9999999;

int main(int argc, char *argv[]) {
    //Deklarasi Variabel
    //struct timeval start, end; //Variabel execution timer
    //double delta1,delta2;
    FILE *baca; //untuk membuka file txt
    char buf[4]; //digunakan pada sesi membaca file txt
    int a[100][100],b; //matriks yang akan diisi oleh variabel b

	//Starting Clock Time 
	clock_t begin = clock();

    //Sesi 1: Membaca txt File
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

    //Sesi 2: Cetak Seluruh Elemen Matriks
    for (i = 0; i < 100; i++){
        for (j = 0; j < 100; j++){
            printf("%d\t",a[i][j]);
        }
    }

    //Sesi 3: Pencarian Elemen Minimum dan Maksimum
    //gettimeofday(&start, NULL);
    for (i = 0; i < 100; i++){
        for (j = 0; j < 100; j++){

            if(a[i][j]<minimal){
                minimal=a[i][j];
            }

            if(a[i][j]>maks){
                maks=a[i][j];
            }
        }
    }
    //gettimeofday(&end, NULL);
    //delta1 = ((end.tv_sec  - start.tv_sec) * 1000000u + end.tv_usec - start.tv_usec) / 1.e6;

    //Sesi 4: Cetak Semua Hasil Pencarian
    printf("\n \n Angka Paling Kecil: %d \n Angka Paling Besar: %d \n",minimal,maks);
    //printf("\n CPU_time = %g \n",delta2);

	//Stop Clock Time
	clock_t end = clock();

	//Calculate Clock Time
	double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	printf("\n Clock Time = %g \n",time_spent);
	
	system("pause"); return 0;
}


