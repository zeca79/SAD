# <h1 align="center">💻 Relatório Prático II</h1>

Atividade Prática para, desenvolvimento (descrição e síntese em VHDL) e testes (análise de temporização e simulação) da SAD  (Sum of Absolute Differences)

* [V1:](https://github.com/zeca79/SAD/blob/main/README.md#-v1---1-amostra-de-cada-bloco-por-vez-barreira-de-registradores-na-entrada-e-na-sa%C3%ADda) 1 amostra de cada bloco por vez; barreira de registradores na entrada e na saída
* [V3:](https://github.com/zeca79/SAD/blob/main/README.md#-v3---4-amostras-de-cada-bloco-por-vez-barreira-de-registradores-na-entrada-e-na-sa%C3%ADda) 4 amostras de cada bloco por vez; barreira de registradores na entrada e na saída

## ✒️ Alunos Grupo-13

- Gabriel Raul Marino (Matrícula 20204843)
- Marco Jose Pedro (Matrícula 20105254)

## 📁 SAD

### O que é uma SAD

A SAD (Sum of Absolute Differences, ou Soma das Diferenças Absolutas) é uma medida frequentemente usada em processamento de imagens e visão computacional 
para comparar blocos de pixels entre duas imagens ou duas partes de uma imagem. 
A SAD é utilizada, por exemplo, em algoritmos de compressão de vídeo e de reconhecimento de padrões.

A ideia básica é calcular a soma das diferenças absolutas entre amostras correspondentes de dois blocos de imagens. Isso é feito da seguinte maneira:

1. **Seleção de Blocos:** Dois blocos de imagens são escolhidos, um de cada imagem ou de partes diferentes da mesma imagem.
2. **Cálculo das Diferenças:** Para cada par de amostra correspondentes (uma de cada bloco), calcula-se a diferença absoluta. 
3. **Soma das Diferenças:** As diferenças absolutas calculadas no passo anterior são somadas para obter um único valor, que é a SAD.

Matematicamente, se <kbd>**A**</kbd> e <kbd>**B**</kbd> são os dois blocos de imagens a serem comparados, a SAD é calculada como:

<kbd>**{SAD}=sum_{i,j}|A(i,j)-B(i,j)|**</kbd> 

onde <kbd>**(i,j)**</kbd> são as coordenadas das amostras dentro dos blocos.

A SAD é uma medida simples e eficiente que proporciona uma estimativa da similaridade entre dois blocos de imagens. 
Quanto menor o valor da SAD, mais similares são os blocos. Por sua simplicidade, a SAD é amplamente utilizada em aplicações em tempo real, onde a velocidade de cálculo é crucial.

### 📄 V1 - 1 amostra de cada bloco por vez; barreira de registradores na entrada e na saída

#### Especificação do Comportamento

- Quando <kbd>**iniciar = 1**</kbd> o sistema realiza o cálculo descrito na equação do somatório de forma sequencial:
  - Lê um par de amostras de <kbd>**Mem_A**</kbd> e de <kbd>**Mem_B**</kbd> e as armazena nas variáveis <kbd>**pA**</kbd> e <kbd>**pB**</kbd>, respectivamente.
  - Calcula <kbd>**ABS(pA - pB)**</kbd> e acumula o resultado.
- Quando terminar, o resultado da SAD deve ser mostrado com a máxima precisão, i.e., jamais ocorre overflow.
- O resultado mais recente de SAD deve estar disponível na saída <kbd>**SAD**</kbd> até o momento em que um novo cálculo de SAD tenha sido concluído.

![](https://iili.io/JpMIfta.png)


#### FSM 

Máquinas de estados finitos – Finite State Machines (FSM)

![](https://iili.io/JpMIWNe.png)
*FSM pedido na atividade*

![](https://i.ibb.co/dbrLJKs/FSM.png)
*FSM gerado no RTL Viewer*

![](https://i.ibb.co/cXXGGkm/BO1.png)
*Bloco Operativo RTL Viewer*

![](https://i.ibb.co/nj2xqf2/bc.png)
*Bloco de Controle RTL Viewer*

#### Simulação

Após ser testada em simulação, a SAD V1 se comportou conforme o esperado. No entanto, é praticamente impossível verificar todas as combinações possíveis de entradas utilizando o **ModelSim** e um arquivo de **estimulus.do**. Sendo assim foram testadas as principais combinações de entradas com os resultados esperado da SAD (matrizes zeradas, aleatórias e uma zerada com a outra cheia para teste de *overflow*) e em todas as combinações funcionou corretamente.
A frequência máxima (*Fmax*) apontada no *TimeQuest Timing Analyzer* foi de **206.1 MHz**, com isso o <kbd>Clock</kbd> foi configurado para <kbd>**5ns**</kbd>, pois 
<kbd>**1/206.1^<sup>6</sup>= 4,85^<sup>-9</sup>**</kbd> 

**Estimulos.do**

```vhdl
force -repeat 5ns /clk 0 0ns, 1 2.5ns
force /enable 0 0ns, 1 10ns, 0 60ns -r 2000ns 
force /reset 0 0ns -r 2000ns

#force /sample_ori 00000000 0ns -r 2000ns
#force /sample_can 00000000 0ns -r 2000ns

#force /sample_ori 00000001 0ns -r 2000ns
#force /sample_can 00000000 0ns -r 2000ns

#force /sample_ori 00000000 0ns -r 2000ns
#force /sample_can 11111111 0ns -r 2000ns
#255:11111111 SAD:16.320

force /sample_ori 00111010 0ns -r 2000ns
force /sample_can 01101000 0ns -r 2000ns
#104:01101000 58:00111010 SAD:2.944

run 2000ns

```

![](https://iili.io/JpVNvsa.png)

### 📄 V3 - 4 amostras de cada bloco por vez; barreira de registradores na entrada e na saída

#### Especificação do Comportamento

Aumentando o paralelismo do B.O.
 Processando 4 pares de pixels por ciclo, será necessário executar 16 vezes o laço para processar todos os 64 pares!
- A memória será acessada somente 16 vezes (cada linha da memória contém 4 pixels);

![](https://iili.io/JpMu5Gf.png)

#### Simulação

Após ser testada em simulação, a SAD V3 também se comportou conforme o esperado com as combinações apresentadas.

![](https://i.ibb.co/crS4g7d/wave.png)
