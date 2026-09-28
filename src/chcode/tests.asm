INCLUDE "chcode/common.inc"

;;##############################################################
;;  AUXILIARES DE LAS PRUEBAS (no hace falta leerlas)
;;##############################################################
SECTION "Test data", ROM0
tst_row4:      ;; 6 HARD_BLOCK ($03)
   DB $03, $00, $03, $02, $00, $03, $03, $00
   DB $03, $02, $00, $00, $03, $00, $00, $02
tst_pattern1:  ;; Y=3, X=5: R, D, R
   DB 3, 5, $FE, $F7, $FE, 0
tst_pattern2:  ;; Y=7, X=9: una sola celda
   DB 7, 9, 0

SECTION "Test vars", WRAM0
tst_prev_row: DS 1

SECTION "Test helpers", ROM0

;; HL: dst · B: count · A: value
tst_memset:
   ld  [hl+], a
   dec b
   jr  nz, tst_memset
   ret

;; HL: src · DE: dst · B: count
tst_memcpy:
   ld  a, [hl+]
   ld  [de], a
   inc de
   dec b
   jr  nz, tst_memcpy
   ret

;; HL: dst · A: first value · writes A, A+1 ... (ARENA_WIDTH bytes)
tst_ramp:
   ld  b, ARENA_WIDTH
.next
   ld  [hl+], a
   inc a
   dec b
   jr  nz, .next
   ret

;; A: value → every arena cell. Also sets the sentinel.
tst_fill_arena:
   ld  hl, arena
   ld  b, ARENA_SIZE
   call tst_memset
   ld  a, ARENA_SENTINEL
   ld  [arena_sentinel], a
   ret

;; A: garbage → arena, sentinel, player and bomb
tst_dirty_ram:
   ld  hl, arena
   ld  b, ARENA_SIZE + 1
   call tst_memset
   ld  hl, player_row
   ld  [hl+], a
   ld  [hl], a
   ld  hl, bomb_row
   ld  [hl+], a
   ld  [hl], a
   ret

;; B,C: bomb (row, col) · D,E: player (row, col)
tst_set_bomb_player:
   ld  hl, bomb_row
   ld  [hl], b
   inc hl
   ld  [hl], c
   ld  hl, player_row
   ld  [hl], d
   inc hl
   ld  [hl], e
   ret


;; A: value → whole tilemap $9800-$9BFF
tst_fill_tilemap:
   ld  hl, $9800
   ld  c, 4
.page
   ld  b, 0             ;; 256 bytes
.byte
   ld  [hl+], a
   dec b
   jr  nz, .byte
   dec c
   jr  nz, .page
   ret

;; Turns the screen off (waits for VBLANK). Safe if already off.
tst_lcd_off:
   ldh a, [$FF40]
   bit 7, a
   ret z
.wait
   ldh a, [$FF44]
   cp  144
   jr  c, .wait
   ldh a, [$FF40]
   res 7, a
   ldh [$FF40], a
   ret
