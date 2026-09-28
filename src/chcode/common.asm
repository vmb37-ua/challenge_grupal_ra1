;;==============================================================
;; Challenge 3 · Código común (datos en RAM)
;;   Los ejercicios los usan por su nombre (arena, player_row...)
;;   ❌ No lo modifiques
;;==============================================================
INCLUDE "chcode/common.inc"

SECTION "Arena", WRAM0[$C000]       ;; fila r de la arena = línea C0r0 en BGB
arena: DS ARENA_SIZE
arena_end:             ;; Address right after the last arena cell
arena_sentinel: DS 1   ;; Sentinel right after the last arena cell
                       ;; * uninitialized (RAM has no starting value)

SECTION "Player Data", WRAM0[$C0E0]
player_row: DS 1
player_col: DS 1

SECTION "Bomb Data", WRAM0[$C0F0]
bomb_row: DS 1
bomb_col: DS 1
