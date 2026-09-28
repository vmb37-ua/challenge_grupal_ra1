INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 12 · arena_box_fits
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej12" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 12", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Checks whether a rectangle fits inside the
;; playable area (without touching the border).
;;
;; 📥 INPUT:
;;    B: row    (top-left corner)
;;    C: column (top-left corner)
;;    D: width
;;    E: height
;; 🔙 RETURNS (in the flag, not a register):
;;    Z,  if it fits
;;    NZ, if it does not
;; ❌ May modify A. Must NOT modify BC, DE
;;
;; ⚠️ En el proyecto, tu versión se llama team_arena_box_fits
;;    para no chocar con la versión de referencia que usan otros
;;    ejercicios. Ya viene cambiado: no cuenta como FIX.
team_arena_box_fits::
    ;;; <<YOUR CODE>>
    ld a, b
    or a
    jr z, .dont_fit
    ld a, c
    or a
    jr z, .dont_fit
    ld a, d
    add c
    cp ARENA_WIDTH
    jr nc, .dont_fit
    ld a, e
    add b
    cp ARENA_HEIGHT
    jr nc, .dont_fit
    xor a
    ret
    .dont_fit:
    or 1
    ret


;; ==========================================================
;;  ENSAMBLA: SI  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej12 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: OK (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= ....  ☑z  [PREVIO]> Rectángulo esquina (2,3), ancho 4, alto 3.
;; bc= 0203  .n
;; de= 0403  .h
;; hl= ....  .c
;;            flag Z: 1  ← Z = cabe · NZ = no cabe
;;          ← BC, DE no deben cambiar (son entrada)
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: OK  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= ....  ◻z  [PREVIO]> Mismo rectángulo con esquina (2,12):
;; bc= 020C  .n            12+4=16, pisa la columna 15 (muro).
;; de= 0403  .h
;; hl= ....  .c
;;            flag Z: 0  ← Z = cabe · NZ = no cabe
;;          ← BC, DE no deben cambiar (son entrada)
;; ==========================================================
;; === FIXES
;;  Tipo: Cant. => Tramos
;;  *  N:    0 => 0     (1 fix = -1 tramo)
;;  *  E:    0 => 0     (1 fix = -1 tramo)
;;  *  S:    0 => 0     (2 fix = -1 tramo. En grupos de 2 sólo)
;;  *  F:    0 => 0     (2 fix = -1 tramo. En grupos de 2 sólo)
;;      TOTAL:     0 tramos
;;
;; EXPLICACIONES ADICIONALES DE FIXES (si es necesario)
;;  *
