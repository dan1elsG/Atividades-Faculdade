programa {
    // Declarando as vari�veis globais
    inteiro quantidade_materias, opcao
    cadeia nome_materia[100], situacao[100], nome_aluno[50]
    real notas[4][100], media_bimestres[100]
    real soma_bimestres1_e_2 = 0, soma_bimestres3_e_4 = 0
    real soma_media_semestre1 = 0, soma_media_semestre2 = 0

    // Fun��o principal do programa
    funcao inicio() {
        // Perguntando o nome do usu�rio
        escreva("Qual seu Nome: ")
        leia(nome_aluno)
        // Boas-vindas
        escreva("Ol� ", nome_aluno, ", Seja Bem-Vindo!\n")
        // Perguntando ao usu�rio quantas mat�rias deseja inserir
        escreva("Digite a quantidade de mat�rias que deseja inserir: ")
        leia(quantidade_materias)

        // La�o para escrever os nomes e notas das mat�rias
        para (inteiro i = 0; i < quantidade_materias; i++) {
            // Escrevendo o nome da mat�ria
            escreva("Escreva o nome da ", i + 1, "� Mat�ria: ")
            leia(nome_materia[i])
            escreva("--------------------------------\n")

            // La�o interno para solicitar as 4 notas da mat�ria atual
            para (inteiro r = 0; r < 4; r++) {
                escreva("Escreva a nota do ", r + 1, "� Bimestre da mat�ria ", nome_materia[i], ": ")
                leia(notas[r][i])

                // Acumulando as notas para as somas dos bimestres
                se (r < 2) { // Para os bimestres 1 e 2
                    soma_bimestres1_e_2 = soma_bimestres1_e_2 + notas[r][i]
                } senao { // Para os bimestres 3 e 4
                    soma_bimestres3_e_4 = soma_bimestres3_e_4 + notas[r][i]
                }
            }

            escreva("--------------------------------\n")

            // Calculando a m�dia dos 4 bimestres
            media_bimestres[i] = (notas[0][i] + notas[1][i] + notas[2][i] + notas[3][i]) / 4

            // Calculando as m�dias dos semestres e acumulando para a m�dia geral
            real media_semestre1 = (notas[0][i] + notas[1][i]) / 2 // M�dia do 1� e 2� bimestres (1� semestre)
            real media_semestre2 = (notas[2][i] + notas[3][i]) / 2 // M�dia do 3� e 4� bimestres (2� semestre)

            // Acumulando as m�dias dos semestres para calcular a m�dia geral
            soma_media_semestre1 = soma_media_semestre1 + media_semestre1
            soma_media_semestre2 = soma_media_semestre2 + media_semestre2

            // Verificando a situa��o da mat�ria com base na m�dia do 2� semestre
            se (media_semestre2 >= 7) {
                situacao[i] = "Aprovado"
            } senao se (media_semestre2 >= 6 e media_semestre2 < 7) {
                situacao[i] = "Recupera��o"
            } senao {
                situacao[i] = "Reprovado"
            }
        }

        // Chamar o menu ap�s coletar todas as informa��es
        menu_principal()
    }

    // Fun��o do menu principal
    funcao menu_principal() {
        faca {
            escreva("\n-------- MENU PRINCIPAL --------\n")
            escreva("1. Ver mat�rias e situa��es\n")
            escreva("2. Ver a m�dia geral dos semestres\n")
            escreva("3. Sair\n")
            escreva("Escolha uma op��o: ")
            leia(opcao)

            // Escolha de op��es
            escolha (opcao) {
                caso 1:
                    escreva("\n-------- INFORMA��ES DAS MAT�RIAS --------\n")
                    para (inteiro i = 0; i < quantidade_materias; i++) {
                        escreva("\nMat�ria: ", nome_materia[i], "\n")
                        escreva("Notas: ")
                        para (inteiro r = 0; r < 4; r++) {
                            escreva(notas[r][i], " ") // Acessando as notas corretamente
                        }
                        escreva("\nSitua��o: ", situacao[i], "\n")
                        escreva("--------------------------------\n")
                    }
                    pare
                caso 2:
                    // Exibindo apenas as m�dias gerais dos semestres
                    real media_geral_semestre1 = soma_media_semestre1 / quantidade_materias
                    real media_geral_semestre2 = soma_media_semestre2 / quantidade_materias

                    escreva("\n-------- M�DIA GERAL DOS SEMESTRES --------\n")
                    escreva("M�dia Geral do 1� Semestre: ", media_geral_semestre1, "\n")
                    escreva("M�dia Geral do 2� Semestre: ", media_geral_semestre2, "\n")
                    escreva("--------------------------------\n")
                    pare
                caso 3:
                    escreva("Saindo do programa....\n")
                    pare
                caso contrario:
                    escreva("Op��o inv�lida! Tente novamente.\n")
                    pare
            }
        } enquanto (opcao != 3)
    }
}
