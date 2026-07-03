;;;; 状態の管理

#lang racket

(provide world)
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

;; 状態のセレクタ
(define (world-board w)  (car w))
(define (world-turn w)   (cadr w))
(define (world-column w) (caddr w))
(define (world-winner w) (cadddr w))
(define (world-scene w)  (car (cddddr w)))

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
