;;;; 画面の描画

#lang racket

(require 2htdp/image)
(require "game-state.rkt")
(require "constants.rkt")

(provide draw-scene)

;; 画面の描画
(define (draw-scene w)
  ;; 引数:
  ;;   w : ゲーム全体の状態
  
  (let ([board  (world-board  w)] ;; 現在の盤面を表す2次元リスト
        [turn   (world-turn   w)] ;; 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
        [column (world-column w)] ;; 現在選択している列 (0 ~ 6)
        [winner (world-winner w)] ;; 勝者 (#f, 'red, 'yellow, 'draw)
        [scene  (world-scene  w)] ;; 現在の画面 ('title, 'playing, 'result)
        )
    (cond [(eq? scene 'playing) (draw-playing board
                                              turn
                                              column)]
          [(eq? scene 'title)   (draw-title)]
          [(eq? scene 'result)  (draw-result board winner)]
          [else                 (error 'draw.rkt/draw-scene "ゲームの状態`scene`が無効な値です: ~a" scene)])))

;; 盤面を描画
(define (draw-board board)
  ;; 引数:
  ;;   board : 現在の盤面を表す2次元リスト
  ;;
  ;; 戻り値:
  ;;   盤面を描画した画像
  
  (define (cell-x column)
    (+ (* column CELL-SIZE) (/ CELL-SIZE 2)))
  
  (define (cell-y row)
    (+ (* row CELL-SIZE) (/ CELL-SIZE 2)))
  
  (define (draw-cols column cols-lst back)
    (define (draw-rows row rows-lst back)
      (if (null? rows-lst)
          back
          (draw-rows (+ row 1)
                     (cdr rows-lst)
                     (let ([cell (car rows-lst)])
                       (cond [(eq? cell 'empty)
                              (place-image CELL-EMPTY
                                           (cell-x column) (cell-y row)
                                           back)]
                             [(eq? cell 'red)
                              (place-image CELL-RED
                                           (cell-x column) (cell-y row)
                                           back)]
                             [(eq? cell 'yellow)
                              (place-image CELL-YELLOW
                                           (cell-x column) (cell-y row)
                                           back)]
                             [else (error 'draw.rkt/draw-board "盤面のマスが無効な値です: ~a" cell)])))))
    
    (if (null? cols-lst)
        back
        (draw-cols (+ column 1)
                   (cdr cols-lst)
                   (draw-rows 0 (car cols-lst) back))))
  
  (draw-cols 0 board BOARD-BACK))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ここから下を実装
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ゲーム画面を描画
(define (draw-playing board turn column)
  ;; 引数:
  ;;   board  : 現在の盤面を表す2次元リスト
  ;;   turn   : 現在どちらのプレイヤーの番かを表す ('red, 'yellow)
  ;;   column : 現在選択している列 (0 ~ 6)
  ;;
  ;; 戻り値:
  ;;   ゲーム画面を描画した画像
  ;;
  ;; 説明:
  ;;   SCENE-BACKを背景として表示してください。これが座標の基準になります。
  ;;   (SCENE-SIZE ÷ 2, (CELL-SIZE × ROW-SIZE ÷ 2) + 150)の位置にdraw-boardで作成した盤面を配置してください。
  ;;   また、選択している列の上に、turnに応じてPIECE-REDかPIECE-YELLOW、その下にARROWを表示してください。
  ;;   上部に表示するコマの座標は、((column × CELL-SIZE) + (CELL-SIZE ÷ 2) + 50, PIECE-SIZE ÷ 2)に表示してください。
  ;;   ARROWは、((column × CELL-SIZE) + (CELL-SIZE ÷ 2) + 50, PIECE-SIZE + 40)の座標においてください。
  ;;   place-imageを使うとよいです。
  
  ;; TODO
  (define board-image
    (place-image (draw-board board)
                 (/ SCENE-SIZE 2)
                 (+ (/ (* CELL-SIZE ROW-SIZE) 2) 150)
                 SCENE-BACK))
  
  (define piece
    (cond [(eq? turn 'red) PIECE-RED]
          [(eq? turn 'yellow) PIECE-YELLOW]
          [else PIECE-EMPTY]))
  
  (define piece-x
    (+ (* column CELL-SIZE)
       (/ CELL-SIZE 2)
       50))
  
  (define piece-y
    (/ PIECE-SIZE 2))
  
  (define arrow-y
    (+ PIECE-SIZE 40))
  
  (place-image
    ARROW
    piece-x
    arrow-y
    (place-image
      piece
      piece-x
      piece-y
      board-image)))

;; タイトル画面を描画
(define (draw-title)
  ;; 戻り値:
  ;;   タイトル画面を描画した画像
  
  ;; TODO
  (place-image
    (text "Press Enter to Start" 30 "white")
    (/ SCENE-SIZE 2)
    500 (place-image
          (text "← →: Move" 30 "white")
          (/ SCENE-SIZE 2)
          600
          (place-image
            (text "SPACE:Drop" 30 "white")
            (/ SCENE-SIZE 2)
            700
            (place-image
              (text "CONNECT" 60 "red")
              300
              300
              (place-image
                (text "FOUR" 60 "yellow")
                535
                300
                
                (place-image
                  (beside PIECE-RED
                          PIECE-YELLOW
                          PIECE-RED
                          PIECE-YELLOW
                          PIECE-RED
                          PIECE-YELLOW)
                  390
                  375
                  (place-image
                    (beside PIECE-RED
                            PIECE-YELLOW
                            PIECE-RED
                            PIECE-YELLOW
                            PIECE-RED
                            PIECE-YELLOW)
                    390
                    225 
                    (place-image
                        (scale 0.4 (bitmap "assets/conefo.png"))
                          140
                          600
                          SCENE-BACK)))))))))

;; リザルト画面を描画
(define (draw-result board winner)
  ;; 引数:
  ;;   board  : 現在の盤面を表す2次元リスト
  ;;   winner : 勝者 ('red, 'yellow, 'draw)
  ;;
  ;; 戻り値:
  ;;   リザルト画面を描画した画像
  
  ;; TODO
  (define board-image
    (place-image
      (draw-board board)
      (/ SCENE-SIZE 2)
      (+ (/ (* CELL-SIZE ROW-SIZE) 2) 150)
      SCENE-BACK))
  
  (define result-text
    (cond [(eq? winner 'red)
           (text "RED WIN!!" 50 "red")]
          
          [(eq? winner 'yellow)
           (text "YELLOW WIN!!" 50 "yellow")]
          
          [(eq? winner 'draw)
           (text "DRAW!!" 50 "orange")]
          [else
           (text "GAME OVER" 50 "white")
           ]))
  (place-image
    (text "RESTART:Enter" 30 "white")
    630
    110
    (place-image
      (text "TITLE:Escape" 30 "white")
      150
      110
      (place-image
        result-text
        (/ SCENE-SIZE 2)
        60
        board-image))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; テスト画面表示
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; このコマンドでテスト画面を表示
;; raco test draw.rkt

(module+ test
  (require rackunit)
  (require 2htdp/universe)

  (define BOARD-PLAYING '((empty empty empty empty empty empty)
                          (empty empty empty empty empty red)
                          (empty empty empty yellow red red)
                          (empty empty yellow red yellow yellow)
                          (empty empty empty red yellow yellow)
                          (empty empty empty yellow yellow red)
                          (empty empty empty red red yellow)))

  (define BOARD-RESULT '((empty empty empty empty empty empty)
                         (empty empty empty empty empty red)
                         (empty empty empty yellow red red)
                         (empty empty yellow red yellow yellow)
                         (empty empty red red yellow yellow)
                         (empty empty empty yellow yellow red)
                         (empty empty empty red red yellow)))

  (big-bang (world BOARD-PLAYING
                   'red
                   4
                   #f
                   'playing)
            (to-draw draw-scene))

  (big-bang (make-initial-world)
            (to-draw draw-scene))

  (big-bang (world BOARD-RESULT
                   'red
                   4
                   'red
                   'result)
            (to-draw draw-scene)))
