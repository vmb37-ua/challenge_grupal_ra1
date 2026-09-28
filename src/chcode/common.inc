;;==============================================================
;; Challenge 3 · Código común (constantes)
;;   Lo incluyen todos los ficheros: INCLUDE "common.inc"
;;   ❌ No lo modifiques
;;==============================================================
IF !DEF(COMMON_INC)
DEF COMMON_INC = 1

DEF ARENA_WIDTH  = 16
DEF ARENA_HEIGHT = 13
DEF ARENA_SIZE   = ARENA_WIDTH * ARENA_HEIGHT   ;; = 208

;; arena: 1 byte per cell, stored by rows (like the tilemap)
;;  -  0 → empty
;;  - >0 → block (tile ID)
;; Cell index (row, column) = row * ARENA_WIDTH + column
;;
;; The border (row 0, row ARENA_HEIGHT-1, column 0, column ARENA_WIDTH-1)
;; is wall. Playable area: rows    1 .. ARENA_HEIGHT-2
;;                         columns 1 .. ARENA_WIDTH-2
DEF EMPTY          = $00
DEF SOFT_BLOCK     = $02   ;; destructible block
DEF HARD_BLOCK     = $03   ;; indestructible block
DEF ARENA_SENTINEL = $80   ;; Reserved value. Marks end of array.
                           ;; Never use $80 as a real tile

;; Increments: same format as in Training
;;   %1111DULR, negative logic (bit=0 → move in that direction)
DEF I_RIGHT_BIT = 0
DEF I_LEFT_BIT  = 1
DEF I_UP_BIT    = 2
DEF I_DOWN_BIT  = 3

DEF TILEMAP_WIDTH = 32

ENDC
