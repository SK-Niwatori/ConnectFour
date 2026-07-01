#lang racket
(require 2htdp/image)
(require 2htdp/universe)

;;;; 盤面の管理

(provide make-empty-board)
(provide column-full?)

;; 空の盤面の作成
(define (make-empty-board)
  '((empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)))

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
