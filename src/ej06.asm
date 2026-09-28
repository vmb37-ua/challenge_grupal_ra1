INCLUDE "chcode/common.inc"

;;==============================================================
;; Challenge 3 · Ejercicio 06 · bomb_ray_down_blocked
;;
;; 1. Copia tu código del papel TAL CUAL, sin corregir nada.
;; 2. Cada cambio posterior lleva su comentario:
;;       ;; FIX <tipo><nº>: <motivo>      (tipos: N, E, S, F)
;; 3. Prueba: en main.asm, DEF TEST EQUS "test_ej06" y make.
;; 4. Rellena el resumen del final.
;;
;; Etiquetas internas: usa locales (.loop, .next...)
;;==============================================================
SECTION "Ejercicio 06", ROM0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; arena_cell_address ("Rutinas ya resueltas"):
;; 📥 B: row, C: column   🔙 HL: address of that cell
;; ❌ Modifies A, BC   ✅ Does NOT modify DE
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Checks whether there is any block in the
;; D cells right below the bomb.
;;
;; 📥 INPUT:
;;    B: bomb row
;;    C: bomb column
;;    D: number of cells to check below the bomb
;; 🔙 RETURNS (in the flag, not a register):
;;    Z,  if some cell is filled (the ray is blocked)
;;    NZ, if all D cells are empty
;;
bomb_ray_down_blocked::
    call arena_cell_address ;; FIX <S><1>
    ld bc, ARENA_WIDTH
    .loop:
    ld a, [hl]
    cp 0
    jr z, .cero
    xor a
    ret z
    .cero:
    add hl, bc
    dec d
    jr nz, .loop
    or 1
    ret

;; ==========================================================
;;  ENSAMBLA: SÍ  (SÍ / NO)
;; ==========================================================
;; === CASOS DE PRUEBA   (test_ej06 en main.asm)
;;  * Comprobar que CPU y MEM coinciden con valor esperado
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 1: OK  (OK / Falla) Ok
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= ....  ☑z  [PREVIO]> Bomba en (5,4). Bloque en (8,4). D=4: revisa
;; bc= ....  .n            filas 6-9.
;; de= ....  .h
;; hl= ....  .c
;;            flag Z: 1  ← Z = hay bloque · NZ = rayo libre
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C050  .. .. .. .. 00 .. .. ..|.. .. .. .. .. .. .. ..| ← fila 5: la bomba (5,4)
;; C060  .. .. .. .. 00 .. .. ..|.. .. .. .. .. .. .. ..| ← fila 6
;; C070  .. .. .. .. 00 .. .. ..|.. .. .. .. .. .. .. ..| ← fila 7
;; C080  .. .. .. .. 02 .. .. ..|.. .. .. .. .. .. .. ..| ← fila 8: bloque
;; C090  .. .. .. .. 00 .. .. ..|.. .. .. .. .. .. .. ..| ← fila 9
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; * CASO 2: Falla  (OK / Falla) Falla
;;
;;        >>>>> RESULTADO ESPERADO (Comprobar) <<<<<
;; [CPU]
;; af= ....  ◻z  [PREVIO]> Bomba en (5,4) con bloque encima, y otro
;; bc= ....  .n            justo tras el rayo (9,4). D=3: revisa filas
;; de= ....  .h            6-8.
;; hl= ....  .c
;;            flag Z: 0  ← Z = hay bloque · NZ = rayo libre
;;
;; [MEM] 00 01 02 03 04 05 06 07|08 09 0A 0B 0C 0D 0E 0F|
;; =====================================================|
;; C050  .. .. .. .. 02 .. .. ..|.. .. .. .. .. .. .. ..| ← fila 5: la bomba (5,4), con bloque
;; C060  .. .. .. .. 00 .. .. ..|.. .. .. .. .. .. .. ..| ← fila 6
;; C070  .. .. .. .. 00 .. .. ..|.. .. .. .. .. .. .. ..| ← fila 7
;; C080  .. .. .. .. 00 .. .. ..|.. .. .. .. .. .. .. ..| ← fila 8
;; C090  .. .. .. .. 02 .. .. ..|.. .. .. .. .. .. .. ..| ← fila 9: bloque, fuera del rayo
;; ==========================================================
;; === FIXES
;;  Tipo: Cant. => Tramos
;;  *  N:    __ => __     (1 fix = -1 tramo)
;;  *  E:    __ => __     (1 fix = -1 tramo)
;;  *  S:    1 => 0     (2 fix = -1 tramo. En grupos de 2 sólo)
;;  *  F:    __ => __     (2 fix = -1 tramo. En grupos de 2 sólo)
;;      TOTAL:     0 tramos
;;
;; EXPLICACIONES ADICIONALES DE FIXES (si es necesario)
;;  *
