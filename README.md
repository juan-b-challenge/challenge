# Challenge

## Dockerized development

To get started checkout the project, then execute `./dev-setup.sh`

To run the app: `docker-compose up`

Now you can check the health of the web server by running this command from your console:
`curl -X POST localhost:8080/check`

You should see `{"health":"ok"}` as a response.

To open a shell in a container: `docker exec -it challenge_app_1 bash`, where `challenge_app_1` is a container name. You can list containers with `docker ps`.

To start an Elixir console in your running Phoenix app container: `docker exec -it challenge_app_1 iex -S mix`.

Finally, to check that everything is running fine, you can run the tests with the following command: `docker-compose run --rm -e MIX_ENV=test app mix test`


## Learn more about Phoenix

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
