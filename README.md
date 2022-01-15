# CSC258-project-frogger

The .asm file should be run on MARS (e.g., MARS 4.5).

## Intruction for starting the game (for MARS): 
1. Run the file
2. Click on `Tools` -> `Bitmap Display` -> `Connect to MIPS` on the bottom left
3. Then, have the following configuration for bitmap display:
    - Unit width in pixels: 8
    - Unit height in pixels: 8
    - Display width in pixels: 256
    - Display height in pixels: 256
    - Base Address for Display: 0x10008000 ($gp)
  
4. Click on `Tools` -> `Keyboard and Display MMIO Simulator` -> `Connect to MIPS` on the bottom left
5. In the bottom text box, at the user key board, 
    - press `w` to move up by one block   
    - press `s` to move down by one block
    - press `a` to move left by one block
    - press `d` to move right by one block
    - press `r` to restart the game if all lives are used

## Rules for the game:
1. The wining goal is to move the frog to the top most green region. 
2. Every time the frog is moved to the top most green region, 100 points are earned for this game, and the newwest total is shown/updated on the MARS dialog.
3. The row that have red and black blocks moving represent cars (red) and road (black) on a row, and each time the frog is being hitted by the car, 1 live will be lost.
4. Similar to 3, the row that have blue and brown blocks moving represent lake (blue) and log (brown) on a row, and each time the frog falls into the lake (hit on blue region), 1 live will be lost.
5. After all 3 lives are used up, the screen shuts down, and you can press `r` to restart the game.

