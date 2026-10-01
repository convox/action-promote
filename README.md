# Convox Promote Action
This Action [Promotes](https://docs.convox.com/deployment/releases#promoting-a-release) a previously built app to Convox. You will typically need to perform the [Build](https://github.com/convox/action-build) action prior to running this action.

The step waits for the promotion to finish and fails if the release is rolled back. It runs the Convox V3 CLI, which works with both V2 and V3 racks.

## Inputs
### `rack`
**Required** The name of the [Convox Rack](https://docs.convox.com/introduction/rack) you wish to deploy to.
### `app`
**Required** The name of the [app](https://docs.convox.com/deployment/creating-an-application) you wish to deploy.
### `release`
**Optional** The ID of the [release](https://docs.convox.com/deployment/releases) you wish to promote. If you have run a [Build](https://github.com/convox/action-build) action as a previous step this step will promote the release created by that build step by default. You only need to set the release if you have not run a build step first or you wish to override the release id from the build step

## Example usage
```
steps:
- name: login
  uses: convox/action-login@v2
  with:
    password: ${{ secrets.CONVOX_DEPLOY_KEY }}
- name: build
  id: build
  uses: convox/action-build@v2
  with:
    rack: staging
    app: myapp
- name: promote
  uses: convox/action-promote@v1
  with:
    rack: staging
    app: myapp
```

## Racks without a Console
If you reach your rack directly rather than through a Convox Console, set `RACK_URL` on the step instead of using a Login step:
```
- name: promote
  uses: convox/action-promote@v1
  env:
    RACK_URL: https://convox:${{ secrets.RACK_PASSWORD }}@rack.example.com
  with:
    rack: staging
    app: myapp
```

## Troubleshooting
`ERROR: could not find rack` means the `rack` input does not match a rack name, or the deploy key is invalid, has expired, or has no access to that rack.

## Convox CLI version
This action installs the latest Convox CLI release when its image is built, so the action's version tag does not pin the CLI. On GitHub-hosted runners that happens on every run. On a self-hosted runner with a persistent Docker daemon, the CLI stays at the version cached in that daemon until its build cache is pruned.
