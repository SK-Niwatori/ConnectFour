#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(require "game-state.rkt")

;;;; 画面の描画

(provide draw-scene)

;; タイトル画面を描画
(define (draw-title)
  ;;TODO
  (error "未実装"))

;; ゲーム画面を描画
(define (draw-playing board turn selected-column)
  ;; 引数:
  ;;   board           : 現在の盤面を表す2次元リスト
  ;;   turn            : 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
  ;;   selected-column : 現在選択している列 (0 ~ 6)

  ;; TODO
  (error "未実装"))

;; リザルト画面を描画
(define (draw-result winner)
  ;; 引数:
  ;;   winner : 勝者 (#f, 'red, 'yellow, 'draw)

  ;; TODO
  (error "未実装"))

;; ゲーム画面の描画
(define (draw-scene w)
  (let ([board           (world-board w)]           ;; 現在の盤面を表す2次元リスト
        [turn            (world-turn w)]            ;; 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
        [selected-column (world-selected-column w)] ;; 現在選択している列 (0 ~ 6)
        [winner          (world-winner w)]          ;; 勝者 (#f, 'red, 'yellow, 'draw)
        [scene           (world-scene w)]           ;; 現在の画面 ('title, 'playing, 'result)
        )
    (cond [(eq? scene 'title)   (draw-title)]
          [(eq? scene 'playing) (draw-playing board
                                              turn
                                              selected-column)]
          [(eq? scene 'result)  (draw-result winner)]
          [else                 (error 'draw.rkt/draw-scene "ゲームの状態`scene`が無効な値です: ~a" scene)])))
