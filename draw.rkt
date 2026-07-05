;;;; 画面の描画

#lang racket

(require 2htdp/image)
(require "game-state.rkt")
(require "constants.rkt")

(provide draw-scene)

;; ゲーム画面の描画
(define (draw-scene w)
  ;; 引数:
  ;;   w : ゲーム全体の状態

  (let ([board  (world-board w)]  ;; 現在の盤面を表す2次元リスト
        [turn   (world-turn w)]   ;; 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
        [column (world-column w)] ;; 現在選択している列 (0 ~ 6)
        [winner (world-winner w)] ;; 勝者 (#f, 'red, 'yellow, 'draw)
        [scene  (world-scene w)]  ;; 現在の画面 ('title, 'playing, 'result)
        )
    (cond [(eq? scene 'playing) (draw-playing board
                                              turn
                                              column)]
          [(eq? scene 'title)   (draw-title)]
          [(eq? scene 'result)  (draw-result board winner)]
          [else                 (error 'draw.rkt/draw-scene "ゲームの状態`scene`が無効な値です: ~a" scene)])))

;; 盤面を描画
(define (draw-board board)
  ;; 引数:
  ;;   board : 現在の盤面を表す2次元リスト
  ;;
  ;; 戻り値:
  ;;   盤面を描画した画像

  ;; TODO
  (error "未実装"))

;; ゲーム画面を描画
(define (draw-playing board turn column)
  ;; 引数:
  ;;   board  : 現在の盤面を表す2次元リスト
  ;;   turn   : 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
  ;;   column : 現在選択している列 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   ゲーム画面を描画した画像

  ;; TODO
  (error "未実装"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ここから下を実装
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; タイトル画面を描画
(define (draw-title)
  ;; 戻り値:
  ;;   タイトル画面を描画した画像

  ;; TODO
  (error "未実装"))

;; リザルト画面を描画
(define (draw-result board winner)
  ;; 引数:
  ;;   board  : 現在の盤面を表す2次元リスト
  ;;   winner : 勝者 ('red, 'yellow, 'draw)
  ;;
  ;; 戻り値:
  ;;   リザルト画面を描画した画像

  ;; TODO
  (error "未実装"))
