#include "ofMain.h"
#include "ofApp.h"

int main(){
#ifdef TARGET_EMSCRIPTEN
    // Workaround: ctype<char>::do_widen crashes in Emscripten (no pthread) when
    // ofShader::linkProgram() tries to format numbers via ostream locale during setup.
    // Suppressing logs prevents the locale formatting path entirely.
    ofSetLogLevel(OF_LOG_SILENT);
    ofSetupOpenGL(1920, 1080, OF_WINDOW);
    ofSetLogLevel(OF_LOG_NOTICE);  // restore after setup
    ofRunApp(new ofApp());
#else
    ofGLFWWindowSettings settings;
    settings.setSize(1920, 1080);
    settings.numSamples = 8;
    settings.windowMode = OF_WINDOW;
    auto window = ofCreateWindow(settings);
    ofRunApp(window, make_shared<ofApp>());
    ofRunMainLoop();
#endif
}
