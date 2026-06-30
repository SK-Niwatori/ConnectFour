#lang racket
(require 2htdp/image)
(require 2htdp/universe)

;;;; 盤面の管理

(provide make-empty-board)

;; 空の盤面の作成
(define (make-empty-board)
  '((empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)
    (empty empty empty empty empty empty)))
