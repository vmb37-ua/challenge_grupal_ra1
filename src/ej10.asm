INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 10 · arena_blast_cross
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej10" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 10", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; arena_box_fits ("Rutinas ya resueltas"):
;; 📥 B: row, C: column, D: width, E: height
;; 🔙 Z: fits inside the playable area, NZ: it does not
;; ❌ Modifies A       ✅ Does NOT modify BC, DE
;;
;; arena_cell_address ("Rutinas ya resueltas"):
;; 📥 B: row, C: column   🔙 HL: address of that cell
;; ❌ Modifies A, BC   ✅ Does NOT modify DE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clears the 5 cells of a cross-shaped blast.
;; 📥 INPUT:
;;    B: row    (top-left corner of the 3x3 box)
;;    C: column (top-left corner of the 3x3 box)
;; 🔙 RETURNS (in the flag, not a register):
;;    Z,  if the blast was applied
;;    NZ, if the 3x3 box does not fit (nothing changed)
;;
arena_blast_cross::
    ;;; <<YOUR CODE>>
    push de ;;FIX F1: añadir push, falta
    ld d, 3
    ld e, 3
    call arena_box_fits
    jr nz, .end
    call arena_cell_address ;;FIX S1: nombre mal escrito, sintaxis
    inc hl
    ld [hl], 0
    ld de, ARENA_WIDTH
    add hl, de ;;FIX E1: sumar con de en vez de l, error
    ld [hl], 0
    dec hl
    ld [hl], 0
    inc hl
    inc hl
    ld [hl], 0
    dec hl
    add hl, de
    ld [hl], 0
    xor a
    .end:
    pop de
    ret


;; ==========================================================
;;  ENSAMBLA: SÍ  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej10 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: OK  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 00..  ☑z  [PREVIO]> Arena a SOFT_BLOCK. B=3, C=4: la cruz cabe
;; bc= ....  .n            (esquina del cuadro en (3,4)).
;; de= 0200  .h
;; hl= ....  .c
;;            flag Z: 1  ← Z = cabe, se aplica · NZ = no cabe, nada cambia
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C030  02 02 02 02 02 00 02 02|02 02 02 02 02 02 02 02| ← arena, fila 3
;; C040  02 02 02 02 00 00 00 02|02 02 02 02 02 02 02 02| ← arena, fila 4: (4,4)(4,5)(4,6) a $00
;; C050  02 02 02 02 02 00 02 02|02 02 02 02 02 02 02 02| ← arena, fila 5
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: OK  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 02..  ◻z  [PREVIO]> Arena a SOFT_BLOCK. B=1, C=13: el cuadro
;; bc= ....  .n            llega a la columna 15 (muro).
;; de= ....  .h
;; hl= ....  .c
;;            flag Z: 0  ← Z = cabe, se aplica · NZ = no cabe, nada cambia
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C010  02 02 02 02 02 02 02 02|02 02 02 02 02 02 02 02| ← arena, fila 1
;; C020  02 02 02 02 02 02 02 02|02 02 02 02 02 02 02 02| ← arena, fila 2 (sin cambios)
;; C030  02 02 02 02 02 02 02 02|02 02 02 02 02 02 02 02| ← arena, fila 3
;; ==========================================================
;; === FIXES
;;  Tipo: Cant. => Tramos
;;  *  N:    __ => __     (1 fix = -1 tramo)
;;  *  E:    1 => -1     (1 fix = -1 tramo)
;;  *  S:    1 => 0     (2 fix = -1 tramo. En grupos de 2 sólo)
;;  *  F:    1 => 0     (2 fix = -1 tramo. En grupos de 2 sólo)
;;      TOTAL:     -1 tramos
;;
;; EXPLICACIONES ADICIONALES DE FIXES (si es necesario)
;;  *
