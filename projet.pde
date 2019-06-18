/* ---------------------- */
/* - Variables globales - */
/* ---------------------- */

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
AudioInput in;
FFT fft;

int sampleRate = 44100;
int bufferSize = 2048; 
int fft_base_freq = 86; 
int  fft_band_per_oct = 1;
int numZones = 0;

int t;
int k = 50;




// matrice de rectangle (notre grille de rectangle)
ArrayList<ArrayList<ClassRectangle>> matRect = new ArrayList<ArrayList<ClassRectangle>>();
Decideur decideur ;



//////////////////////////////////////////////////////////////





/* ---------------------- */
/* ------- SETUP -------- */
/* ---------------------- */

void setup() {
  size(900, 900);

  background(0, 0, 0);
  rectMode(CENTER);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO ,bufferSize);
  
  fft = new FFT( bufferSize, sampleRate );
  fft.logAverages(fft_base_freq, fft_band_per_oct); 
  fft.window(FFT.HAMMING);

  numZones = fft.avgSize();

  // Créer des rectangles et les ajoutent dans noter matrice (stucture qui reprèsente la grille
  for (int i = 0; i<width; i+=100) {
    ArrayList<ClassRectangle> list = new ArrayList<ClassRectangle>();
    for (int j= 0; j<height; j+=100) {
      ClassRectangle cr = new ClassRectangle(i+50, j+50, 0);
      list.add(cr);
    }//for j
    matRect.add(list);
  }//for i
  decideur = new Decideur(matRect);
}//setup      

/* ---------------------- */
/* -------- DRAW ------- */
/* -------------------- */

void draw() {

  //resetGrid();
  clear();

  // ************ AVERAGE ************ //
  fft.forward(in.mix); 
  int highZone = numZones - 1;

  for (int i = 0; i < numZones; i++) {
    float average = fft.getAvg(i); 
    float avg = 0;
    int lowFreq;

    if ( i == 0 ) {
      lowFreq = 0;
    } else {
      lowFreq = (int)((sampleRate/2) / (float)Math.pow(2, numZones - i));
    }

    int hiFreq = (int)((sampleRate/2) / (float)Math.pow(2, highZone - i)); 
    int lowBound = fft.freqToIndex(lowFreq);
    int hiBound = fft.freqToIndex(hiFreq);

    for (int j = lowBound; j <= hiBound; j++) { 
      float spectrum = fft.getBand(j); 
      avg += spectrum;
    }

    avg /= (hiBound - lowBound + 1);
    average = avg;
    average *= k;
    // ************ AVERAGE ************ //

    // définition taille 
    t = (int)average;

    DessinPattern(i,t,average);
  
    // ********** //
  }//for
}//draw

/* ---------------------- */
/* ------ Fonctions ------ */
/* ---------------------- */

void DessinPattern(int i, int t, float average){
// ***** 0 Hz - 86 Hz ***** //
    if (i == 0) {
      if (average > 52.0 && average < 125.0) {
        decideur.dessin(0,t);
      }
    }
    // ********** //

    // ***** 86 Hz - 172 Hz ***** //
    if (i == 1) {
      if (average > 56.0) {
        decideur.dessin(1,t);
      }
    }
    // ********** //

    // ***** 172 Hz - 344 Hz ***** //
    if (i == 2) {
      if (average > 54.0) {
        decideur.dessin(2,t);
      }
    }
    // ********** //

    // ***** 344 Hz - 689 Hz ***** //
    if (i == 3) {
      if (average > 45.0) {
        decideur.dessin(3,t);
      }
    }
    // ********** //

    // ***** 689 Hz - 1378 Hz ***** //
    if (i == 4) {
      if (average > 35.0 && average < 45.0) {
        decideur.dessin(4,t);
      }
    }
    // ********** //

    // ***** 1378 Hz - 2756 Hz ***** //
    if (i == 5) {
      if (average > 40.0) {
        decideur.dessin(5,t);
      }
    }
    // ********** //

    // ***** 2756 Hz - 5512 Hz ***** //
    if (i == 6) {
      if (average > 38.0) {
        decideur.dessin(6,t);
      }
    }
    // ********** //

    // ***** 5512 Hz - 11025 Hz ***** //
    if (i == 7) {
      if (average > 30.0) {
        decideur.dessin(7,t);
      }
    }
    // ********** //

    // ***** 11025 Hz - 22050 Hz ***** //
    if (i == 8) {
      if (average > 5.0) {
        decideur.dessin(8,t);
      }
    }
}


void keyPressed() {
  if (keyCode == 107) 
  {
    k += 1;
  }
  else if (keyCode==109) 
  {
    k -=1;
  }
  else if (keyCode == 97) 
  {
   decideur.newMat(1);
  }
  else if (keyCode == 98) 
  {
   decideur.newMat(2);
  }
}