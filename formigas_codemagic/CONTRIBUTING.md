# Contributing
## Continuous Integration
1. The CI pipeline for this brick creates a pull request updating the `codemagic.yaml` file in the [codemagic-ci-brick-ci](https://github.com/formigas/codemagic-ci-brick-ci/) repository to validate the codemagic workflow.  
2. Creating the pull request will trigger the workflow in the codemagic-ci-brick-ci repository. 
3. When successful, the pull request in the codemagic-ci-brick-ci repository will be merged automatically. 
4. The merge will trigger a workflow that adds the `codemagic-ci: success` label to the brick's pull request.
5. The label is used to indicate that the pull request has been validated and can be merged.

![codemagic-ci flow diagram](./docs/formigas_codemagic-brick-flow-diagram.svg)
