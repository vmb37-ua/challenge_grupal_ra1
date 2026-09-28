SECTION "Test ej08", ROM0

;;--------------------------------------------------------------
;; Ejercicio 8 · arena_render_to_tilemap
;;   Apaga la pantalla para poder escribir en VRAM.
;;   Tilemap relleno de $FF: lo que no se toca, sigue en $FF.
;;--------------------------------------------------------------
DEF TST_TILEMAP = $9822

test_ej08::
   call tst_lcd_off
   ld  a, $FF
   call tst_fill_tilemap
   xor a
   call tst_fill_arena
   ld  a, $01
   ld  [arena], a                                ;; (0,0)
   ld  a, $02
   ld  [arena + 6 * ARENA_WIDTH], a              ;; (6,0)
   ld  a, $03
   ld  [arena + 12 * ARENA_WIDTH + 15], a        ;; (12,15)
   call arena_render_to_tilemap

   ;; CASO 1 · A = celda (0,0) · D = celda (6,0)
   ;;   E = tilemap justo a la derecha de la fila 0 (no se toca)
   ld  a, [TST_TILEMAP]
   ld  hl, TST_TILEMAP + 6 * TILEMAP_WIDTH
   ld  d, [hl]
   ld  hl, TST_TILEMAP + ARENA_WIDTH
   ld  e, [hl]
   ld  b, b       ;; ✔ Esperado → A = $01 · D = $02 · E = $FF

   ;; CASO 2 · A = última celda (12,15)
   ;;   D = tilemap justo debajo de la última fila (no se toca)
   ld  a, [TST_TILEMAP + 12 * TILEMAP_WIDTH + 15]
   ld  hl, TST_TILEMAP + 13 * TILEMAP_WIDTH
   ld  d, [hl]
   ld  b, b       ;; ✔ Esperado → A = $03 · D = $FF
   ret
