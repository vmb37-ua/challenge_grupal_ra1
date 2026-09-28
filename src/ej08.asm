INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 08 · arena_render_to_tilemap
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej08" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 08", ROM0

DEF ARENA_TILEMAP = $9822

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN (already solved): copies ARENA_WIDTH cells.
;; 📥 INPUT: DE: source in arena (start of a row)
;;           HL: destination in the tilemap
;; 🔙 On return: DE has advanced ARENA_WIDTH positions
;;               HL is UNCHANGED (start of that tilemap row)
;; ❌ Modifies A, B    ✅ Does NOT modify C
;; arena_copy_row_to_tilemap:: ...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copies the whole arena to the tilemap,
;; starting at ARENA_TILEMAP.
;;
arena_render_to_tilemap::
    ;;; <<YOUR CODE>>
    ld hl, ARENA_TILEMAP
    ld b, ARENA_HEIGHT
    push hl
    .do:
        call arena_copy_row_to_tilemap
        push de
        ld de, ARENA_WIDTH
        add hl, de
        pop de
        dec b
        jr nz, .do
        pop hl
        ret



;; ==========================================================
;;  ENSAMBLA: SÍ  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej08 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: ____  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 01..  [PREVIO]> Pantalla apagada, tilemap = $FF. Arena vacía
;; bc= ....            salvo (0,0)=$01, (6,0)=$02, (12,15)=$03.
;; de= 02FF
;; hl= ....
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; 9820  FF FF 01 00 00 00 00 00|00 00 00 00 00 00 00 00| ← tilemap: fila 0 de la arena, desde 9822
;; 9830  00 00 FF FF FF FF FF FF|FF FF FF FF FF FF FF FF| ← ... y termina en 9831
;; 98E0  .. .. 02 .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← tilemap: fila 6 de la arena
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: ____  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 03..  [PREVIO]> Mismo resultado que el caso 1 (no hay
;; bc= ....            llamada nueva).
;; de= FF..
;; hl= ....
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; 99B0  00 03 FF .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← tilemap: fin de la fila 12 (99B1)
;; 99C0  FF FF FF .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← tilemap: debajo, sin tocar
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
