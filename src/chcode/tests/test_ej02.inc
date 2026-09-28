SECTION "Test ej02", ROM0

;;--------------------------------------------------------------
;; Ejercicio 2 · arena_cell_address / arena_set_cell
;;--------------------------------------------------------------
test_ej02::
   ;; CASO 1 · team_arena_cell_address (fila 5, columna 7)
   ;;   BC no es parte del contrato (arena_cell_address puede
   ;;   modificarlo): no se comprueba.
   ld  b, 5
   ld  c, 7
   ld  de, $1234
   call team_arena_cell_address
   ld  b, b       ;; ✔ Esperado → HL = $C057 · DE = $1234

   ;; CASO 2 · arena_set_cell en la última celda (12, 15)
   ld  a, SOFT_BLOCK
   call tst_fill_arena
   ld  b, 12
   ld  c, 15
   ld  e, HARD_BLOCK
   call arena_set_cell
   ld  hl, arena + ARENA_SIZE - 1
   ld  d, [hl]
   ld  b, b       ;; ✔ Esperado → A = $02 (antes) · D = $03 (ahora)
   ret
