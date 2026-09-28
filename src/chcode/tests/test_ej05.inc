SECTION "Test ej05", ROM0

;;--------------------------------------------------------------
;; Ejercicio 5 · arena_copy_row_up
;;   Usa arena_cell_address de referencia (no la del Ej.2).
;;--------------------------------------------------------------
test_ej05::
   ;; CASO 1 · fila 6 ($01..$10) → fila 5
   ;;   A = fila 5 col 0 · D = fila 5 col 15 · E = fila 6 col 0
   xor a
   call tst_fill_arena
   ld  hl, arena + 6 * ARENA_WIDTH
   ld  a, $01
   call tst_ramp
   ld  b, 6
   call arena_copy_row_up
   ld  a, [arena + 5 * ARENA_WIDTH]
   ld  hl, arena + 5 * ARENA_WIDTH + 15
   ld  d, [hl]
   ld  hl, arena + 6 * ARENA_WIDTH
   ld  e, [hl]
   ld  b, b       ;; ✔ Esperado → A = $01 · D = $10 · E = $01

   ;; CASO 2 · última fila (12, $31..$40) → fila 11
   ;;   A = fila 11 col 0 · D = fila 11 col 15 · E = fila 10 col 0
   xor a
   call tst_fill_arena
   ld  hl, arena + 12 * ARENA_WIDTH
   ld  a, $31
   call tst_ramp
   ld  b, 12
   call arena_copy_row_up
   ld  a, [arena + 11 * ARENA_WIDTH]
   ld  hl, arena + 11 * ARENA_WIDTH + 15
   ld  d, [hl]
   ld  hl, arena + 10 * ARENA_WIDTH
   ld  e, [hl]
   ld  b, b       ;; ✔ Esperado → A = $31 · D = $40 · E = $00
   ret
