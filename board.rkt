;;;; 盤面の管理

#lang racket

(require "constants.rkt")

(provide make-empty-board)
(provide valid-row?
         valid-column?
         valid-position?)
(provide piece?)
(provide get-column
         get-cell)
(provide top-piece-row)
(provide replace-column)
(provide drop-column
         drop-piece)
(provide column-full?)
(provide board-full?)

;; 空の盤面の作成
(define (make-empty-board)
  '((empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)))

;; 指定した行が範囲内か判定
(define (valid-row? row)
  ;; 引数:
  ;;   row : 行の番号
  ;;
  ;; 戻り値:
  ;;   真偽値 (#t, #f)

  (and (<= 0 row) (< row ROW-SIZE)))

;; 指定した列が範囲内か判定
(define (valid-column? column)
  ;; 引数:
  ;;   column : 列の番号
  ;;
  ;; 戻り値:
  ;;   真偽値 (#t, #f)

  (and (<= 0 column) (< column COLUMN-SIZE)))

;; 指定した座標が範囲内か判定
(define (valid-position? x y)
  ;; 引数:
  ;;   x : 列の番号
  ;;   y : 行の番号
  ;;
  ;; 戻り値:
  ;;   真偽値 (#t, #f)

  (and (valid-column? x) (valid-row? y)))

;; マスの値がコマであるかどうか判定
(define (piece? cell)
  ;; 引数:
  ;;   cell : マスの値 ('empty, 'red, 'yellow)
  ;;
  ;; 戻り値:
  ;;   真偽値 (#t, #f)

  (or (eq? cell 'red)
      (eq? cell 'yellow)))

;; 盤面から列を取り出す
(define (get-column board x)
  ;; 引数:
  ;;   board : 現在の盤面を表す2次元リスト
  ;;   x     : 列の番号 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   盤面のx列目のリスト

  (if (valid-column? x)
      (list-ref board x)
      (error 'board.rkt/board-column "範囲外の列が指定されました: ~a" x)))

;; 盤面から特定のマスの状態を取得
(define (get-cell board x y)
  ;; 引数:
  ;;   board : 現在の盤面を表す2次元リスト
  ;;   x     : 列の番号 (0 ~ 6)
  ;;   y     : 行の番号 (0 ~ 5)
  ;;
  ;; 戻り値:
  ;;   盤面の(x, y)座標におけるマスの状態 ('empty, 'red, 'yellow)
  ;;   範囲外が指定された場合は#f
  
  (if (valid-position? x y)
      (list-ref (get-column board x) y)
      #f))

;; 指定された列で一番上にあるコマの行番号を返す
(define (top-piece-row board column)
  ;; 引数:
  ;;   board  : 現在の盤面を表す2次元リスト
  ;;   column : 列の番号 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   column列目の一番上にあるコマの行番号 (0 ~ 5)
  ;;   コマが無い場合は#f
  
  (define (iter lst row)
    (cond [(null? lst) #f]
          [(piece? (car lst)) row]
          [else (iter (cdr lst) (+ row 1))]))
  
  (iter (get-column board column) 0))

;; 特定の列を置き換えた新しい盤面を返す
(define (replace-column board column col-lst)
  ;; 引数:
  ;;   board   : 置き換える前の盤面を表す2次元リスト
  ;;   column  : 置き換える列の番号 (0 ~ 6)
  ;;   col-lst : 列のリスト
  ;;
  ;; 戻り値:
  ;;   盤面のcolumn列目だけをcol-lstに置き換えた新しい盤面を表す2次元リスト
  
  (define (iter lst idx)
    (cond [(= idx column) (cons col-lst (cdr lst))]
          [else (cons (car lst) (iter (cdr lst) (+ idx 1)))]))

  (if (valid-column? column)
      (iter board 0)
      (error 'board.rkt/replace-column "範囲外の列が指定されました: ~a" column)))

;; 盤面の特定の列のリストを受け取り、コマを落とした後の列のリストを返す
(define (drop-column col-lst piece)
  ;; 引数:
  ;;   col-lst : コマを落とす前の列のリスト
  ;;   piece   : 落とすコマの種類 ('red, 'yellow)
  ;;
  ;; 戻り値:
  ;;   コマを落とした後の列のリスト
  
  (let ([next-lst (cdr col-lst)])
    (if (or (null? next-lst) (piece? (car next-lst)))
        (cons piece next-lst)
        (cons (car col-lst) (drop-column next-lst piece)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ここから下を実装
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; コマを落とす
(define (drop-piece board column piece)
  ;; 引数:
  ;;   board  : 現在の盤面を表す2次元リスト
  ;;   column : コマを落とす列 (0 ~ 6)
  ;;   piece  : 落とすコマの種類 ('red, 'yellow)
  ;;
  ;; 戻り値:
  ;;   コマを落とした後の盤面を表す2次元リスト

  ;; TODO
  (error "未実装"))

;; 指定された列が埋まっているか確認
(define (column-full? board column)
  ;; 引数:
  ;;   board  : 現在の盤面を表す2次元リスト
  ;;   column : 現在選択している列 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   真偽値 (#t, #f)

  ;; TODO
  (error "未実装"))

;; 盤面が全て埋まっているか確認
(define (board-full? board)
  ;; 引数:
  ;;   board : 現在の盤面を表す2次元リスト
  ;;
  ;; 戻り値:
  ;;   真偽値 (#t, #f)
  
  ;; TODO
  (error "未実装"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; テストコード
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(module+ test
  (require rackunit)
  
  (test-case "drop-piece"
    (check-equal? (drop-piece '((empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty red)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))
                              3
                              'yellow)
                  '((empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty yellow red)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)))

    (check-equal? (drop-piece '((empty empty empty empty empty empty)
                                (empty empty empty empty empty yellow)
                                (empty empty empty empty empty yellow)
                                (empty empty empty empty yellow red)
                                (empty empty empty empty red red)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))
                              4
                              'red)
                  '((empty empty empty empty empty empty)
                    (empty empty empty empty empty yellow)
                    (empty empty empty empty empty yellow)
                    (empty empty empty empty yellow red)
                    (empty empty empty red red red)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)))

    (check-equal? (drop-piece '((empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))
                              0
                              'red)
                  '((empty empty empty empty empty red)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)))

    (check-equal? (drop-piece '((empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))
                              2
                              'red)
                  '((empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty red)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)))

    (check-equal? (drop-piece '((empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))
                              6
                              'red)
                  '((empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty red)))

    (check-equal? (drop-piece '((empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty red yellow red yellow red)
                                (empty empty empty empty empty empty))
                              5
                              'yellow)
                  '((empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (empty empty empty empty empty empty)
                    (yellow red yellow red yellow red)
                    (empty empty empty empty empty empty))))
  
  (test-case "column-full?"
    (check-false (column-full? '((empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty))
                                0))

    (check-false (column-full? '((empty empty empty empty empty red)
                                 (empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty)
                                 (empty empty empty empty empty empty))
                                0))

    (check-true (column-full? '((yellow red yellow red yellow red)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))
                              0))

    (check-true (column-full? '((empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (yellow red yellow red yellow red))
                              6))

    (check-true (column-full? '((empty empty empty empty empty empty)
                                (empty empty empty empty empty yellow)
                                (empty empty empty empty empty red)
                                (yellow yellow red red yellow red)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))
                              3)))
  
  (test-case "board-full?"
    (check-false (board-full? '((empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))))

    (check-false (board-full? '((empty empty empty empty empty empty)
                                (empty empty empty empty empty yellow)
                                (empty empty empty empty red yellow)
                                (empty empty empty red yellow red)
                                (empty empty empty empty empty red)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))))

    (check-false (board-full? '((yellow red yellow red yellow red)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty)
                                (empty empty empty empty empty empty))))

    (check-true (board-full? '((red red yellow yellow red red)
                               (yellow yellow yellow red yellow yellow)
                               (red yellow red yellow red red)
                               (red yellow yellow red yellow red)
                               (yellow red yellow red yellow red)
                               (red red yellow red red yellow)
                               (red yellow red yellow yellow yellow))))))
