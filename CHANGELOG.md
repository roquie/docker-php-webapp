## [1.1.0] - 10-02-2019
### PHP 7.3
- Fixed failed travis build (gpg tty problem)
- Support multiple PHP versions
- Add new docker tags `php7.2-latest` and `php7.3-latest`

## [1.0.1] - 02-10-2018
### Bugfix
- Fixed container quitting when user send `Ctrl+C` input

## [1.0.0] - 21-09-2018
### First stable version
- Drop varrick template engine because his doesn't work in kubernetes cluster
- Use more fastest and stable roquie/smalte template engine
- Reduce image size
- Added NGINX_ACCESS_LOG env variable

## [0.1.0] - 15-06-2018
### First version
- Created Docker image with thrully features.
