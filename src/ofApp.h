#pragma once
#include "ofMain.h"
#include <vector>
#include <string>

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y);
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);

private:
    // Patron ap105 de Inkscape.
    float patScale     = 1.0f;   // tamano del tile       (q / w)
    float patAngle     = 30.0f;  // rotacion del patron   (z / x)
    float patOffX      = 0.0f;   // desplazamiento x      (flechas)
    float patOffY      = 0.0f;   // tile-grid y offset
    float patTile      = 76.0f;  // base tile size (SVG: 377.87 × 0.2 ≈ 76)
    ofPath patPath;

    // Espirales animadas.
    struct Spiral {
        float cx, cy;
        float maxRadius;
        float revolutions;
        float argument;     // angulo inicial en radianes
        float expansion;    // 1 = Archimedean
        float strokeWidth;
        ofColor colStart, colEnd;
        float gradX0, gradX1;  // gradient fade-out x range (from SVG)
        float spinSpeed;       // radians/sec  (keys 1-4)
        int   steps = 900;
        ofMesh mesh;
    };
    Spiral sp1, sp2;

    // Estrellas negras tomadas del SVG.
    struct Star {
        std::string id;
        ofPath    path;
        glm::vec2 svgCenter;
        float freqX, freqY;
        float ampX,  ampY;
        float phaseX, phaseY;
        float angle    = 0.0f;
        float angleVel = 0.0f;
    };
    std::vector<Star> stars;

    // Caja amarilla con glow.
    std::vector<std::vector<glm::vec2>> boxFaces;
    glm::vec2 boxDrift = {0, 0};

    float t       = 0.0f;
    bool  paused  = false;
    bool  showHUD = true;

    static std::vector<glm::vec2> parsearPathSVGRelativo(const std::string& d);

    void configurarPatron();
    void configurarEspirales();
    void configurarEstrellas();
    void configurarCaja();
    void actualizarAnimacion();

    void armarMallaEspiral(Spiral& sp);
    void dibujarPatron();
    void dibujarCaja();
    void dibujarEstrellas();
    void dibujarEspirales();
    void dibujarHUD();
};
