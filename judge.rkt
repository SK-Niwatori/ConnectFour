;;;; 勝利判定の処理

#lang racket

(require "board.rkt")

(provide check-winner)

;; 勝者の判定
(define (check-winner board column)
  ;; 引数:
  ;;   board  : コマを落とした後の盤面を表す2次元リスト
  ;;   column : コマを落とした列 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   判定結果 (#f, 'red, 'yellow, 'draw)
  
  (let* ([row (top-piece-row board column)]
         [piece (get-cell board column row)])
    (cond [(connect-four? board column row piece) piece]
          [(board-full? board) 'draw]
          [else #f])))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ここから下を実装
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 指定した方向に同じコマが何個続いているか数える
(define (count-direction board x y dx dy piece)
  ;; 引数:
  ;;   board : 盤面を表す2次元リスト
  ;;   x     : 基準となるコマのx座標 (0 ~ 6)
  ;;   y     : 基準となるコマのy座標 (0 ~ 5)
  ;;   dx    : 基準座標からx方向に動く量 (-1, 0, 1)
  ;;   dy    : 基準座標からy方向に動く量 (-1, 0, 1)
  ;;   piece : カウントするコマの種類 ('red, 'yellow)
  ;;
  ;; 戻り値:
  ;;   同じコマが連続して続いている個数
  ;;
  ;; 説明:
  ;;   指定された方向に、pieceと同じコマが何個連続しているか数えます。
  ;;   基準となるマス(x, y)自身は数えません。
  ;;   get-cellを使うとよいです。
  
  ;; TODO
  (error "未実装"))

;; 縦横斜めで4つ並んでいるかの判定
(define (connect-four? board x y piece)
  ;; 引数:
  ;;   board : 盤面を表す2次元リスト
  ;;   x     : 基準となるコマの列番号 (0 ~ 6)
  ;;   y     : 基準となるコマの行番号 (0 ~ 5)
  ;;   piece : 判定するコマの種類 ('red, 'yellow)
  ;;
  ;; 戻り値:
  ;;   真偽値 (#t, #f)
  ;;
  ;; 説明:
  ;;   count-directionを使うとよいです。
  
  ;; TODO
  (error "未実装"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; テストコード
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; このコマンドでテストを実行
;; raco test judge.rkt

(module+ test
  (require rackunit)
  
  (define BOARD-A '((empty empty empty empty empty empty)
                    (empty empty empty empty yellow yellow)
                    (empty empty empty empty yellow red)
                    (empty empty red yellow red red)
                    (empty empty yellow red red yellow)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)))

  (define BOARD-B '((empty empty empty empty empty empty)
                    (empty empty empty empty empty red)
                    (empty empty empty yellow red red)
                    (empty empty yellow red yellow yellow)
                    (empty empty red red yellow yellow)
                    (empty empty empty yellow yellow red)
                    (empty empty empty red red yellow)))

  (define BOARD-C '((red red yellow yellow red red)
                    (yellow yellow yellow red yellow yellow)
                    (red yellow red yellow red red)
                    (red yellow yellow red yellow red)
                    (yellow red yellow red yellow red)
                    (red red yellow red red yellow)
                    (red yellow red yellow yellow yellow)))

  (test-case "count-direction"
    ;; 右
    (check-equal? (count-direction BOARD-A
                                   1 4
                                   1 0
                                   'yellow)
                  1)
    (check-equal? (count-direction BOARD-A
                                   4 2
                                   1 0
                                   'yellow)
                  0)
    (check-equal? (count-direction BOARD-A
                                   3 2
                                   1 0
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-B
                                   1 5
                                   1 0
                                   'red)
                  1)
    (check-equal? (count-direction BOARD-B
                                   6 3
                                   1 0
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-C
                                   5 0
                                   1 0
                                   'red)
                  1)
    (check-equal? (count-direction BOARD-C
                                   4 0
                                   1 0
                                   'yellow)
                  0)
    
    ;; 左
    (check-equal? (count-direction BOARD-A
                                   2 4
                                   -1 0
                                   'yellow)
                  1)
    (check-equal? (count-direction BOARD-A
                                   3 2
                                   -1 0
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-A
                                   4 2
                                   -1 0
                                   'yellow)
                  0)
    (check-equal? (count-direction BOARD-B
                                   5 3
                                   -1 0
                                   'yellow)
                  0)
    (check-equal? (count-direction BOARD-B
                                   1 5
                                   -1 0
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-C
                                   0 0
                                   -1 0
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-C
                                   6 0
                                   -1 0
                                   'red)
                  1)

    ;; 上（省略）

    ;; 下
    (check-equal? (count-direction BOARD-A
                                   1 4
                                   0 1
                                   'yellow)
                  1)
    (check-equal? (count-direction BOARD-A
                                   3 2
                                   0 1
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-B
                                   1 5
                                   0 1
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-B
                                   5 3
                                   0 1
                                   'yellow)
                  1)
    (check-equal? (count-direction BOARD-C
                                   1 0
                                   0 1
                                   'yellow)
                  2)

    ;; 右上
    (check-equal? (count-direction BOARD-A
                                   2 4
                                   1 -1
                                   'yellow)
                  2)
    (check-equal? (count-direction BOARD-A
                                   3 2
                                   1 -1
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-B
                                   1 5
                                   1 -1
                                   'red)
                  3)
    (check-equal? (count-direction BOARD-B
                                   6 3
                                   1 -1
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-C
                                   0 0
                                   1 -1
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-C
                                   6 0
                                   1 -1
                                   'red)
                  0)

    ;; 左下
    (check-equal? (count-direction BOARD-A
                                   4 2
                                   -1 1
                                   'yellow)
                  3)
    (check-equal? (count-direction BOARD-A
                                   3 2
                                   -1 1
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-B
                                   4 2
                                   -1 1
                                   'red)
                  3)
    (check-equal? (count-direction BOARD-B
                                   1 5
                                   -1 1
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-C
                                   0 0
                                   -1 1
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-C
                                   4 0
                                   -1 1
                                   'yellow)
                  1)

    ;; 左上
    (check-equal? (count-direction BOARD-A
                                   4 2
                                   -1 -1
                                   'yellow)
                  0)
    (check-equal? (count-direction BOARD-B
                                   4 5
                                   -1 -1
                                   'yellow)
                  2)
    (check-equal? (count-direction BOARD-C
                                   0 0
                                   -1 -1
                                   'red)
                  0)

    ;; 右下
    (check-equal? (count-direction BOARD-A
                                   3 2
                                   1 1
                                   'red)
                  1)
    (check-equal? (count-direction BOARD-A
                                   4 2
                                   1 1
                                   'yellow)
                  0)
    (check-equal? (count-direction BOARD-B
                                   2 3
                                   1 1
                                   'yellow)
                  2)
    (check-equal? (count-direction BOARD-B
                                   1 5
                                   1 1
                                   'red)
                  0)
    (check-equal? (count-direction BOARD-C
                                   1 0
                                   1 1
                                   'yellow)
                  2)
    (check-equal? (count-direction BOARD-C
                                   6 0
                                   1 1
                                   'red)
                  0))
  
  (test-case "connect-four?"
    (check-true (connect-four? BOARD-A
                               4 2
                               'yellow))
    (check-true (connect-four? BOARD-A
                               2 4
                               'yellow))
    (check-true (connect-four? BOARD-B
                               4 2
                               'red))
    (check-true (connect-four? BOARD-B
                               1 5
                               'red))
    (check-false (connect-four? BOARD-A
                                3 2
                                'red))
    (check-false (connect-four? BOARD-B
                                5 3
                                'yellow))
    (check-false (connect-four? BOARD-C
                                0 0
                                'red))
    (check-false (connect-four? BOARD-C
                                6 0
                                'red))))
