# Contributing
## Continuous Integration
1. The CI pipeline for this brick creates a pull request updating the `.github/workflows/continuous-integration.yml` file in the [formigas_github_actions-brick-ci](https://github.com/formigas/formigas_github_actions-brick-ci/) repository to validate the Github Actions workflow.  
2. Creating the pull request will trigger the workflow in the formigas_github_actions-brick-ci repository. 
3. When successful, the pull request in the formigas_github_actions-brick-ci repository will be merged automatically. 
4. The merge will trigger a workflow that adds the `github-actions-ci: success` label to the brick's pull request.
5. The label is used to indicate that the pull request has been validated and can be merged.

![github-actions-ci flow diagram](./docs/formigas_github_actions-brick-flow-diagram.svg)
