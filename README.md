# Incver

A simple binary to update Semver.

## Installation

curl release.github.com... -o /usr/bin/incver
chmod +x /usr/bin/incver

## Usage

Incver only exposes three arguments. These args aren't combinable on the same command.

```bash
echo "1.0.0" | incver +major
> 2.0.0

echo "1.0.0" | incver +minor
> 1.1.0

echo "1.0.0" | incver +patch
> 1.0.1

echo "1.0.0" | incver +major | incver +minor
> 2.1.0
```

## Integration with yq

```bash
cat test.yml
# version: 1.0.0

# 1/ retrieve the value in YAML file
# 2/ Update from STDIN and return new SEMVER
# 3/ Updates the YAML file with new value
yq read test.yml "version" | \
    ./incver +major | \
    yq write -i test.yml "version" --from -

# cat test.yml
2.0.0
```

## Development

* clone the repository
* update `src/incver.cr`
* create tests in `spec/`
* push.
