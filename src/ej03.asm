INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 03 · arena_count_in_row
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej03" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 03", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; arena_cell_address ("Rutinas ya resueltas"):
;; 📥 B: row, C: column   🔙 HL: address of that cell
;; ❌ Modifies A, BC   ✅ Does NOT modify DE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Counts the cells of a row equal to a value.
;;
;; 📥 INPUT:
;;    B: row
;;    E: value to look for
;; 🔙 RETURNS:
;;    A: number of cells of that row equal to E
;;
arena_count_in_row::
    ld c,0 ;;FIX <F><1>: faltaba añadirlo antes de la llamada
    call arena_cell_address
    ld b, ARENA_WIDTH
    ld c,0 ;;FIX <S><1>: ld c,0 en vez de xor c
    loop:
    ld a, [hl+]
    cp e 
    jr nz, no_inc
    inc c 
    no_inc:
    dec b 
    jr nz, loop 
    ld a, c 
    ret ;;FIX <F><2>: faltaba añadir el ret


;; ==========================================================
;;  ENSAMBLA: __SI__  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej03 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: __OK__  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 06..  [PREVIO]> Arena a HARD_BLOCK, salvo la fila 4 (mezcla,
;; bc= ....            6 HARD_BLOCK). B=4, E=HARD_BLOCK.
;; de= ....
;; hl= ....
;;          ← A = $06: nº de celdas de la fila iguales a E
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C040  03 00 03 02 00 03 03 00|03 02 00 00 03 00 00 02| ← arena, fila 4
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: __OK__  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 10..  [PREVIO]> Arena vacía, salvo la última fila (12), a
;; bc= ....            SOFT_BLOCK. B=12, E=SOFT_BLOCK.
;; de= ....
;; hl= ....
;;          ← A = $10: nº de celdas de la fila iguales a E
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C0C0  02 02 02 02 02 02 02 02|02 02 02 02 02 02 02 02| ← arena, fila 12
;; ==========================================================
;; === FIXES
;;  Tipo: Cant. => Tramos
;;  *  N:    __ => __     (1 fix = -1 tramo)
;;  *  E:    __ => __     (1 fix = -1 tramo)
;;  *  S:    _1_ => __     (2 fix = -1 tramo. En grupos de 2 sólo)
;;  *  F:    _2_ => _1_     (2 fix = -1 tramo. En grupos de 2 sólo)
;;      TOTAL:     _1_ tramos
;;
;; EXPLICACIONES ADICIONALES DE FIXES (si es necesario)
;;  *
