;;;; キー入力の処理

#lang racket

(require "game-state.rkt")
(require "judge.rkt")
(require "board.rkt")

(provide control)

;; キーボード入力を処理
(define (control w k)
  ;; 引数:
  ;;   w : ゲーム全体の状態
  ;;   k : 入力されたキー ("left", "right", " ", … など)
  ;;
  ;; 戻り値:
  ;;   キーを入力した後の新しいゲーム全体の状態

  (let ([scene (world-scene w)]) ;; 現在の画面 ('title, 'playing, 'result)
    (cond [(eq? scene 'playing) (control-playing w k)]
          [(eq? scene 'title)   (control-title w k)]
          [(eq? scene 'result)  (control-result w k)]
          [else                 (error 'input.rkt/control "ゲームの状態`scene`が無効な値です: ~a" scene)])))

;; ゲーム中の画面でのキー入力処理
(define (control-playing w k)
  ;; 引数:
  ;;   w : ゲーム全体の状態
  ;;   k : 入力されたキー ("left", "right", " ", … など)
  ;;
  ;; 戻り値:
  ;;   キーを入力した後の新しいゲーム全体の状態

  (let ([board  (world-board w)]  ;; 現在の盤面を表す2次元リスト
        [turn   (world-turn w)]   ;; 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
        [column (world-column w)] ;; 現在選択している列 (0 ~ 6)
        [winner (world-winner w)] ;; 勝者 (#f, 'red, 'yellow, 'draw)
        [scene  (world-scene w)]  ;; 現在の画面 ('title, 'playing, 'result)
        )
    (cond [(string=? k "left")
           (world board
                  turn
                  (move-column-left column)
                  winner
                  scene)]
          [(string=? k "right")
           (world board
                  turn
                  (move-column-right column)
                  winner
                  scene)]
          [(string=? k " ")
           (if (column-full? board column)
               w
               (let* ([new-board  (drop-piece board column turn)]
                      [new-winner (check-winner new-board column)])
                 (world new-board
                        (if new-winner
                            turn
                            (switch-turn turn))
                        column
                        new-winner
                        (if new-winner
                            'result
                            scene))))]
          [else w])))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ここから下を実装
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; タイトル画面でのキー入力処理
(define (control-title w k)
  ;; 引数:
  ;;   w : ゲーム全体の状態
  ;;   k : 入力されたキー ("left", "right", " ", … など)
  ;;
  ;; 戻り値:
  ;;   キーを入力した後の新しいゲーム全体の状態
  
  ;; TODO
  (error "未実装"))

;; リザルト画面でのキー入力処理
(define (control-result w k)
  ;; 引数:
  ;;   w : ゲーム全体の状態
  ;;   k : 入力されたキー ("left", "right", " ", … など)
  ;;
  ;; 戻り値:
  ;;   キーを入力した後の新しいゲーム全体の状態
  
  ;; TODO
  (error "未実装"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; テストコード
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; このコマンドでテストを実行
;; raco test input.rkt

(module+ test
  (require rackunit)

  (define TITLE-WORLD (make-initial-world))

  (define RESULT-WORLD (world '((empty empty empty empty empty empty)
                                (empty empty empty empty yellow yellow)
                                (empty empty empty empty yellow red)
                                (empty empty red yellow red red)
                                (empty empty yellow red red yellow)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))
                              'yellow
                              4
                              'yellow
                              'result))

  (test-case "control-title"
    (check-equal? (control-title TITLE-WORLD "\r")
                  (world (make-empty-board) 'red 3 #f 'playing))
    (check-equal? (control-title TITLE-WORLD "left")
                  TITLE-WORLD)
    (check-equal? (control-title TITLE-WORLD "right")
                  TITLE-WORLD)
    (check-equal? (control-title TITLE-WORLD " ")
                  TITLE-WORLD))

  (test-case "control-result"
    (check-equal? (control-result RESULT-WORLD "escape")
                  (make-initial-world))
    (check-equal? (control-result RESULT-WORLD "\r")
                  (world (make-empty-board) 'red 3 #f 'playing))
    (check-equal? (control-result RESULT-WORLD "left")
                  RESULT-WORLD)
    (check-equal? (control-result RESULT-WORLD "right")
                  RESULT-WORLD)
    (check-equal? (control-result RESULT-WORLD " ")
                  RESULT-WORLD)))
