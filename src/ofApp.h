#pragma once

#include "ofMain.h"
#include <vector>

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
    struct Scene {
        std::string title;
        std::string caption;
    };

    ofTrueTypeFont startTitleFont;
    ofTrueTypeFont startPromptFont;
    std::vector<Scene> scenes;
    ofRectangle startButtonBounds;
    int currentScene = 0;
    bool startScreenActive = true;

    void configurarPantallaInicio();
    void dibujarPantallaInicio();
    void dibujarEscenaActual();
    void avanzarEscena();
};
