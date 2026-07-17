# three years

### TODO
- [x] Placement: Interpolate the player position and rotation
- [x] Eat: Add placements for the futon
- [x] Bug: Fix players can walk during dialogue
- [x] Bug: Fix camera zones overlapping
- [x] Flow: Implement player leave, game restart, etc
- [x] Infra: Implement Deployment
- [ ] Cleaning: Write Dialogue
- [ ] Prepping: Write Dialogue
- [ ] Cooking: Write Dialogue
- [ ] Eating: Write Dialogue
- [ ] Dialogue: Implement Typewriter
- [ ] Cleaning: Implement Clean Together Event

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
