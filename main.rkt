#lang racket

(require 2htdp/universe)
(require "game-state.rkt")
(require "board.rkt")
(require "draw.rkt")
(require "input.rkt")

;;;; ゲームの起動

;; アプリケーションの実行を開始
(define (start)
  (big-bang (world (make-empty-board) 'red 0 #f 'title)
            (to-draw draw-scene)
            (on-key control)))
