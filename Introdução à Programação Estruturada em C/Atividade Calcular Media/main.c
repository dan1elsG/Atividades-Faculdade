#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

int main() {
    // Declarando Variaveis Simples e Composta
    char nome_aluno[50], nome_materia[100][50], linha[250], *token;
    int quantidade_materias, opcao, contador = 0, linhainicial = 3, salto = 4, totalLinhas = 0;
    float notas[4], media[100];
    char situacao[100][20];
    float somaPrimeiras = 0.0, somaUltimas = 0.0;  // Inicializar as somas

    //Cria um arquivo txt com nome de media
    FILE *file = fopen("Media.txt", "w");
    
    // Perguntando o nome do usuario
    printf("Qual seu nome: ");
    scanf("%s", nome_aluno);
    fprintf(file, "%s\n", nome_aluno);
    printf("\n------------------------------------\n");

    printf("Ola %s, Seja Bem-Vindo!", nome_aluno);
    printf("\n------------------------------------\n");
    sleep(1);

    // Perguntando ao usuário quantas matérias deseja inserir
    printf("Digite a quantidade de materias que deseja inserir: ");
    scanf("%d", &quantidade_materias);
    printf("------------------------------------\n");
    sleep(1);

    // Laço para escrever os nomes e notas das matérias
    for (int i = 0; i < quantidade_materias; i++) {
        // Escrevendo o nome da matéria
        printf("Escreva o nome da %d materia: ", i + 1);
        scanf("%s", nome_materia[i]);
        fprintf(file, "%s\n", nome_materia[i]);
        printf("--------------------------------\n");
        
        // Laço interno para solicitar as 4 notas da matéria atual
        for (int r = 0; r < 4; r++) {
            printf("Escreva a nota do %d Bimestre da materia %s: ", r + 1, nome_materia[i]);
            scanf("%f", &notas[r]);
            fprintf(file, "%.2f:", notas[r]);
        }
        printf("--------------------------------\n");
        
        // Calculando a média das 4 notas da matéria atual
        media[i] = (notas[0] + notas[1] + notas[2] + notas[3]) / 4;
        fprintf(file, "\n%.2f", media[i]);

        // Verificando a situação da matéria
        if (media[i] >= 7) {
            strcpy(situacao[i], "Aprovado");
        } else if (media[i] >= 6 && media[i] < 7) {
            strcpy(situacao[i], "Recuperacao");
        } else {
            strcpy(situacao[i], "Reprovado");
        }
        fprintf(file, "\n%s\n", situacao[i]);
    }
    fclose(file);

    
    do{
        printf("\n-------- MENU PRINCIPAL --------\n");
            printf("1. Ver  materias e situacoes\n");
            printf("2. Ver a media dos semestres\n");
            printf("3. Sair\n");
            printf("Escolha uma opcao: ");
            scanf("%d", &opcao);

        switch(opcao){
            case 1:{
                FILE *arquivo;
                char linha[250];
                int contador = 0;

                // Abrindo o arquivo Media.txt para leitura
                arquivo = fopen("Media.txt", "r");

                // Ignora a primeira linha
                fgets(linha, sizeof(linha), arquivo);

                printf("\n-------- INFORMACOES DAS MATERIAS --------\n");

                // Variáveis para armazenar cada linha temporariamente
                char materia[50], notas_str[100], media_str[10], situacao_str[20];

                // Lê o arquivo linha por linha e armazena as informações
                while (fgets(linha, sizeof(linha), arquivo) != NULL) {
                    contador++;

                    if (contador % 4 == 1) {  
                        strcpy(materia, linha);
                    } else if (contador % 4 == 2) {  
                        strcpy(notas_str, linha);
                    } else if (contador % 4 == 3) {  
                        strcpy(media_str, linha);
                    } else if (contador % 4 == 0) {  
                        strcpy(situacao_str, linha);
                    
                        // Exibe as informações acumuladas
                        printf("\nMateria: %s", materia);
                        printf("Notas: %s", notas_str);
                        printf("Media: %s", media_str);
                        printf("Situacao: %s", situacao_str);
                        printf("--------------------------------\n");
                        sleep(2);
                    }
                }

                // Fecha o arquivo
                fclose(arquivo);
                break;
            }
            case 2:{
                        // Leitura do arquivo
                FILE *arquivo = fopen("Media.txt", "r");
                if (arquivo == NULL) {
                    printf("Erro ao abrir o arquivo para leitura.\n");
                    return 1;
                }

                // Reinicializar contador e variáveis de leitura
                contador = 0;
                
                // Lê o arquivo linha por linha
                while (fgets(linha, sizeof(linha), arquivo) != NULL) {
                    float nota[4] = {0};  // Inicializando array de notas
                    int indice = 0;  // Variável separada para o índice das notas
                    contador++;

                    // Verifica se a linha atual é a terceira ou segue o padrão de salto
                    if (contador == linhainicial || (contador > linhainicial && (contador - linhainicial) % salto == 0)) {
                        token = strtok(linha, ":");
                        while (token != NULL && indice < 4) {
                            nota[indice] = atof(token);  // Converte o token para float
                            token = strtok(NULL, ":");
                            indice++;
                        }

                        // Verifica se foram lidas exatamente 4 notas
                        if (indice == 4) {
                            for (int i = 0; i < 2; i++) {
                                somaPrimeiras += nota[i];        // Soma as duas primeiras notas
                                somaUltimas += nota[i + 2];     // Soma as duas últimas notas
                            }
                        }
                        totalLinhas++;
                    }
                }

                // Calcula e exibe as médias gerais
                if (totalLinhas > 0) {
                    float mediaPrimeiras = somaPrimeiras / (2 * totalLinhas);  // Média das duas primeiras notas
                    float mediaUltimas = somaUltimas / (2 * totalLinhas);      // Média das duas últimas notas
                    printf("\n-------- INFORMACOES DOS SEMESTRES --------\n");
                    printf("Media do Primeiro Semestre: %.2f\n", mediaPrimeiras);
                    printf("Media do Segundo Semestre: %.2f\n", mediaUltimas);
                    sleep(3);
                } else {
                    printf("Semestres nao Concluidos.\n");
                }
                fclose(arquivo);
                break;
            }
            case 3:{
                printf("Saindo do programa....");
                sleep(3);
                break;
            }
            default:{
                printf("Opcao invalida! Tente novamente.\n");
                sleep(2);
                break;
            }
        
        }   
    }while(opcao != 3);
}