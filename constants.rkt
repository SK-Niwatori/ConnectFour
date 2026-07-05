;;;; 定数の管理

#lang racket

(require 2htdp/image)

(provide SCENE-SIZE
         PIECE-SIZE
         CELL-SIZE
         ROW-SIZE
         COLUMN-SIZE
         SCENE-BACK
         PIECE-EMPTY
         PIECE-RED
         PIECE-YELLOW
         CELL-BACK
         CELL-OUTLINE
         CELL-EMPTY
         CELL-RED
         CELL-YELLOW)

;; 画面のサイズ
(define SCENE-SIZE 800)

;; コマのサイズ
(define PIECE-SIZE 80)

;; マスのサイズ
(define CELL-SIZE 100)

;; 行のサイズ
(define ROW-SIZE 6)

;; 列のサイズ
(define COLUMN-SIZE 7)

;; ゲーム・リザルト画面の背景
(define SCENE-BACK (empty-scene SCENE-SIZE SCENE-SIZE "Dodger Blue"))

;; 空（白色）のコマ
(define PIECE-EMPTY (circle PIECE-SIZE "solid" "white"))

;; 赤色のコマ
(define PIECE-RED (circle PIECE-SIZE "solid" "red"))

;; 黄色のコマ
(define PIECE-YELLOW (circle PIECE-SIZE "solid" "yellow"))

;; マスの背景（透明）
(define CELL-BACK (square CELL-SIZE "solid" "transparent"))

;; マス内部の円周のアウトライン
(define CELL-OUTLINE (circle PIECE-SIZE "outline" "black"))

;; 空（白色）のマス
(define CELL-EMPTY (overlay CELL-OUTLINE
                            PIECE-EMPTY
                            CELL-BACK))

;; 赤色のマス
(define CELL-RED (overlay CELL-OUTLINE
                          PIECE-RED
                          CELL-BACK))

;; 黄色のマス
(define CELL-YELLOW (overlay CELL-OUTLINE
                             PIECE-YELLOW
                             CELL-BACK))

;; 現在選択中の列を示す矢印
(define ARROW (rotate 180 (overlay/offset (triangle 40 "solid" "black")
                                          0 30
                                          (rectangle 20 30 "solid" "black"))))

