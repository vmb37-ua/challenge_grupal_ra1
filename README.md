# Challenge 3 · Implementación y pruebas

## Qué tocar

- `src/ejXX.asm`: tu código. Un fichero por ejercicio.
- `src/main.asm`: solo la línea `DEF TEST EQUS "test_ejXX"`.
- `src/chcode/` : no tocar.

## Activa Breakpoints Software en BGB

1. Abre BGB `gbt_bgb`
2. *Options* (F11) → *Exceptions* → marca **break on ld b,b (40h)** (abajo a la izquierda).

## Mostrar símbolos en BGB

La primera vez que compiles con `make`:

1. Comprueba que hay un fichero `obj/game.sym`
2. Crea un enlace simbólico en la carpeta del proyecto (donde está el `Makefile`)
   - `ln -s obj/game.sym`

## Depurar y evaluar Ejercicio XX

1. Copia tu código del papel a `ejXX.asm`, **tal cual**.
2. Cada cambio posterior, con su comentario `;; FIX <tipo><nº>: <motivo>`.
3. Elige `test_ejXX` en `main.asm` y ejecuta `make`.
4. Abre `game.gb` en BGB.
5. Ejecuta con F9.
6. Cada parada en un *-source code breakpoint-* ($40) es un CASO DE PRUEBA.
   - Compara CPU y MEM con el RESULTADO ESPERADO de `ejXX.asm`
   - Corrige si no es correcto.
7. F9 continúa al siguiente caso.
8. Rellena el resumen final en `ejXX.asm`.

## Si un ejercicio no ensambla (errores)

Renómbralo a `ejXX.asm.no`.
Así deja de ensamblar y puedes probar el resto mientras.

## Ejercicios que usan otros

Los ejercicios 3, 5, 6, 10 y 11 usan versiones de referencia de
`arena_cell_address` y `arena_box_fits`.
Un fallo en los ejercicios 2 o 12 no afecta a los demás.

Tus versiones se llaman `team_arena_cell_address` (ej02) 
y `team_arena_box_fits` (ej12). Ya vienen así: no cuenta como FIX.

## Ejercicio 7

Es interactivo.
Pulsa ↓ y ↑: se para cada vez que cambia la fila del jugador.
