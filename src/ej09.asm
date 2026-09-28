INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 09 · arena_count_blocks
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej09" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 09", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Counts all filled cells of the arena,
;; stopping at the sentinel.
;;
;; 🔙 RETURNS:
;;    A: number of filled cells (0..ARENA_SIZE)
;;
arena_count_blocks::
    ;;; <<YOUR CODE>>


;; ==========================================================
;;  ENSAMBLA: ____  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej09 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: ____  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= D0..  [PREVIO]> Arena llena de SOFT_BLOCK, con el centinela
;; bc= ....            puesto.
;; de= ....
;; hl= ....
;;          ← A = $D0: nº de celdas con bloque (el centinela no cuenta)
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C000  02 02 02 02 02 02 02 02|02 02 02 02 02 02 02 02| ← arena, fila 0 (todas SOFT_BLOCK)
;; C0D0  80 .. .. .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← arena_sentinel
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: ____  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= 02..  [PREVIO]> Arena vacía. Bloques en [5] y [30].
;; bc= ....            Centinela FALSO en [50]. Más bloques en
;; de= ....            [100] y [200], DESPUÉS del centinela falso.
;; hl= ....
;;          ← A = $02: nº de celdas con bloque ANTES del centinela (2, no 4): hay que pararse ahí
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C000  .. .. .. .. .. 03 .. ..|.. .. .. .. .. .. .. ..| ← arena[5]: SÍ cuenta
;; C010  .. .. .. .. .. .. .. ..|.. .. .. .. .. .. 03 ..| ← arena[30]: SÍ cuenta
;; C030  .. .. 80 .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← arena[50]: centinela FALSO, aquí se para
;; C060  .. .. .. .. 03 .. .. ..|.. .. .. .. .. .. .. ..| ← arena[100]: NO debe contarse
;; C0C0  .. .. .. .. .. .. .. ..|03 .. .. .. .. .. .. ..| ← arena[200]: NO debe contarse
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
