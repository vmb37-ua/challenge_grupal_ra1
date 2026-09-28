SECTION "Test ej03", ROM0

;;--------------------------------------------------------------
;; Ejercicio 3 · arena_count_in_row
;;   Usa arena_cell_address de referencia (no la del Ej.2).
;;--------------------------------------------------------------
test_ej03::
   ;; CASO 1 · fila 4 con 6 HARD_BLOCK (resto de la arena: HARD_BLOCK)
   ld  a, HARD_BLOCK
   call tst_fill_arena
   ld  hl, tst_row4
   ld  de, arena + 4 * ARENA_WIDTH
   ld  b, ARENA_WIDTH
   call tst_memcpy
   ld  b, 4
   ld  e, HARD_BLOCK
   call arena_count_in_row
   ld  b, b       ;; ✔ Esperado → A = $06

   ;; CASO 2 · última fila (12) llena de SOFT_BLOCK (resto: vacío)
   xor a
   call tst_fill_arena
   ld  hl, arena + 12 * ARENA_WIDTH
   ld  a, SOFT_BLOCK
   ld  b, ARENA_WIDTH
   call tst_memset
   ld  b, 12
   ld  e, SOFT_BLOCK
   call arena_count_in_row
   ld  b, b       ;; ✔ Esperado → A = $10 (16)
   ret
