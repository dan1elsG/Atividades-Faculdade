programa {
    // Declarando as variáveis globais
    inteiro quantidade_materias, opcao
    cadeia nome_materia[100], situacao[100], nome_aluno[50]
    real notas[4][100], media_bimestres[100]
    real soma_bimestres1_e_2 = 0, soma_bimestres3_e_4 = 0
    real soma_media_semestre1 = 0, soma_media_semestre2 = 0

    // Função principal do programa
    funcao inicio() {
        // Perguntando o nome do usuário
        escreva("Qual seu Nome: ")
        leia(nome_aluno)
        // Boas-vindas
        escreva("Olá ", nome_aluno, ", Seja Bem-Vindo!\n")
        // Perguntando ao usuário quantas matérias deseja inserir
        escreva("Digite a quantidade de matérias que deseja inserir: ")
        leia(quantidade_materias)

        // Laço para escrever os nomes e notas das matérias
        para (inteiro i = 0; i < quantidade_materias; i++) {
            // Escrevendo o nome da matéria
            escreva("Escreva o nome da ", i + 1, "ª Matéria: ")
            leia(nome_materia[i])
            escreva("--------------------------------\n")

            // Laço interno para solicitar as 4 notas da matéria atual
            para (inteiro r = 0; r < 4; r++) {
                escreva("Escreva a nota do ", r + 1, "º Bimestre da matéria ", nome_materia[i], ": ")
                leia(notas[r][i])

                // Acumulando as notas para as somas dos bimestres
                se (r < 2) { // Para os bimestres 1 e 2
                    soma_bimestres1_e_2 = soma_bimestres1_e_2 + notas[r][i]
                } senao { // Para os bimestres 3 e 4
                    soma_bimestres3_e_4 = soma_bimestres3_e_4 + notas[r][i]
                }
            }

            escreva("--------------------------------\n")

            // Calculando a média dos 4 bimestres
            media_bimestres[i] = (notas[0][i] + notas[1][i] + notas[2][i] + notas[3][i]) / 4

            // Calculando as médias dos semestres e acumulando para a média geral
            real media_semestre1 = (notas[0][i] + notas[1][i]) / 2 // Média do 1º e 2º bimestres (1º semestre)
            real media_semestre2 = (notas[2][i] + notas[3][i]) / 2 // Média do 3º e 4º bimestres (2º semestre)

            // Acumulando as médias dos semestres para calcular a média geral
            soma_media_semestre1 = soma_media_semestre1 + media_semestre1
            soma_media_semestre2 = soma_media_semestre2 + media_semestre2

            // Verificando a situação da matéria com base na média do 2º semestre
            se (media_semestre2 >= 7) {
                situacao[i] = "Aprovado"
            } senao se (media_semestre2 >= 6 e media_semestre2 < 7) {
                situacao[i] = "Recuperação"
            } senao {
                situacao[i] = "Reprovado"
            }
        }

        // Chamar o menu após coletar todas as informações
        menu_principal()
    }

    // Função do menu principal
    funcao menu_principal() {
        faca {
            escreva("\n-------- MENU PRINCIPAL --------\n")
            escreva("1. Ver matérias e situações\n")
            escreva("2. Ver a média geral dos semestres\n")
            escreva("3. Sair\n")
            escreva("Escolha uma opção: ")
            leia(opcao)

            // Escolha de opções
            escolha (opcao) {
                caso 1:
                    escreva("\n-------- INFORMAÇÕES DAS MATÉRIAS --------\n")
                    para (inteiro i = 0; i < quantidade_materias; i++) {
                        escreva("\nMatéria: ", nome_materia[i], "\n")
                        escreva("Notas: ")
                        para (inteiro r = 0; r < 4; r++) {
                            escreva(notas[r][i], " ") // Acessando as notas corretamente
                        }
                        escreva("\nSituação: ", situacao[i], "\n")
                        escreva("--------------------------------\n")
                    }
                    pare
                caso 2:
                    // Exibindo apenas as médias gerais dos semestres
                    real media_geral_semestre1 = soma_media_semestre1 / quantidade_materias
                    real media_geral_semestre2 = soma_media_semestre2 / quantidade_materias

                    escreva("\n-------- MÉDIA GERAL DOS SEMESTRES --------\n")
                    escreva("Média Geral do 1º Semestre: ", media_geral_semestre1, "\n")
                    escreva("Média Geral do 2º Semestre: ", media_geral_semestre2, "\n")
                    escreva("--------------------------------\n")
                    pare
                caso 3:
                    escreva("Saindo do programa....\n")
                    pare
                caso contrario:
                    escreva("Opção inválida! Tente novamente.\n")
                    pare
            }
        } enquanto (opcao != 3)
    }
}
