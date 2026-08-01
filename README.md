# three years

### TODO
- [x] Placement: Interpolate the player position and rotation
- [x] Eat: Add placements for the futon
- [x] Bug: Fix players can walk during dialogue
- [x] Bug: Fix camera zones overlapping
- [x] Flow: Implement player leave, game restart, etc
- [x] Infra: Implement Deployment
- [x] Cleaning: Write Dialogue
- [x] Prepping: Write Dialogue
- [x] Cooking: Write Dialogue
- [x] Eating: Write Dialogue
- [x] Implement Models and Animations
- [x] Implement Polishing
- [x] Cleaning: Implement Dirty and Cleaned Models
- [x] Cleaning: Implement circular progress bars
- [x] Cleaning: Implement Dialogue Events
- [x] General: Add room collisions
- [x] Cooking: Implement fridge animation
- [x] Cooking: Implement ingredient models
- [x] Eating: Add food models
- [ ] Eating: Add cameras
- [ ] Add Title Screen
- [ ] Add Game End Screen
- [ ] Polish Dialogue and Everything
- [ ] Deploy and Test!

## Models

### Essentials
- [x] Wato + Sitting + Moving
- [x] Alex + Sitting + Moving
- [x] Bed
- [x] Kotatsu
- [x] Floor Chairs
- [x] Natto
- [x] Pack of Pasta
- [x] Kitchen + Stove + Sick
- [x] Pantry
- [x] Wato's Cupboard
- [x] The boxes in the corner
- [x] Curtains and Window

### Still Waiting
- [x] Dining Chairs
- [x] Bathroom Door
- [x] Wardrobe
- [x] Main Door
- [x] Clean Items
- [x] Light
- [ ] Laptop


### Nice to Haves
- [x] Pink Mug
- [x] Derek
- [ ] Coffee Grinder
- [ ] Sharkie
- [ ] Sky Shader

## Polishing
- [x] UI: Fix UI to be responsive
- [x] UI: Add portraits to the dialogue box
- [x] Graphics: Some sort of post processing filter (A Short Hike esq?)
- [ ] Cleaning: Add clean particles
- [ ] Cleaning: Add clean sound effects

## Infra
I'm too lazy to setup CI/CD and proper infra, so we do this manually :)
Game is currently running on an AWS EC2 instance with an SSH port to a personal IP.

```shell
mise setup
mise deploy
mise run shell
> chmod +x ./linux-server/server.sh
> ./linux-server/server.sh
```
