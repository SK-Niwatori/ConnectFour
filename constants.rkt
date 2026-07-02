;;;; 定数の管理

#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 画面のサイズ
(define SCENE-SIZE 800)

;; コマのサイズ
(define PIECE-SIZE 80)

;; ゲーム・リザルト画面の背景
(define SCENE-BACK (empty-scene SCENE-SIZE SCENE-SIZE "Dodger Blue"))

;; 空（白色）のコマ
(define PIECE-EMPTY (circle PIECE-SIZE "solid" "white"))

;; 赤色のコマ
(define PIECE-RED (circle PIECE-SIZE "solid" "red"))

;; 黄色のコマ
(define PIECE-YELLOW (circle PIECE-SIZE "solid" "yellow"))
