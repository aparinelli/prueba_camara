#include "ofApp.h"

namespace {
const int APP_W = 1024;
const int APP_H = 768;
const int TITLE_FONT_SIZE = 88;
const int BODY_FONT_SIZE = 25;

void dibujarTextoCentrado(ofTrueTypeFont& font, const std::string& text, float x, float y) {
    ofRectangle bounds = font.getStringBoundingBox(text, 0, 0);
    font.drawString(text, x - bounds.width * 0.5f - bounds.x, y - bounds.height * 0.5f - bounds.y);
}

float medirTextoUtf8(ofTrueTypeFont& font, const std::string& text) {
    float width = 0.0f;
    for (uint32_t codePoint : ofUTF8Iterator(text)) {
        std::string letter = ofUTF8ToString(codePoint);
        width += font.getStringBoundingBox(letter, 0, 0).width;
    }
    return width;
}

void drawAnimatedTextCentered(
        ofTrueTypeFont& font,
        const std::string& text,
        float centerX,
        float baselineY,
        float time,
        float amplitude) {
    float x = centerX - medirTextoUtf8(font, text) * 0.5f;
    int index = 0;
    for (uint32_t codePoint : ofUTF8Iterator(text)) {
        std::string letter = ofUTF8ToString(codePoint);
        ofRectangle bounds = font.getStringBoundingBox(letter, 0, 0);
        float wave = sin(time * 3.0f + index * 0.42f);
        float alpha = ofLerp(155.0f, 255.0f, 0.5f + 0.5f * wave);
        ofSetColor(0, alpha);
        font.drawString(letter, x, baselineY + wave * amplitude);
        x += bounds.width;
        index++;
    }
}

ofTrueTypeFontSettings crearFontSettings(const std::string& path, int size) {
    ofTrueTypeFontSettings settings(ofToDataPath(path, true), size);
    settings.antialiased = true;
    settings.dpi = 72;
    settings.direction = OF_TTF_LEFT_TO_RIGHT;
    settings.addRanges(ofAlphabet::Latin);
    return settings;
}
}

void ofApp::setup() {
    ofSetWindowTitle("Prueba Camara");
    ofSetFrameRate(60);
    ofBackground(255);
    ofEnableSmoothing();
    ofEnableAntiAliasing();

    configurarPantallaInicio();
}

void ofApp::configurarPantallaInicio() {
    ofTrueTypeFontSettings titleSettings = crearFontSettings("fonts/CaslonCPswash.otf", TITLE_FONT_SIZE);
    ofTrueTypeFontSettings promptSettings = crearFontSettings("fonts/Arial.ttf", BODY_FONT_SIZE);
    startTitleFont.load(titleSettings);
    startPromptFont.load(promptSettings);

    scenes = {{
        {"Escena 1", "Primera escena: el título respira."},
        {"Escena 2", "Segunda escena: las letras flotan."},
        {"Escena 3", "Tercera escena: el pulso se queda."},
    }};
}

void ofApp::update() {}

void ofApp::draw() {
    ofBackground(255);

    float scale = std::min(ofGetWidth() / float(APP_W), ofGetHeight() / float(APP_H));
    float offsetX = (ofGetWidth() - APP_W * scale) * 0.5f;
    float offsetY = (ofGetHeight() - APP_H * scale) * 0.5f;

    ofPushMatrix();
    ofTranslate(offsetX, offsetY);
    ofScale(scale);
    if (startScreenActive) {
        dibujarPantallaInicio();
    } else {
        dibujarEscenaActual();
    }
    ofPopMatrix();
}

void ofApp::dibujarPantallaInicio() {
    ofPushStyle();
    ofSetColor(0);

    const std::string title = "Prueba Cámara";
    if (startTitleFont.isLoaded()) {
        dibujarTextoCentrado(startTitleFont, title, APP_W * 0.5f, APP_H * 0.42f);
    } else {
        ofDrawBitmapStringHighlight(title, APP_W * 0.5f - 65.0f, APP_H * 0.42f);
    }

    const float pulse = 0.5f + 0.5f * sin(ofGetElapsedTimef() * 2.2f);
    const float buttonAlpha = ofLerp(185.0f, 255.0f, pulse);
    const float buttonW = 170.0f;
    const float buttonH = 54.0f;
    startButtonBounds = ofRectangle(APP_W * 0.5f - buttonW * 0.5f, APP_H * 0.59f, buttonW, buttonH);

    ofFill();
    ofSetColor(255, buttonAlpha);
    ofDrawRectRounded(startButtonBounds, 12.0f);
    ofSetLineWidth(2.0f);
    ofNoFill();
    ofSetColor(0, buttonAlpha);
    ofDrawRectRounded(startButtonBounds, 12.0f);
    ofFill();

    if (startPromptFont.isLoaded()) {
        dibujarTextoCentrado(startPromptFont, "Empezar",
            startButtonBounds.getCenter().x, startButtonBounds.getCenter().y);
    } else {
        ofDrawBitmapString("Empezar", startButtonBounds.x + 56.0f, startButtonBounds.y + 33.0f);
    }

    ofPopStyle();
}

void ofApp::dibujarEscenaActual() {
    if (scenes.empty()) return;

    const Scene& scene = scenes[currentScene % scenes.size()];
    const float t = ofGetElapsedTimef();

    ofPushStyle();
    ofSetColor(0);

    if (startTitleFont.isLoaded()) {
        drawAnimatedTextCentered(startTitleFont, scene.title, APP_W * 0.5f, APP_H * 0.42f, t, 4.0f);
    } else {
        ofDrawBitmapStringHighlight(scene.title, APP_W * 0.5f - 45.0f, APP_H * 0.42f);
    }

    if (startPromptFont.isLoaded()) {
        drawAnimatedTextCentered(startPromptFont, scene.caption, APP_W * 0.5f, APP_H - 96.0f, t + 0.8f, 2.0f);
    } else {
        ofDrawBitmapString(scene.caption, APP_W * 0.5f - 145.0f, APP_H - 96.0f);
    }

    ofPopStyle();
}

void ofApp::avanzarEscena() {
    if (!scenes.empty()) currentScene = (currentScene + 1) % scenes.size();
}

void ofApp::keyPressed(int key) {
    if (key == OF_KEY_RETURN || key == '\r' || key == '\n') {
        if (startScreenActive) {
            startScreenActive = false;
        } else {
            avanzarEscena();
        }
    }
}

void ofApp::keyReleased(int key) {}
void ofApp::mouseMoved(int x, int y) {}
void ofApp::mouseDragged(int x, int y, int button) {}
void ofApp::mousePressed(int x, int y, int button) {
    float scale = std::min(ofGetWidth() / float(APP_W), ofGetHeight() / float(APP_H));
    float offsetX = (ofGetWidth() - APP_W * scale) * 0.5f;
    float offsetY = (ofGetHeight() - APP_H * scale) * 0.5f;
    glm::vec2 appPoint = {(x - offsetX) / scale, (y - offsetY) / scale};

    if (startScreenActive && startButtonBounds.inside(appPoint)) {
        startScreenActive = false;
        return;
    }

    if (!startScreenActive) avanzarEscena();
}
void ofApp::mouseReleased(int x, int y, int button) {}
