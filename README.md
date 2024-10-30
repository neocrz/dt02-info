# DT02-info

This repository contains a basic Love2D project designed to assist players of the game [DT02](https://dragonrod342.itch.io/digital-tamers-2). It provides functionalities for managing your Digimon boxes, calculating NP, and adding information about items, Digimon, and their evolution paths.

## `lib.ext`
-  [classic](https://github.com/rxi/classic)
- [ser](https://github.com/gvx/Ser)

## To-Do
- [ ] DigiData
    - [ ] Digimon
        - status: basic
        - [x] Add 
            - `DD:addDigi(digi_table)`
        - [x] Remove 
            - `DD:rmDigi(digi_id)`
        - [x] Get 
            - `DD:getDigi(digi_id)`
        - [ ] Update
    - [ ] Digivolution
        - [x] Add
        - [ ] Remove
        - [x] Get
        - [ ] Update
    - [ ] Items
- [ ] PlayerData (PD)
    - [ ] Digi Boxes
        - [ ] Digimon
            - [ ] NP calc
    - [ ] Inventory

## Structure
- `lib.digi_data` (DD in `globals.lua`)
    - Dependencies: `lib.ext.classic`
    - Contains information such as items, stages, base stats of Digimon, and evolution paths along with conditions.
    - Automatically saves a backup in the Love2D save folder (or in the current directory if running in the Lua interpreter) in the file `digi_data.lua`.
    - Attempts to load `digi_data.lua` on each startup.
    - `DD:save()` saves the file `digi_data.lua`.
    - `DD:addDigi(digi_table)`
        - Adds a Digimon using data from `digi_table`.
        - Missing data will be filled in using data present in `DD.base_digi`.
        - Returns the ID of the Digimon.
    - `DD:rmDigi(digi_id)`
        - Removes the Digimon from both `DD.digis` and its relationships in Digivolutions (`DD.dv`).
    - `DD:getDigi(digi_id)`
        - returns the base stats of the Digi.