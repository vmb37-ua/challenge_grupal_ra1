INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 02 · arena_cell_address / arena_set_cell
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej02" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 02", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 📥 INPUT:   B: row, C: column
;; 🔙 RETURNS: HL: address of that cell in arena
;; ❌ May modify A, BC. Must NOT modify DE
;; ⚠️ NOTA: aquí se llama `team_arena_cell_address` para no
;;    chocar con la versión de referencia. No cuenta como FIX.
team_arena_cell_address::
    ;;; <<YOUR CODE>>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Uses `arena_cell_address` to calculate address in HL
;; 📥 INPUT:   B: row, C: column, E: value to write
;; 🔙 RETURNS: A: value the cell had BEFORE writing
;; ⚠️ NOTA: Llama a `arena_cell_address` no a `team_arena_cell_address`.
arena_set_cell::
    ;;; <<YOUR CODE>>


;; ==========================================================
;;  ENSAMBLA: ____  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej02 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: ____  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= ....  [PREVIO]> team_arena_cell_address: B=5 (fila), C=7
;; bc= ....            (columna), DE=$1234.
;; de= 1234
;; hl= C057
;;          ← DE no debe cambiar
;;          ← HL dirección de la celda (5,7). BC no forma parte del contrato: no se comprueba
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: ____  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 02..  [PREVIO]> arena_set_cell: arena a SOFT_BLOCK. B=12,
;; bc= ....            C=15 (última celda), E=HARD_BLOCK.
;; de= 03..
;; hl= ....
;;          ← A = $02: valor de ANTES de escribir
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C0C0  02 02 02 02 02 02 02 02|02 02 02 02 02 02 02 03| ← arena, fila 12: celda (12,15) al final
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
