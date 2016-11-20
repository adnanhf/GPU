#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#define M 100     // row
#define N 100    // column
int i,j;

int main(){
    //buat deklarasi CPU Time
    struct timeval start, end;
    //deklarasi matriks
    int MR[M][N],MG[M][N],MB[M][N];
    srand(time(NULL));

    //No 1: membuat matriks
//-----------------------------------------------------------------------------------------------------
    gettimeofday(&start, NULL);
    for (i = 0; i < M; i++){
        for (j = 0; j < N; j++){
            MR[i][j]=1+rand() % 1000;
            MG[i][j]=1+rand() % 1000;
            MB[i][j]=1+rand() % 1000;
        }
    }
    gettimeofday(&end, NULL);

    double delta = ((end.tv_sec  - start.tv_sec) * 1000000u + end.tv_usec - start.tv_usec) / 1.e6;
    printf("CPU_time = %g \n",delta);
//------------------------------------------------------------------------------------------------------
    /*//mencetak matrix
    for (i = 0; i < M; i++){
        printf("[ ");
        for (j = 0; j < N; j++){
            printf("%d ",mat[i][j]);
            if(j==N-1){
                printf("]\n");
            }
        }
    }*/int MGS[M][N];
//-----------------------------------------------------------------------------------------------------
    //No 2: konversi angka
    gettimeofday(&start, NULL);
    for (i = 0; i < M; i++){
        for (j = 0; j < N; j++){
            MR[i][j]=MR[i][j]*0.2989;
            MG[i][j]=MG[i][j]*0.5870;
            MB[i][j]=MB[i][j]*0.1140;
        }
    }
    gettimeofday(&end, NULL);

    delta = ((end.tv_sec  - start.tv_sec) * 1000000u + end.tv_usec - start.tv_usec) / 1.e6;
    printf("CPU_time = %g \n",delta);
//-----------------------------------------------------------------------------------------------------
    //No 2:pembuatan matriks gray scale
    gettimeofday(&start, NULL);
    for (i = 0; i < M; i++){
        for (j = 0; j < N; j++){
            MGS[i][j]=MR[i][j]+MG[i][j]+MB[i][j];
        }
    }
    gettimeofday(&end, NULL);

    delta = ((end.tv_sec  - start.tv_sec) * 1000000u + end.tv_usec - start.tv_usec) / 1.e6;
    printf("CPU_time = %g \n",delta);
//-----------------------------------------------------------------------------------------------------
    //No 4: print matrix
    gettimeofday(&start, NULL);
    FILE *r=fopen("MatrixTubes1.txt","w");
    for(i=0;i<M;i++){
        for(j=0;j<N;j++){
            fprintf(r,"%i ",MR[i][j]);
        }
        fprintf(r,"\n");
    }
    gettimeofday(&end, NULL);

    delta = ((end.tv_sec  - start.tv_sec) * 1000000u + end.tv_usec - start.tv_usec) / 1.e6;
    printf("CPU_time = %g \n",delta);
//-----------------------------------------------------------------------------------------------------
    gettimeofday(&start, NULL);
    FILE *g=fopen("MatrixTubes2.txt","w");
    for(i=0;i<M;i++){
        for(j=0;j<N;j++){
            fprintf(g,"%i",MG[i][j]);
        }
        fprintf(g,"\n");
    }
    gettimeofday(&end, NULL);

    delta = ((end.tv_sec  - start.tv_sec) * 1000000u + end.tv_usec - start.tv_usec) / 1.e6;
    printf("CPU_time = %g \n",delta);
//-----------------------------------------------------------------------------------------------------
    gettimeofday(&start, NULL);
    FILE *b=fopen("MatrixTubes3.txt","w");
    for(i=0;i<M;i++){
        for(j=0;j<N;j++){
            fprintf(b,"%i",MB[i][j]);
        }
        fprintf(b,"\n");
    }
    gettimeofday(&end, NULL);

    delta = ((end.tv_sec  - start.tv_sec) * 1000000u + end.tv_usec - start.tv_usec) / 1.e6;
    printf("CPU_time = %g \n",delta);
//-----------------------------------------------------------------------------------------------------
    gettimeofday(&start, NULL);
    FILE *gs=fopen("MatrixTubes4.txt","w");
    for(i=0;i<M;i++){
        for(j=0;j<N;j++){
            fprintf(gs,"%i",MGS[i][j]);
        }
        fprintf(gs,"\n");
    }
    gettimeofday(&end, NULL);

    delta = ((end.tv_sec  - start.tv_sec) * 1000000u + end.tv_usec - start.tv_usec) / 1.e6;
    printf("CPU_time = %g \n",delta);
//-----------------------------------------------------------------------------------------------------
    fclose(r);
    fclose(g);
    fclose(b);
    fclose(gs);

    return 0;
}
