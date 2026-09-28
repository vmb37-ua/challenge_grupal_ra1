SECTION "Test ej04", ROM0

;;--------------------------------------------------------------
;; Ejercicio 4 · player_next_to_bomb
;;--------------------------------------------------------------
test_ej04::
   ;; CASO 1 · bomba (5,7) · jugador (5,6): justo a su izquierda
   ld  bc, $0507
   ld  de, $0506
   call tst_set_bomb_player
   call player_next_to_bomb
   ld  b, b       ;; ✔ Esperado → Z

   ;; CASO 2 · bomba (5,7) · jugador (6,8): columna al lado, OTRA fila
   ld  bc, $0507
   ld  de, $0608
   call tst_set_bomb_player
   call player_next_to_bomb
   ld  b, b       ;; ✔ Esperado → NZ
   ret
