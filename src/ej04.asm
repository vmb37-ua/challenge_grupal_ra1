INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 04 · player_next_to_bomb
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej04" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 04", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Checks whether the player is on the bomb's
;; cell or on the cell right to its left/right.
;;
;; 🔙 RETURNS (in the flag, not a register):
;;    Z,  if the player is next to the bomb
;;    NZ, if not
;;
player_next_to_bomb::
    ld a,[player_row]
    ld b,a
    ld a,[bomb_row]
    inc a 
    cp b 
    jr nz, no_next
    dec a 
    dec a 
    cp b 
    jr nz, no_next
    ld a, [player_col]
    ld b,a 
    ld a, [bomb_col] ;;FIX <S><1>: era col y no row
    inc a
    cp b 
    jr nz, no_next
    dec a 
    dec a 
    cp b 
    jr nz, no_next
    or 1
    ret 
    no_next: ;;FIX <S><2>: Faltaban los :
    xor a
    ret 



;; ==========================================================
;;  ENSAMBLA: __SI__  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej04 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: __OK__  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= ....  ☑z  [PREVIO]> Bomba en (5,7), jugador en (5,6): misma
;; bc= ....  .n            fila, columna a la izquierda.
;; de= ....  .h
;; hl= ....  .c
;;            flag Z: 1  ← Z = junto a la bomba · NZ = no
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C0E0  05 06 .. .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← player_row, player_col
;; C0F0  05 07 .. .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← bomb_row, bomb_col
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: __Falla__  (OK / Falla)
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= ....  ◻z  [PREVIO]> Bomba en (5,7), jugador en (6,8): columna al
;; bc= ....  .n            lado, pero OTRA fila.
;; de= ....  .h
;; hl= ....  .c
;;            flag Z: 0  ← Z = junto a la bomba · NZ = no
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C0E0  06 08 .. .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← player_row, player_col
;; C0F0  05 07 .. .. .. .. .. ..|.. .. .. .. .. .. .. ..| ← bomb_row, bomb_col
;; ==========================================================
;; === FIXES
;;  Tipo: Cant. => Tramos
;;  *  N:    __ => __     (1 fix = -1 tramo)
;;  *  E:    __ => __     (1 fix = -1 tramo)
;;  *  S:    _2_ => _1_     (2 fix = -1 tramo. En grupos de 2 sólo)
;;  *  F:    __ => __     (2 fix = -1 tramo. En grupos de 2 sólo)
;;      TOTAL:     _1_ tramos
;;
;; EXPLICACIONES ADICIONALES DE FIXES (si es necesario)
;;  *
