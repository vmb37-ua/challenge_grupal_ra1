DEF TEST EQUS "test_ej10"

;;==============================================================
;; Challenge 3 · Programa de pruebas
;;
;; 1. Elige el ejercicio: cambia test_ej01 por el que toque.
;; 2. make  →  abre game.gb en BGB.
;; 3. BGB se para en cada "ld b, b" (breakpoint).
;;    Compara BGB con el dibujo CPU/MEM del final del ejXX.asm.
;;    F9 (continuar) → siguiente caso.
;;
;; ❌ No modifiques las pruebas: solo la línea DEF TEST (arriba).
;;==============================================================
INCLUDE "chcode/common.inc"

SECTION "Entry point", ROM0[$150]

main::
   di
   ld  sp, $E000

   call {TEST}          ;; Llama al test indicado

.end
   jr  .end             ;; Fin de las pruebas


;; Solo se ensambla la prueba elegida en DEF TEST:
;; así, un ejercicio desactivado (.asm.no) no impide probar los demás.
INCLUDE "chcode/tests/{TEST}.inc"
