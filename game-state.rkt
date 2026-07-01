#lang racket
(require 2htdp/image)
(require 2htdp/universe)

;;;; 状態の管理

(provide world)
(provide world-board
         world-turn
         world-selected-column
         world-winner
         world-scene)

;; ゲーム全体の状態を作成
(define (world board           ;; 現在の盤面を表す2次元リスト
               turn            ;; 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
               selected-column ;; 現在選択している列 (0 ~ 6)
               winner          ;; 勝者 (#f, 'red, 'yellow, 'draw)
               scene           ;; 現在の画面 ('title, 'playing, 'result)
               )
  (list board turn selected-column winner scene))

;; 状態のセレクタ
(define (world-board w)           (car w))
(define (world-turn w)            (cadr w))
(define (world-selected-column w) (caddr w))
(define (world-winner w)          (cadddr w))
(define (world-scene w)           (car (cddddr w)))

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

;; プレイヤーのターンを交代
(define (switch-turn turn)
  ;; 引数:
  ;;   turn : 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
  ;;
  ;; 戻り値
  ;;   交代した後のプレイヤーのシンボル

  ;; TODO
  (error "未実装"))

;; 現在選択している列を左へ1つ移動
(define (move-column-left column)
  ;; 引数:
  ;;   column : 現在選択している列 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   列を左へ1つ移動させた後の列の番号
  
  ;; TODO
  (error "未実装"))

;; 現在選択している列を右へ1つ移動
(define (move-column-right column)
  ;; 引数:
  ;;   column : 現在選択している列 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   列を右へ1つ移動させた後の列の番号

  ;; TODO
  (error "未実装"))
