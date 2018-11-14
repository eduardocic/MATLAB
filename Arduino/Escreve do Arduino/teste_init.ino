/******************************************************************
 *  Definição de envio de variáveis do tipo float. A ideia aqui
 * é quebrar a variável do tipo float de tal forma que eu consiga 
 * enviar byte a byte. 
 * 
 *  No caso, para enviar o respectivo valor, eu criei uma 'union'.
 *  
 *  Com isso, eu necessariamente quebro uma variável do tipo float,
 * que é de 4 bytes, em seus respectivos 4 bytes. Dessa forma, eu
 * envio byte a byte e com o envio de 4 bytes do outro lado eu 
 * terei uma variável do typo float.
 * 
 *   Para tal, eu criarei uma função para fazer o respectivo envio
 * de dado.
 * 
 *   Engraçado é que para eu receber os parâmetros do outro lado e
 * receber pelo 'Matlab' eu tenho de enviar o byte menos significa-
 * tivo para o mais significativo.
 * 
 * Eduardo H. Santos.
 * 14 de Novembro de 2018.
 ******************************************************************/

// A definição de uma 'union' para float 
// -------------------------------------
typedef union {
  float dado;
  uint8_t num[sizeof(float)];
} float_32;


// A definição de uma 'union' para int
// -----------------------------------
typedef union {
  int dado;
  uint8_t num[sizeof(int)];
} int_16;



// Protótipo de função
// -------------------
void send_float(float valor);
void send_int(int valor);


// Função 'SETUP'
// --------------
void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT); 
}

// Função 'LOOP'
// -------------
void loop() {

  // =======================================================================
  //   Código utilizado se eu quiser ficar na espera de receber um parâme-
  // tros do Matlab. 
  //
  //   Se eu quiser ficar nessa espera eu simplesmente executo este código.
  // =======================================================================
  uint8_t LED;
  if (Serial.available()){
    LED = Serial.read();
    if( LED == 0 ){
      digitalWrite(13, LOW);
    }
    if( LED == 1 ){
      digitalWrite(13, HIGH);
    }
  }

  // =======================================================================
  //   Envia o valor do 'float'.
  //
  //   Se eu quiser fazer o envio eu simplesmente faço executo este código 
  // abaixo.
  // =======================================================================
  //  send_float(PI);
  //  delay(100);
}


void send_float(float valor){
  // Criação da estrutura para secção dos dados.
  float_32 foo {.dado = valor};
    
  for (int i = 0 ; i < 4 ; i++){
    Serial.write(foo.num[i]);
  }
}


void send_int(int valor){
  // Criação da estrutura para secção dos dados.
  int_16 foo {.dado = valor};
    
  for (int i = 0 ; i < 2 ; i++){
    Serial.write(foo.num[i]);
  }
}
