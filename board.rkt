;;;; 盤面の管理

#lang racket

(provide make-empty-board)
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

;; 盤面から列を取り出す
(define (column-at board x)
  ;; 引数:
  ;;   board : 現在の盤面を表す2次元リスト
  ;;   x     : 列の番号 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   盤面のx列目のリスト

  (list-ref board x))

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
