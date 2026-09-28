;;==============================================================
;; Challenge 3 · Rutinas ya resueltas (dadas)
;;   Puedes llamarlas desde tu ejercicio.
;;   ❌ No las modifiques
;;==============================================================
INCLUDE "chcode/common.inc"

SECTION "Given routines", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hl_move_by_increment
;; 📥 HL: address of a cell, A: increment (%1111DULR)
;; 🔙 HL: address of the neighbour cell in that direction
;; ❌ Modifies BC      ✅ Does NOT modify A, DE
hl_move_by_increment::
   INCBIN "chcode/bin/hl_move_by_increment.bin"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; player_move_up (Exercise 7)
;; Decrements the row pointed to by HL, without entering the wall.
;; 📥 HL = address of the row (e.g. &player_row)
;; ❌ Modifies A
player_move_up::
   INCBIN "chcode/bin/player_move_up.bin"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; arena_copy_row_to_tilemap (Exercise 8)
;; Copies ARENA_WIDTH cells.
;; 📥 DE: source in arena (start of a row)
;;    HL: destination in the tilemap
;; 🔙 DE has advanced ARENA_WIDTH positions
;;    HL is UNCHANGED (start of that tilemap row)
;; ❌ Modifies A, B    ✅ Does NOT modify C
arena_copy_row_to_tilemap::
   INCBIN "chcode/bin/arena_copy_row_to_tilemap.bin"
