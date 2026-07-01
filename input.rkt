;;;; キー入力の処理

#lang racket

(require "game-state.rkt")
(require "judge.rkt")
(require "board.rkt")

(provide control)

;; タイトル画面でのキー入力処理
(define (control-title w k)
  ;; 引数:
  ;;   w : ゲーム全体の状態
  ;;   k : 入力されたキー ("left", "right", " ", … など)
  
  ;; TODO
  (error "未実装"))

;; ゲーム中の画面でのキー入力処理
(define (control-playing w k)
  ;; 引数:
  ;;   w : ゲーム全体の状態
  ;;   k : 入力されたキー ("left", "right", " ", … など)

  (let ([board           (world-board w)]           ;; 現在の盤面を表す2次元リスト
        [turn            (world-turn w)]            ;; 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
        [selected-column (world-selected-column w)] ;; 現在選択している列 (0 ~ 6)
        [winner          (world-winner w)]          ;; 勝者 (#f, 'red, 'yellow, 'draw)
        [scene           (world-scene w)]           ;; 現在の画面 ('title, 'playing, 'result)
        )
    (cond [(string=? k "left")
           (world board
                  turn
                  (move-column-left selected-column)
                  winner
                  scene)]
          [(string=? k "right")
           (world board
                  turn
                  (move-column-right selected-column)
                  winner
                  scene)]
          [(string=? k " ")
           (if (column-full? board selected-column)
               w
               (let* ([new-board  (drop-piece board selected-column turn)]
                      [new-winner (check-winner new-board selected-column)])
                 (world new-board
                        (if new-winner
                            turn
                            (switch-turn turn))
                        selected-column
                        new-winner
                        (if new-winner
                            'result
                            scene))))]
          [else w])))

;; リザルト画面でのキー入力処理
(define (control-result w k)
  ;; 引数:
  ;;   w : ゲーム全体の状態
  ;;   k : 入力されたキー ("left", "right", " ", … など)
  
  ;; TODO
  (error "未実装"))

;; キーボード入力を処理
(define (control w k)
  ;; 引数:
  ;;   w : ゲーム全体の状態
  ;;   k : 入力されたキー ("left", "right", " ", … など)

  (let ([scene (world-scene w)]) ;; 現在の画面 ('title, 'playing, 'result)
    (cond [(eq? scene 'title)   (control-title w k)]
          [(eq? scene 'playing) (control-playing w k)]
          [(eq? scene 'result)  (control-result w k)]
          [else                 (error 'input.rkt/control "ゲームの状態`scene`が無効な値です: ~a" scene)])))
