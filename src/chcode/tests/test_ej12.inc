SECTION "Test ej12", ROM0

;;--------------------------------------------------------------
;; Ejercicio 12 · arena_box_fits (team_arena_box_fits)
;;--------------------------------------------------------------
test_ej12::
   ;; CASO 1 · rectángulo 4x3 en (2,3): cabe
   ld  b, 2
   ld  c, 3
   ld  d, 4
   ld  e, 3
   call team_arena_box_fits
   ld  b, b       ;; ✔ Esperado → Z · B = 2 · C = 3 · D = 4 · E = 3

   ;; CASO 2 · rectángulo 4x3 en (2,12): 12+4 = 16, pisa el muro
   ld  b, 2
   ld  c, 12
   ld  d, 4
   ld  e, 3
   call team_arena_box_fits
   ld  b, b       ;; ✔ Esperado → NZ · B = 2 · C = 12 · D = 4 · E = 3
   ret
