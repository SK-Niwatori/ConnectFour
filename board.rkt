;;;; 盤面の管理

#lang racket

(require "constants.rkt")

(provide make-empty-board)
(provide board-column)
(provide board-cell)
(provide drop-piece)
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

;; 盤面から列を取り出す
(define (board-column board x)
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
(define (board-cell board x y)
  ;; 引数:
  ;;   board : 現在の盤面を表す2次元リスト
  ;;   x     : 列の番号 (0 ~ 6)
  ;;   y     : 行の番号 (0 ~ 5)
  ;;
  ;; 戻り値:
  ;;   盤面の(x, y)座標におけるマスの状態 ('empty, 'red, 'yellow)
  
  (if (valid-position? x y)
      (list-ref (board-column board x) y)
      (error 'board.rkt/board-cell "範囲外の座標が指定されました: (~a, ~a)" x y)))

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
