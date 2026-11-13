class Botones{
  PImage botonJugar, botonJugar2, botonInicio, botonHistoria, botonInstrucciones;
  // Coordenadas y tamaño de los botones
  // x, y: posición del botón "Jugar" principal y referencia para Historia/Instrucciones
  // xInicio: posición X del botón Inicio
  // yJugar, xJugar: posición del botón "Jugar otra vez"
  // tam: tamaño (ancho y alto) de todos los botones, ya que son cuadrados/circulares
  
  int x,y,xInicio,yJugar,xJugar,tam;
  
  Botones(){
    
    // Carga las imágenes de cada botón 
    botonJugar = loadImage("botonJugar.png");
    botonJugar2 = loadImage("botonJugar2.png");
    botonInicio = loadImage("botonInicio.png");
    botonHistoria = loadImage("botonHistoria.png");
    botonInstrucciones = loadImage("botonInstrucciones.png");
    
    // Define las posiciones de cada botón en pantalla
    x = width/2;
    y = 530;
    xInicio = 41;
    yJugar = 560;
    xJugar = 557;
    tam = 70;
  }
  
  void botonJugar(){ // Muestra el botón y al hacer click va al juego (estado 3)
    image(botonJugar,x,y,tam,tam);
    // Detecta click: si el mouse está presionado y dentro del radio del botón
    if(mousePressed && dist(mouseX,mouseY,x,y) <= tam/2){
      Fondo.estado = 3;// Cambia el estado del juego a "jugando"
      
     
      // Si hay datos de una partida anterior (no están en sus valores iniciales),
      // se reinicia todo para empezar una partida nueva
      if(Michello.comidas != 0 || Emma.comidas != 0 || Emma.vidas != 3){
        Michello.comidas = 0;
        Emma.comidas = 0;
        Emma.vidas = 3;
        Michello.llevandoPlato = false;
        Comida.comidaLista = false;
        Comida.hayComidaEnHorno = false;
        Comida.comidaCruda = true;
        Comida.xpo = 240;
        Comida.xpa = 290;
        Comida.xc = 335;
        Comida.ypo = 500;
        Comida.ypa = 500;
        Comida.yc = 500;
      }
    }
    // Si el mouse está encima, muestra el nombre en texto arcade amarillo
    if(dist(mouseX,mouseY,x,y) <= tam/2){
      textFont(fuenteArcade);
      textSize(45);
       stroke(0);
      fill(255, 255, 0);
      text("JUGAR",x,580);
    }
  }
  
  void botonJugar2(){ // botón para jugar otra vez
    image(botonJugar2,xJugar,yJugar,tam,tam);
    if(mousePressed && dist(mouseX,mouseY,xJugar,yJugar) <= tam/2){
      Fondo.estado = 3;
      if(Michello.comidas != 0 || Emma.comidas != 0 || Emma.vidas != 3){
        Michello.comidas = 0;
        Emma.comidas = 0;
        Emma.vidas = 3;
        Michello.llevandoPlato = false;
        Comida.comidaLista = false;
        Comida.hayComidaEnHorno = false;
        Comida.comidaCruda = true;
        Comida.xpo = 240;
        Comida.xpa = 290;
        Comida.xc = 335;
        Comida.ypo = 500;
        Comida.ypa = 500;
        Comida.yc = 500;
      }
    }
    // Si el mouse está encima, muestra el nombre en texto arcade amarillo
    if(dist(mouseX,mouseY,xJugar,yJugar) <= tam/2){
      textFont(fuenteArcade);
      textSize(45);
      stroke(0);
      fill(255, 255, 0);
      text("JUGAR",x,580);
    }
  }  
  
  void botonInicio(){
    image(botonInicio,xInicio,yJugar,tam,tam);
    if(mousePressed && dist(mouseX,mouseY,xInicio,yJugar) <= tam/2){
      Fondo.estado = 0;
    }
    // Si el mouse está encima, muestra el nombre en texto arcade amarillo
    if(dist(mouseX,mouseY,xInicio,yJugar) <= tam/2){
      textFont(fuenteArcade);
      textSize(45);
       stroke(0);
      fill(255, 255, 0);
      text("INICIO",x,580);
    }
  }
  
  void botonHistoria(){ // Muestra el botón y al hacer click va a la historia (estado 2)
    image(botonHistoria,x + tam + 10,y,tam,tam);
    if(mousePressed && dist(mouseX,mouseY,x + tam + 10,y) <= tam/2){
      Fondo.estado = 2;
    }
    if(dist(mouseX,mouseY,x + tam + 10,y) <= tam/2){
      textSize(30);
      stroke(0);
      fill(255,255,0);
      text("HISTORIA",x,580);
    }
  }
  
  void botonInstrucciones(){ // Muestra el botón y al hacer click va a instrucciones (estado 1)
    image(botonInstrucciones,x - tam - 10,y,tam,tam);
    if(mousePressed && dist(mouseX,mouseY,x - tam - 10,y) <= tam/2){
      Fondo.estado = 1;
    }
    if(dist(mouseX,mouseY,x - tam - 10,y) <= tam/2){
      textSize(30);
       stroke(0);
      fill(255,255,0);
      text("INSTRUCCIONES",x,580);
    }
  }
}
