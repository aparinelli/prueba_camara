# Pantalla Unica Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Leave only the start screen at `1024x768` and publish it without changing the original Pages site.

**Architecture:** Replace the openFrameworks app with a minimal `ofApp` that loads two fonts and draws one responsive screen. Restore the original Pages workflow to deploy only from `main`, then mirror/publish the minimal app to a separate Pages repository.

**Tech Stack:** openFrameworks C++, shell tests, GitHub Actions Pages.

## Global Constraints

- Base resolution is `1024x768`.
- Keep title font `bin/data/fonts/CaslonCPswash.otf`.
- Keep prompt font `bin/data/fonts/Arial.ttf`.
- Keep prompt animation name `pulse`.
- Load fonts with `ofTrueTypeFontSettings` and `ofAlphabet::Latin`.
- Draw three scenes with lower text.
- Original repo Pages must not deploy from `demo`.
- New publication must use a separate Pages site.

---

### Task 1: Minimal Screen Test

**Files:**
- Modify: `tests/start_screen_test.sh`
- Delete: old tests for camera, pattern, stars, and Emscripten camera behavior.

**Interfaces:**
- Produces: assertions for minimal screen behavior and absence of old scene code.

- [x] **Step 1: Write failing assertions**

Assert `1024x768`, loaded fonts, prompt text, `pulse`, no old scene identifiers, empty addons, and workflow only on `main`.

- [x] **Step 2: Verify red**

Run `bash tests/start_screen_test.sh`; expected failure before implementation.

### Task 2: Minimal App

**Files:**
- Modify: `src/main.cpp`
- Replace: `src/ofApp.h`
- Replace: `src/ofApp.cpp`
- Modify: `addons.make`
- Delete: `bin/data/haarcascade_frontalface_default.xml`

**Interfaces:**
- Produces: a compilable one-screen app.

- [x] **Step 1: Replace old app state**

Keep only font fields, `startScreenActive`, `configurarPantallaInicio()`, and `dibujarPantallaInicio()`.

- [x] **Step 2: Draw one screen**

Draw `Prueba Cámara`, `Apretá`, a rounded `Enter` key, and `para empezar` with alpha from `pulse`.

- [x] **Step 2b: Add clickable start and scenes**

Replace the prompt with a clickable `Empezar` button, load Latin glyph ranges, and add three scenes with bottom captions and per-letter animation.

- [x] **Step 3: Restore original Pages trigger**

Set `.github/workflows/deploy.yml` push branches back to `[main]`.

### Task 3: Verify And Publish

**Files:**
- Commit all changes on `demo`.
- Publish a separate Pages site.

**Interfaces:**
- Produces: original Pages restored and new Pages URL.

- [ ] **Step 1: Run verification**

Run `for test in tests/*.sh; do bash "$test"; done` and `make -j4`.

- [ ] **Step 2: Restore old Pages**

Ensure `aparinelli/prueba_camara` deploys from `main`, not `demo`.

- [ ] **Step 3: Publish new Pages**

Create or update `aparinelli/prueba_camara_demo`, enable Pages, and push the minimal app there.
