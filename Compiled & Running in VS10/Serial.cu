#include <stdio.h>
#include <stdlib.h>
//variabel global
int i,j,maks=0,minimal=9999999,summin,summaks;

int main(int argc, char *argv[]) {
    //Deklarasi Variabel
    FILE *baca; //untuk membuka file txt
    char buf[4]; //digunakan pada sesi membaca file txt
    int a[100][100],b; //matriks yang akan diisi oleh variabel b

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

    //inisialisasi nilai variabel
    summin=0; summaks=0;

    //Sesi 4: Mencari Frekuensi Kemunculan Angka Minimum & Maksimum
    for (i = 0; i < 100; i++){
        for (j = 0; j < 100; j++){
            if(a[i][j]==minimal){
                summin+=1;
            }

            if(a[i][j]==maks){
                summaks+=1;
            }
        }
    }

    //Sesi 5: Cetak Semua Hasil Pencarian
    printf("\n \n Angka Paling Kecil: %d \n Muncul sebanyak: %d kali \n \n Angka Paling Besar: %d \n Muncul sebanyak: %d kali \n",minimal,summin,maks,summaks);
    system("pause"); return 0;
}
