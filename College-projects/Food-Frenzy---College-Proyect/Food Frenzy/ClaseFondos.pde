class Fondos {
  int estado; // Controla qué pantalla/fase se muestra (máquina de estados global)
  PImage imgPInicio, imgInstrucciones, imgHistoria, imgCocina, imgHabitacion, imgPVictoria, imgPDerrota;

  Fondos() {
    estado = 0; // Arranca en la pantalla de inicio
    imgPInicio = loadImage("pInicio.png");
    imgInstrucciones = loadImage("instrucciones.png"); // Hay que hacer la imagen de Instrucciones
    imgHistoria = loadImage("historia.png"); // Hay que hacer la imagen de Historia
    imgCocina = loadImage("cocina2.png");
    imgHabitacion = loadImage("habitacion2.png");
    imgPVictoria = loadImage("pVictoria.png");
    imgPDerrota = loadImage("pDerrota.png");
  }

  void mostrarPInicio() { //Mostrar pantalla de Inicio, nombres y apellidos
    image(imgPInicio, width/2, height/2, 600, 600);
    textFont(fuenteArcade);
    textSize(30);
    stroke(0);
    fill(255, 255, 0);
    text("SOFIA", 90, 530);
    textFont(fuenteArcade);
    textSize(30);
    stroke(0);
    fill(255, 255, 0);
    text("BARBOZA", 90, 550);

    textFont(fuenteArcade);
    textSize(30);
    stroke(0);
    fill(255, 255, 0);
    text("DELFINA", 510, 530);
    textFont(fuenteArcade);
    textSize(30);
    stroke(0);
    fill(255, 255, 0);
    text("AMENDOLARI", 510, 550);
  }

  void mostrarInstrucciones() { //Mostrar pantalla de Instrucciones
    image(imgInstrucciones, width/2, height/2, 600, 600);
  }

  void mostrarHistoria() { //Mostrar pantalla de Historia
    image(imgHistoria, width/2, height/2, 600, 600);
  }

  void mostrarCocina() { //Mostrar fondo de Cocina
    image(imgCocina, width/2, height/2, 600, 600);
  }

  void mostrarHabitacion() { //Mostrar fondo de Habitación
    image(imgHabitacion, width/2, height/2, 600, 600);
  }

  void PVictoria() { //Mostrar pantalla de Victoria
    image(imgPVictoria, width/2, height/2, 600, 600);
    textSize(30);
    fill(126, 54, 210);
    text(Michello.comidas, 423, 122); // Puntaje de platillos hechos
    fill(204, 81, 146);
    text(Emma.comidas, 423, 157); // Puntaje de platillos atrapados
  }

  void mostrarPDerrota() { //Mostrar pantalla de Derrota
    image(imgPDerrota, width/2, height/2, 600, 600);
    textSize(30);
    fill(126, 54, 210);
    text(Michello.comidas, 433, 110); // Puntaje de platillos hechos
    fill(204, 81, 146);
    text(Emma.comidas, 433, 145); // Puntaje de platillos atrapados
  }
}
