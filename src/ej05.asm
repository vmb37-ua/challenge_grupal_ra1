INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 05 · arena_copy_row_up
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej05" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 05", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; arena_cell_address ("Rutinas ya resueltas"):
;; 📥 B: row, C: column   🔙 HL: address of that cell
;; ❌ Modifies A, BC   ✅ Does NOT modify DE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copies a row into the row immediately
;; above it (row -> row-1).
;;
;; 📥 INPUT:
;;    B: source row (1 .. ARENA_HEIGHT-1, never 0)
;;
arena_copy_row_up::
    ;;; <<YOUR CODE>>


;; ==========================================================
;;  ENSAMBLA: ____  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej05 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: ____  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 01..  [PREVIO]> Arena vacía. Fila 6 con $01, $02 ... $10
;; bc= ....            (una rampa).
;; de= 1001
;; hl= ....
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C050  01 02 03 04 05 06 07 08|09 0A 0B 0C 0D 0E 0F 10| ← arena, fila 5 (la copia)
;; C060  01 02 03 04 05 06 07 08|09 0A 0B 0C 0D 0E 0F 10| ← arena, fila 6 (origen, sin cambios)
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: ____  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 31..  [PREVIO]> Arena vacía. Última fila (12) con $31 ...
;; bc= ....            $40.
;; de= 4000
;; hl= ....
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C0A0  00 00 00 00 00 00 00 00|00 00 00 00 00 00 00 00| ← arena, fila 10 (no se toca)
;; C0B0  31 32 33 34 35 36 37 38|39 3A 3B 3C 3D 3E 3F 40| ← arena, fila 11 (la copia)
;; C0C0  31 32 33 34 35 36 37 38|39 3A 3B 3C 3D 3E 3F 40| ← arena, fila 12 (origen)
;; ==========================================================
;; === FIXES
;;  Tipo: Cant. => Tramos
;;  *  N:    __ => __     (1 fix = -1 tramo)
;;  *  E:    __ => __     (1 fix = -1 tramo)
;;  *  S:    __ => __     (2 fix = -1 tramo. En grupos de 2 sólo)
;;  *  F:    __ => __     (2 fix = -1 tramo. En grupos de 2 sólo)
;;      TOTAL:     __ tramos
;;
;; EXPLICACIONES ADICIONALES DE FIXES (si es necesario)
;;  *
