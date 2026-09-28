INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 07 · player_move_down / player_move_from_joypad
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej07" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 07", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN (already solved): decrements the row
;; pointed to by HL, without entering the wall.
;; 📥 INPUT: HL = address of the row (e.g. &player_row)
;; ❌ Modifies A
;; player_move_up:: ...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Increments the row pointed to by HL,
;; without entering the wall.
;; 📥 INPUT: HL = address of the row (e.g. &player_row)

DEF LIMITE_UNO = ARENA_HEIGHT-2
    DEF DPAD = $FF00
player_move_down::
    ld a, LIMITE_UNO
    cp [hl]
    ret z
    inc [hl]
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reads the D-Pad and moves player_row up/down
;; calling player_move_up/player_move_down.
;;
player_move_from_joypad::
    ;;; <<YOUR CODE>>
ld hl, DPAD
    ld [hl], $10
    ld a, [hl]
    ld a, [hl]
    ld a, [hl]
    ld hl, player_row
    bit 2, a
    jr z, .arriba
    call player_move_down
    ret
    .arriba:
    bit 3, a
    ret z
    call player_move_up
    ret   

;; ==========================================================
;;  ENSAMBLA: OK  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej07 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: OK  (OK / Falla)
;;   Pulsa ↓ una vez por parada. Paradas, en orden:
;; af= 07..     → MEM C0E0 = 07 (player_row)
;; af= 08..     → MEM C0E0 = 08 (player_row)
;; af= 09..     → MEM C0E0 = 09 (player_row)
;; af= 0A..     → MEM C0E0 = 0A (player_row)
;; af= 0B..     → MEM C0E0 = 0B (player_row)
;;   y luego ya NO para más (11 = $0B es la última fila jugable)
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: Falla  (OK / Falla)
;;   Después, pulsa ↑ una vez por parada:
;; af= 0A..     → MEM C0E0 = 0A (player_row)
;; af= 09..     → MEM C0E0 = 09 (player_row)
;; af= 08..     → MEM C0E0 = 08 (player_row)
;; af= 07..     → MEM C0E0 = 07 (player_row)
;; af= 06..     → MEM C0E0 = 06 (player_row)
;; af= 05..     → MEM C0E0 = 05 (player_row)
;; af= 04..     → MEM C0E0 = 04 (player_row)
;; af= 03..     → MEM C0E0 = 03 (player_row)
;; af= 02..     → MEM C0E0 = 02 (player_row)
;; af= 01..     → MEM C0E0 = 01 (player_row)
;;   y luego ya NO para más (1 es la primera fila jugable)
;; ==========================================================
;; === FIXES
;;  Tipo: Cant. => Tramos
;;  *  N:    __ => __     (1 fix = -1 tramo)
;;  *  E:    2 => -2     (1 fix = -1 tramo)
;;  *  S:    __ => __     (2 fix = -1 tramo. En grupos de 2 sólo)
;;  *  F:    __ => __     (2 fix = -1 tramo. En grupos de 2 sólo)
;;      TOTAL:     -2 tramos
;;
;; EXPLICACIONES ADICIONALES DE FIXES (si es necesario)
;;  *
