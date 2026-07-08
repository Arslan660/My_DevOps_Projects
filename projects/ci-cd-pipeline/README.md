# CI/CD Pipeline with GitHub Actions

A complete, multi-stage CI/CD pipeline for a Node.js application — from code to a running container on a server — built entirely with **GitHub Actions**.

## Pipeline Stages

```
Lint → Test → Build (+ vulnerability scan) → Push to Docker Hub → Deploy to EC2
```

| Stage | What Happens |
|---|---|
| **Lint** | Installs dependencies and runs the linter |
| **Test** | Runs a smoke test against the running app |
| **Build** | Builds the Docker image and scans it for vulnerabilities with Trivy |
| **Push** | Pushes the image to Docker Hub, tagged with both `latest` and the commit SHA (main branch only) |
| **Deploy** | SSHes into an EC2 instance, pulls the new image, and restarts the container (main branch only) |

Pull requests run Lint → Test → Build only. Push and Deploy only run on `main`, so nothing gets deployed from an unreviewed branch.

## Tech Stack
- Node.js + Express-style HTTP server
- Docker
- GitHub Actions
- Trivy (container vulnerability scanning)
- Docker Hub (image registry)

## Project Structure
```
ci-cd-pipeline/
├── .github/workflows/pipeline.yml   # 5-stage pipeline definition
├── app/
│   ├── index.js
│   ├── test.js          # smoke test
│   ├── package.json
│   └── Dockerfile
└── README.md
```

## Required GitHub Secrets
| Secret | Purpose |
|---|---|
| `DOCKERHUB_USERNAME` | Docker Hub login |
| `DOCKERHUB_TOKEN` | Docker Hub access token |
| `EC2_HOST` | Public IP/DNS of the deploy target |
| `EC2_USERNAME` | SSH username (e.g. `ubuntu`) |
| `EC2_SSH_KEY` | Private SSH key for the EC2 instance |

*(If you don't have an EC2 instance to deploy to, the pipeline still runs Lint → Test → Build → Scan successfully — only the final Deploy job needs these secrets.)*

## Running Locally
```bash
cd app
npm install
npm start        # starts the server
npm test         # runs the smoke test
```

## What I Learned
- Structuring a CI/CD pipeline into independent, dependent stages using `needs:`
- Gating destructive steps (push, deploy) to only run on the `main` branch with `if:` conditions
- Adding container vulnerability scanning (Trivy) as part of the build stage
- Using GitHub Actions cache (`type=gha`) to speed up repeated Docker builds
- Automating deployment via SSH using encrypted GitHub Secrets instead of hardcoded credentials
