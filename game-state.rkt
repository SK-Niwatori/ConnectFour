;;;; 状態の管理

#lang racket

(require (only-in racket/gui play-sound))
(require "board.rkt")
(require "constants.rkt")

(provide world)
(provide make-initial-world)
(provide world-board
         world-turn
         world-column
         world-winner
         world-scene)
(provide switch-turn)
(provide move-column-left
         move-column-right)

;; ゲーム全体の状態を作成
(define (world board  ;; 現在の盤面を表す2次元リスト
               turn   ;; 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
               column ;; 現在選択している列 (0 ~ 6)
               winner ;; 勝者 (#f, 'red, 'yellow, 'draw)
               scene  ;; 現在の画面 ('title, 'playing, 'result)
               )
  (list board turn column winner scene))

;; ゲームの初期状態を作成
(define (make-initial-world)
  (world (make-empty-board) 'red 3 #f 'title))

;; 状態のセレクタ
(define (world-board  w) (car w))
(define (world-turn   w) (cadr w))
(define (world-column w) (caddr w))
(define (world-winner w) (cadddr w))
(define (world-scene  w) (car (cddddr w)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ここから下を実装
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; プレイヤーのターンを交代
(define (switch-turn turn)
  ;; 引数:
  ;;   turn : 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
  ;;
  ;; 戻り値
  ;;   交代した後のプレイヤーのシンボル
  ;;
  ;; 説明:
  ;;   この手続きでは、プレイヤーのターンを交代させます。
  ;;   例えば、turnが'redだったら'yellowを返して、'yellowだったら'redを返すみたいな感じです。
  ;;   turnは'red, 'yellow以外の値はとらないとして良いです。もし例外処理をするとしたら何かしらのエラーを返してもよいです。

  ;; TODO
  (if (equal? turn 'red)
      'yellow
      'red
      ))

;; 現在選択している列を左へ1つ移動
(define (move-column-left column)
  ;; 引数:
  ;;   column : 現在選択している列 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   列を左へ1つ移動させた後の列の番号
  ;;
  ;; 説明:
  ;;   この手続きでは、columnの列番号を左へ1つ移動した列番号を返します。
  ;;   つまり、column - 1 をするみたいなイメージです。
  ;;   しかし、columnが0だった場合は、この手続きは0を返さなければなりません。

  ;; TODO
  (if (= column 0)
      0
      (begin (play-sound "assets/move.wav" #t)
             (- column 1)))
  )

;; 現在選択している列を右へ1つ移動
(define (move-column-right column)
  ;; 引数:
  ;;   column : 現在選択している列 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   列を右へ1つ移動させた後の列の番号
  ;;
  ;; 説明:
  ;;   `move-column-left`とほぼ同じです。
  ;;   column + 1 をするみたいなイメージです。
  ;;   しかし、columnが COLUMN-SIZE - 1 だった場合は、この手続きは COLUMN-SIZE - 1 を返さなければなりません。

  ;; TODO
  (if (= column 6)
      6
      (begin (play-sound "assets/move.wav" #t)
             (+ column 1)))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; テストコード
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; このコマンドでテストを実行
;; raco test game-state.rkt

(module+ test
  (require rackunit)

  (test-case "switch-turn"
    (check-equal? (switch-turn 'red) 'yellow)
    (check-equal? (switch-turn 'yellow) 'red))

  (test-case "move-column-left"
    (check-equal? (move-column-left 5) 4)
    (check-equal? (move-column-left 1) 0)
    (check-equal? (move-column-left 6) 5)
    (check-equal? (move-column-left 0) 0))

  (test-case "move-column-right"
    (check-equal? (move-column-right 1) 2)
    (check-equal? (move-column-right 5) 6)
    (check-equal? (move-column-right 0) 1)
    (check-equal? (move-column-right 6) 6)))
