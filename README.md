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
- [ ] Implement Models and Animations
- [ ] Implement Polishing
- [ ] Cleaning: Implement Clean Together Event
- [ ] Cleaning: Implement Dirty and Cleaned Models

## Models

### Essentials
- [x] Wato + Sitting + Moving
- [x] Alex + Sitting + Moving
- [x] Bed
- [x] Kotatsu
- [x] Floor Chairs
- [ ] Natto
- [ ] Pack of Pasta
- [x] Kitchen + Stove + Sick
- [x] Pantry
- [x] Wato's Cupboard
- [x] The boxes in the corner
- [x] Curtains and Window
- [ ] Dirty Laundry

### Nice to Haves
- [ ] Pink Mug
- [ ] Coffee Grinder
- [ ] Derek
- [ ] Sharkie
- [ ] Chair


## Polishing
- [ ] UI: Fix UI to be responsive
- [ ] UI: Add portraits to the dialogue box
- [ ] Cleaning: Add clean together
- [ ] Graphics: Some sort of post processing filter (A Short Hike esq?)

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
