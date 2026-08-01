# three years

## Infra
I'm too lazy to setup CI/CD and proper infra, so we do this manually :)
Game is currently running on an AWS EC2 instance with an SSH port to a personal IP.

```shell
mise setup
mise deploy
mise run shell
> chmod +x ./linux-server/server.sh
> ./linux-server/server.sh

or with systemctl (see config in /etc/systemd/system/game.service)
sudo systemctl daemon-reload
sudo systemctl start game.service
sudo systemctl enable game.service
sudo systemctl status game.service # check status
```
