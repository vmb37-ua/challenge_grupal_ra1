INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 11 · arena_stamp_pattern
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej11" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 11", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; arena_cell_address ("Rutinas ya resueltas"):
;; 📥 B: row, C: column   🔙 HL: address of that cell
;; ❌ Modifies A, BC   ✅ Does NOT modify DE
;;
;; hl_move_by_increment ("Rutinas ya resueltas"):
;; 📥 HL: address of a cell, A: increment (%1111DULR)
;; 🔙 HL: address of the neighbour cell in that direction
;; ❌ Modifies BC      ✅ Does NOT modify A, DE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Writes HARD_BLOCK into every cell of a pattern.
;; 📥 INPUT:
;;    HL: address of the pattern (starts at Y)
;;
arena_stamp_pattern::
    ;;; <<YOUR CODE>>
    ld b, [hl]
    inc hl
    ld c, [hl]
    ld d, h
    ld e, l
    call arena_cell_address
    inc de
    .loop:
        ld a , [de]
        ld [hl], HARD_BLOCK
        call hl_move_by_increment
        inc de
        or a
        jr nz, .loop
        ret

;; ==========================================================
;;  ENSAMBLA: SI  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej11 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: OK  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 03..  [PREVIO]> Arena vacía. HL → patrón del enunciado: DB
;; bc= ....            3,5,$FE,$F7,$FE,0.
;; de= 0300
;; hl= ....
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C030  00 00 00 00 00 03 03 00|00 00 00 00 00 00 00 00| ← arena, fila 3: (3,5)(3,6) a $03
;; C040  00 00 00 00 00 00 03 03|00 00 00 00 00 00 00 00| ← arena, fila 4: (4,6)(4,7) a $03
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: OK  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 03..  [PREVIO]> Arena vacía. HL → patrón de 1 celda: DB
;; bc= ....            7,9,0.
;; de= 00..
;; hl= ....
;;          ← D = $00: (9,7): NO debe cambiar (sería cambiar fila↔columna)
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C070  00 00 00 00 00 00 00 00|00 03 00 00 00 00 00 00| ← arena, fila 7: (7,9) a $03
;; C090  00 00 00 00 00 00 00 00|00 00 00 00 00 00 00 00| ← arena, fila 9 (sin tocar)
;; ==========================================================
;; === FIXES
;;  Tipo: Cant. => Tramos
;;  *  N:    0 => 0     (1 fix = -1 tramo)
;;  *  E:    0 => 0     (1 fix = -1 tramo)
;;  *  S:    0 => 0     (2 fix = -1 tramo. En grupos de 2 sólo)
;;  *  F:    0 => 0     (2 fix = -1 tramo. En grupos de 2 sólo)
;;      TOTAL:    0 tramos
;;
;; EXPLICACIONES ADICIONALES DE FIXES (si es necesario)
;;  *
