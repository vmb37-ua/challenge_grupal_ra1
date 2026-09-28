SECTION "Test ej07", ROM0

;;--------------------------------------------------------------
;; Ejercicio 7 · player_move_down / player_move_from_joypad
;;   Prueba interactiva: se para (ld b, b) cada vez que cambia
;;   player_row, con A = nueva fila. El jugador empieza en la fila 6.
;;--------------------------------------------------------------
test_ej07::
   ;; CASO 1 · pulsa ↓ varias veces:
   ;;   ✔ Esperado → A = 7, 8, 9, 10, 11 y se queda en 11 (no para más)
   ;; CASO 2 · pulsa ↑ varias veces:
   ;;   ✔ Esperado → A baja hasta 1 y se queda en 1 (no para más)
   ld  a, 6
   ld  [player_row], a
   ld  [tst_prev_row], a
   ld  a, 3
   ld  [player_col], a
.loop
   call player_move_from_joypad
   ld  a, [tst_prev_row]
   ld  b, a
   ld  a, [player_row]
   cp  b
   jr  z, .loop
   ld  [tst_prev_row], a
   ld  b, b       ;; ✔ A = nueva fila (ver casos arriba)
   jr  .loop
