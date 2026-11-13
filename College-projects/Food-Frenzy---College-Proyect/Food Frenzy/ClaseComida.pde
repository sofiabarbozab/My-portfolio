class Comidas {
  // Posiciones de cada comida: po=pollo, pa=papas, c=carne
  int xpo, ypo, xpa, ypa, xc, yc, vel, tam;
  int hx1, hx2, hy, tiempoHorno, tiempoCoccion; // Datos del horno
  boolean comidaCruda, comidaCocida, hayComidaEnHorno, comidaLista;
  // Sprites crudos y cocidos de cada alimento
  PImage ImgCarnec, ImgPapasc, ImgPolloc;
  PImage ImgCarneco, ImgPapasco, ImgPolloco;

  Comidas() {
    // Zona del horno (rango X y altura Y)
    hx1 = 300;
    hx2 = 600;
    hy = 165;
    tam = 40;
    // Posiciones iniciales de cada comida en la cocina
    xpo = 240;
    xpa = 290;
    xc = 335;
    ypo = 500;
    ypa = 500;
    yc = 500;
    vel = 3;
    tiempoHorno = millis();
    tiempoCoccion = 2000; // 2 segundos de cocción
    comidaLista = false;
    hayComidaEnHorno = false;
    comidaCruda = true;

    ImgCarnec = loadImage("carneCruda.png");
    ImgPapasc = loadImage("papasCrudas.png");
    ImgPolloc = loadImage("polloCrudo.png");
    ImgCarneco = loadImage("carneCocida.png");
    ImgPapasco = loadImage("papasCocidas.png");
    ImgPolloco = loadImage("polloCocido.png");
  }

  void sostenerComida() {
    // Si Michello no lleva nada y se acerca a alguna comida, la levanta
    if (!Michello.llevandoPlato) {
      if (dist(Michello.x, Michello.y, xpa, ypa) < 100) {
        Michello.llevandoPlato = true;
      }
      if (dist(Michello.x, Michello.y, xc, yc) < 100) {
        Michello.llevandoPlato = true;
      }
      if (dist(Michello.x, Michello.y, xpo, ypo) < 100) {
        Michello.llevandoPlato = true;
      }
    }
  }

  // Mantiene la comida pegada a la mano del cocinero mientras la lleva
  void actualizarPosicionEnMano() {
    if (Michello.llevandoPlato) {
      // El offset en X cambia según si mira a la izquierda o no
      int offsetX = (Michello.direccion == 1) ? -35 : 15;
      xc  = Michello.x + offsetX;
      yc  = Michello.y;
      xpa = Michello.x + offsetX;
      ypa = Michello.y - 10;
      xpo = Michello.x + offsetX;
      ypo = Michello.y - 20;
    }
  }

  void dibujarComidaCruda() {
    if (comidaCruda) {
      image(ImgCarnec, xc, yc, 40, 40);
      image(ImgPapasc, xpa, ypa, 40, 40);
      image(ImgPolloc, xpo, ypo, 40, 40);
    }
  }
  // Dibuja la comida por medio de condicional de NOT, comida cruda diferente de cocida
  void dibujarComidaCocida() {
    if (!comidaCruda) {
      image(ImgCarneco, xc, yc, 40, 40);
      image(ImgPapasco, xpa, ypa, 40, 40);
      image(ImgPolloco, xpo, ypo, 40, 40);
    }
  }

  // Revisa si alguna comida cocida llegó a la zona de la puerta → pasa a fase 2
  void revisarPuerta() {
    boolean carneEnPuerta = (xc  >= 105 && xc  <= 115 && yc  >= 274 && yc  <= 342);
    boolean papasEnPuerta = (xpa >= 105 && xpa <= 115 && ypa >= 274 && ypa <= 342);
    boolean polloEnPuerta = (xpo >= 105 && xpo <= 115 && ypo >= 274 && ypo <= 342);

    if (!comidaCruda && (carneEnPuerta && papasEnPuerta && polloEnPuerta)) {
      // Posiciona cada comida arriba, en X aleatorias, para arrancar la caída
      xc  = int(random(20, 580));
      yc  = -40;
      xpa = int(random(20, 580));
      ypa = -40;
      xpo = int(random(20, 580));
      ypo = -40;
      Fondo.estado = 4;
    }
  }

  void depositarHorno() {
    boolean cercaHorno = (Michello.x >= hx1 && Michello.y <= hy && Michello.x <= hx2);
    // Solo mete la comida si: está cerca, lleva algo, el horno está libre y presiona E
    if (cercaHorno && Michello.llevandoPlato && !hayComidaEnHorno && keyPressed && key == 'e') {
      hayComidaEnHorno = true;
      comidaLista = false;
      tiempoHorno = millis(); // Arranca el temporizador de cocción
      Michello.llevandoPlato = false;
      // Manda la comida fuera de pantalla para que "desaparezca"
      xc  = -200;
      yc  = -200;
      xpa = -200;
      ypa = -200;
      xpo = -200;
      ypo = -200;
    }
  }

  void actualizarHorno() {
    // Cuando pasa el tiempo de cocción, marca la comida como lista
    if (hayComidaEnHorno && !comidaLista) {
      if (millis() - tiempoHorno >= tiempoCoccion) {
        comidaLista = true;
      }
    }
  }

  void retirarHorno() {
    boolean cercaHorno = (Michello.x >= hx1 && Michello.y <= hy && Michello.x <= hx2);

    // Si la comida está lista y Michello llega sin llevar nada, la retira automáticamente
    if (cercaHorno && comidaLista && !Michello.llevandoPlato) {
      xc  = Michello.x + 15;
      yc  = Michello.y;
      xpa = Michello.x + 15;
      ypa = Michello.y - 10;
      xpo = Michello.x + 15;
      ypo = Michello.y - 20;

      Michello.comidas = 3;
      comidaCruda = false;      // Ahora se dibuja el sprite cocido
      hayComidaEnHorno = false;
      comidaLista = false;
      Michello.llevandoPlato = true;
    }
  }

  void caerComidacCa() {
    yc += vel;
    if (yc > height + tam) {       // se fue de la pantalla por abajo
      xc = int(random(150, 500));   // nueva X al azar
      yc = -40;                    // vuelve a aparecer arriba
      Emma.vidas--;                // se le escapó esta comida: pierde 1 vida
    }
  }

  void caerComidacoPa() {
    ypa += vel;
    if (ypa > height + tam) {
      xpa = int(random(150, 500));
      ypa = -40;
      Emma.vidas--;
    }
  }

  void caerComidacoPo() {
    ypo += vel;
    if (ypo > height + tam) {
      xpo = int(random(100, 500));
      ypo = -40;
      Emma.vidas--;
    }
  }

  boolean colisionComida() {
    // Variable que indica si hubo alguna colisión en esta llamada a la función
    boolean huboColision = false;
    // --- Colisión con la primera comida (xpo, ypo) ---
    // dist() calcula la distancia entre el centro de Emma y el centro de esta comida
    // Si esa distancia es menor que la suma de los "radios" de ambos (tam/2),
    // significa que los círculos/objetos se están tocando o superponiendo
    if (dist(Emma.x, Emma.y, xpo, ypo) < (Emma.tam / 2) + (tam / 2)) {
      Emma.comidas++;                                              // Emma "come": se incrementa el contador
      xpo = int(random(20, 580));                                  // Se posiciona la comida aleatoriamente en X
      ypo = -40;                                                      // Se manda la comida fuera de la pantalla
      huboColision = true;                                            //Se marca que hubo colisión
    }
    
    // Misma lógica, segunda comida
    if (dist(Emma.x, Emma.y, xpa, ypa) < (Emma.tam / 2) + (tam / 2)) {
      Emma.comidas++;
      xpa = int(random(20, 580));
      ypa = -40;
      huboColision = true;
    }
    // Misma lógica, tercera comida
    if (dist(Emma.x, Emma.y, xc, yc) < (Emma.tam / 2) + (tam / 2)) {
      Emma.comidas++;
      xc = int(random(20, 580));
      yc = -40;
      huboColision = true;
    }
  // Devuelve true si Emma chocó con al menos una comida, false si no chocó con ninguna
    return huboColision;
  }
}
