;;;; 定数の管理

#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 画面のサイズ
(define SCENE-SIZE 800)

;; ゲーム・リザルト画面の背景
(define SCENE-BACK (empty-scene SCENE-SIZE SCENE-SIZE "Dodger Blue"))
