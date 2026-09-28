SECTION "Test ej06", ROM0

;;--------------------------------------------------------------
;; Ejercicio 6 · bomb_ray_down_blocked
;;   Usa arena_cell_address de referencia (no la del Ej.2).
;;--------------------------------------------------------------
test_ej06::
   ;; CASO 1 · bomba (5,4), D=4 (filas 6..9): bloque en (8,4)
   xor a
   call tst_fill_arena
   ld  a, SOFT_BLOCK
   ld  [arena + 8 * ARENA_WIDTH + 4], a
   ld  b, 5
   ld  c, 4
   ld  d, 4
   call bomb_ray_down_blocked
   ld  b, b       ;; ✔ Esperado → Z (hay bloque)

   ;; CASO 2 · bomba (5,4), D=3 (filas 6..8): bloques FUERA del rayo,
   ;;   en la propia bomba (5,4) y justo debajo del final (9,4)
   xor a
   call tst_fill_arena
   ld  a, SOFT_BLOCK
   ld  [arena + 5 * ARENA_WIDTH + 4], a
   ld  [arena + 9 * ARENA_WIDTH + 4], a
   ld  b, 5
   ld  c, 4
   ld  d, 3
   call bomb_ray_down_blocked
   ld  b, b       ;; ✔ Esperado → NZ (rayo libre)
   ret
