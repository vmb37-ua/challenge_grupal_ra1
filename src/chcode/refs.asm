;;==============================================================
;; Challenge 3 · Versiones de REFERENCIA (en binario)
;;   Las usan los ejercicios que dependen de otros:
;;    - arena_cell_address (Ej.2) → Ej. 3, 5, 6, 10, 11
;;    - arena_box_fits     (Ej.12) → Ej. 10
;;   Así cada ejercicio se prueba aislado: un fallo en el Ej.2
;;   o el Ej.12 no hace fallar a los demás.
;;   Tus versiones se llaman team_arena_cell_address y
;;   team_arena_box_fits (en ej02.asm y ej12.asm).
;;   ❌ No lo modifiques
;;==============================================================
INCLUDE "chcode/common.inc"

SECTION "Reference routines", ROM0

;; 📥 B: row, C: column   🔙 HL: address of that cell
;; ❌ Modifies A, BC   ✅ Does NOT modify DE
arena_cell_address::
   INCBIN "chcode/bin/arena_cell_address.bin"
   DW arena
   DB $09, $C9

;; 📥 B: row, C: column, D: width, E: height
;; 🔙 Z: fits inside the playable area, NZ: it does not
;; ❌ Modifies A       ✅ Does NOT modify BC, DE
arena_box_fits::
   INCBIN "chcode/bin/arena_box_fits.bin"
