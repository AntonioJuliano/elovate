# Elovate

Easily add elo ranking to any game or league.

## Setup

* On console run: ```sh script/start```

Then visit url printed by script to visit site. This will take a while the first time, but should be faster after that.
Note: setup script is OSX only, for any other OS [Install Docker](https://docs.docker.com/engine/installation/) then run: `docker-compose up`

### Other Commands
* Shutdown server: `sh script/stop`
* Start rails console:```sh script/console```
* Run rspec: `sh script/rspec`
 * Run rspec on specific file/test: `sh script/rspec spec/models/user_spec.rb`
* If you want go get fancy and run any other command: `docker-compose run web [COMMAND]`
