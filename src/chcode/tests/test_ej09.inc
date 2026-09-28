SECTION "Test ej09", ROM0

;;--------------------------------------------------------------
;; Ejercicio 9 · arena_count_blocks
;;--------------------------------------------------------------
test_ej09::
   ;; CASO 1 · arena llena de SOFT_BLOCK
   ld  a, SOFT_BLOCK
   call tst_fill_arena
   call arena_count_blocks
   ld  b, b       ;; ✔ Esperado → A = $D0 (208)

   ;; CASO 2 · centinela FALSO a mitad de arena (índice 50):
   ;;   2 bloques antes (5, 30) SÍ cuentan; 2 bloques después
   ;;   (100, 200) NO deben contarse: hay que parar en el índice 50
   xor a
   call tst_fill_arena
   ld a, HARD_BLOCK
   ld [arena + 5], a
   ld [arena + 30], a
   ld [arena + 100], a
   ld [arena + 200], a
   ld a, ARENA_SENTINEL
   ld [arena + 50], a
   call arena_count_blocks
   ld  b, b       ;; ✔ Esperado → A = $02

   ret
