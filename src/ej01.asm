INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 01 · arena_init
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej01" y make.
;; 4. Rellena los ____ en el resumen final
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================

SECTION "Ejercicio 01", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initializes the arena, its sentinel and
;; the player position.
;;
arena_init::
    ;;; <<YOUR CODE>>


;; ==========================================================
;;  ENSAMBLA: ____  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej01 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: ____  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 02..  [PREVIO]> Arena, jugador, bomba y centinela = $AA:
;; bc= ....            basura, como al encender.
;; de= 0101
;; hl= ....
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C000  02 02 02 02 02 02 02 02|02 02 02 02 02 02 02 02| ← arena, fila 0
;; C0E0  01 01 .. .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← player_row, player_col
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: ____  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 02..  [PREVIO]> Lo mismo, con otra basura: $55.
;; bc= ....
;; de= 80..
;; hl= ....
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C0C0  02 02 02 02 02 02 02 02|02 02 02 02 02 02 02 02| ← arena, fila 12 (última)
;; C0D0  80 .. .. .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← arena_sentinel
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
