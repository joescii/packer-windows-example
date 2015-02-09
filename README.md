# packer-windows-example
Example project using Packer's Windows EC2 support
This complete example has been tested and works well on [codeship](http://codeship.io).

NOTE: This is by no means an ad for codeship.
I have no affiliation with codeship.
I'm just a happy customer.

## Trying It Yourself
1. Fork this project.
2. Sign up at [codeship](http://codeship.io) (Don't worry, it is free).
3. Add the fork as the repo of a new project.
4. Leave the test commands default (i.e. none).
5. Select _Custom Script_ for Deployment.
6. Enter this as your script:

  ```shell
  chmod 700 ./build.sh
  ./build.sh
  ```
7. Add two environment variables for your `aws_access_key` and `aws_secret_key`.
The IAM Profile will need the minimal set of permissions to work specified on [Packer's Amazon AMI Builder page](https://www.packer.io/docs/builders/amazon.html).
8. Commit and push a change in the forked project to github.
9. Watch it build.
The build should complete under 15 minutes.
It will spit out a bunch of XML from [this powershell command](https://github.com/joescii/packer-windows-example/blob/master/packer.json#L29).
Then it will [upload the LICENSE](https://github.com/joescii/packer-windows-example/blob/master/packer.json#L33-L35) to show that we touched the AMI.
You can re-run this build as often as you like in the codeship console without pushing more changes.

## This Branch
In this branch, I am trying to set the WinRM port to 80.

## Current Build Status
[ ![Codeship Status for joescii/packer-windows-example](https://codeship.com/projects/8ad05190-91ef-0132-a852-4ad5c42ca09f/status?branch=port-80)](https://codeship.com/projects/61776)
