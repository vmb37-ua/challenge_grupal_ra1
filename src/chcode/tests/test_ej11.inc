SECTION "Test ej11", ROM0

;;--------------------------------------------------------------
;; Ejercicio 11 · arena_stamp_pattern
;;   Usa arena_cell_address de referencia (no la del Ej.2).
;;--------------------------------------------------------------
test_ej11::
   ;; CASO 1 · patrón del enunciado: (3,5) (3,6) (4,6) (4,7)
   ;;   A = (3,5) · D = (4,7) · E = (4,5), que no es del patrón
   xor a
   call tst_fill_arena
   ld  hl, tst_pattern1
   call arena_stamp_pattern
   ld  a, [arena + 3 * ARENA_WIDTH + 5]
   ld  hl, arena + 4 * ARENA_WIDTH + 7
   ld  d, [hl]
   ld  hl, arena + 4 * ARENA_WIDTH + 5
   ld  e, [hl]
   ld  b, b       ;; ✔ Esperado → A = $03 · D = $03 · E = $00

   ;; CASO 2 · patrón de una sola celda: (7,9)
   ;;   A = (7,9) · D = (9,7), con fila y columna cambiadas
   xor a
   call tst_fill_arena
   ld  hl, tst_pattern2
   call arena_stamp_pattern
   ld  a, [arena + 7 * ARENA_WIDTH + 9]
   ld  hl, arena + 9 * ARENA_WIDTH + 7
   ld  d, [hl]
   ld  b, b       ;; ✔ Esperado → A = $03 · D = $00
   ret
