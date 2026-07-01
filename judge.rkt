#lang racket
(require 2htdp/image)
(require 2htdp/universe)

;;;; 勝利判定の処理

(provide check-winner)

;; 縦横斜めで4つ並んでいるかの判定
(define (check-winner board column)
  ;; 引数:
  ;;   board  : コマを落とした後の盤面を表す2次元リスト
  ;;   column : コマを落とした列 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   判定結果 (#f, 'red, 'yellow, 'draw)
  
  ;; TODO
  (error "未実装"))
