#lang racket

(require 2htdp/universe)
(require "game-state.rkt")
(require "board.rkt")
(require "draw.rkt")
(require "input.rkt")

;;;; ゲームの起動

;; アプリケーションの実行を開始
(big-bang (make-initial-world)
          (to-draw draw-scene)
          (on-key control))
