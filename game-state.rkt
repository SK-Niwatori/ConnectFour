#lang racket
(require 2htdp/image)
(require 2htdp/universe)

;;;; 状態の管理

;; ゲーム全体の状態
(define (world board           ;; 現在の盤面を表す2次元リスト
               turn            ;; 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
               selected-column ;; 現在選択している列 (0 ~ 6)
               winner          ;; 勝者 (#f, 'red, 'yellow, 'draw)
               scene           ;; 現在の画面 ('title, 'playing, 'result)
               )
  (list board turn selected-column winner scene))
