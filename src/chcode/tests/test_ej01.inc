SECTION "Test ej01", ROM0

;;--------------------------------------------------------------
;; Ejercicio 1 · arena_init
;;--------------------------------------------------------------
test_ej01::
   ;; CASO 1 · RAM con basura ($AA) → primera celda y jugador
   ld  a, $AA
   call tst_dirty_ram
   call arena_init
   ld  a, [arena]
   ld  hl, player_row
   ld  d, [hl]
   inc hl
   ld  e, [hl]
   ld  b, b       ;; ✔ Esperado → A = $02 · D = $01 · E = $01

   ;; CASO 2 · RAM con basura ($55) → última celda y centinela
   ld  a, $55
   call tst_dirty_ram
   call arena_init
   ld  a, [arena + ARENA_SIZE - 1]
   ld  hl, arena_sentinel
   ld  d, [hl]
   ld  b, b       ;; ✔ Esperado → A = $02 · D = $80
   ret
