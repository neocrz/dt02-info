# DT02-info

This repository contains a basic Love2D project designed to assist players of the game [DT02](https://dragonrod342.itch.io/digital-tamers-2). It provides functionalities for managing your Digimon boxes, calculating NP, and adding information about items, Digimon, and their evolution paths.

**Early stages...**

## `lib.ext`
-  [classic](https://github.com/rxi/classic)
- [ser](https://github.com/gvx/Ser)

## To-Do
- [ ] DigiData
    - [x] Digimon
        - status: basic
        - [x] Add
        - [x] Get 
        - [x] Remove 
        - [x] Update
    - [x] Digivolution
        - [x] Add
        - [x] Get 
        - [x] Remove 
        - [x] Update
    - [ ] Items
- [ ] PlayerData (PD)
    - [x] Digimon (on box, line, row)
        - [x] Add
        - [x] Get 
        - [x] Remove 
        - [x] Update
    - [ ] Inventory

## Structure
- `lib.digi_data` (DD in `globals.lua`)
    - Dependencies: `lib.ext.classic`
    - Contains information such as items, stages, base stats of Digimon, and evolution paths along with conditions.
    - Automatically saves a backup in the Love2D save folder (or in the current directory if running in the Lua interpreter) in the file `digi_data.lua`.
    - Attempts to load `digi_data.lua` on each startup.
    - `DD:save()` saves the file `digi_data.lua`.
    - Digimon
        - `DD:addDigi(digi_table)`
            - Adds a Digimon using data from `digi_table`.
            - Missing data will be filled in using data present in `DD.base_digi`.
            - Returns the ID of the Digimon.
        - `DD:rmDigi(digi_id)`
            - Removes the Digimon from both `DD.digis` and its relationships in Digivolutions (`DD.dv`).
        - `DD:getDigi(digi_id)`
            - returns the base stats of the Digi.
        - `DD:updDigi(digi_id, upd_elements)`
            - The table `upd_elements` can have the updated key-values only instead of every digi element
    - Digivolution
        - `DD:addDv(from_id,to_id,condition)`
            - `from_id`, `to_id`: digimon IDs.
            - `condition`: table containing condition strings.
        - `DD:updDv(from_id, to_id, new_condition)`
            - Update the condition of digivolution. It updates to the new table.
            - `new_condition`- table with all condition strings.
        - `DD:rmDv(from_id, to_id)`
        - `DD:getDv(digi_id)` - returns `{from, to}`
            - `from` table of digis that evolve to this digi + [digi]conditions.
            - `to` table of digis that this digi evolve to + [digi]conditions.
    - `lib.player_data` (PD in `globals.lua`)
        - digimon(boxes)
            - `PD:addDigi(box,line,row, digi_table)`
                - digi_table -> `digi_id, level, hp, attack, sp_attack, defense, sp_defense`
            - `PD:updDigi(box,line,row, digi_table)`
            - `PD:rmDigi(box,line,row)`
        - 