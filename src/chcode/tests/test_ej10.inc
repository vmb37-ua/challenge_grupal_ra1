SECTION "Test ej10", ROM0

;;--------------------------------------------------------------
;; Ejercicio 10 · arena_blast_cross
;;   Usa arena_box_fits y arena_cell_address de referencia
;;   (no las de los Ej.12 y Ej.2). Arena llena de SOFT_BLOCK ($02).
;;--------------------------------------------------------------
test_ej10::
   ;; CASO 1 · cruz con esquina en (3,4): cabe
   ;;   A = centro (4,5) · D = esquina del cuadro (3,4) · E = abajo (5,5)
   ld  a, SOFT_BLOCK
   call tst_fill_arena
   ld  b, 3
   ld  c, 4
   call arena_blast_cross
   ld  a, [arena + 4 * ARENA_WIDTH + 5]
   ld  hl, arena + 3 * ARENA_WIDTH + 4
   ld  d, [hl]
   ld  hl, arena + 5 * ARENA_WIDTH + 5
   ld  e, [hl]
   ld  b, b       ;; ✔ Esperado → Z · A = $00 · D = $02 · E = $00

   ;; CASO 2 · esquina en (1,13): la columna 15 es muro, no cabe
   ;;   A = centro (2,14): no debe cambiar
   ld  a, SOFT_BLOCK
   call tst_fill_arena
   ld  b, 1
   ld  c, 13
   call arena_blast_cross
   ld  a, [arena + 2 * ARENA_WIDTH + 14]
   ld  b, b       ;; ✔ Esperado → NZ · A = $02
   ret
